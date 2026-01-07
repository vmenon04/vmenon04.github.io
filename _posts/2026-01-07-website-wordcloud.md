---
layout: post
title: "Word Cloud: Most Common Words on This Website"
date: 2026-01-07
excerpt: An interactive D3.js word cloud visualization showing the most frequently used words across this website.
---

This page generates a word cloud from all the text content on this website where the size of each word reflects its frequency. The word cloud updates based on the current content of the website, so it'll evolve as new posts and projects are added. The word cloud is generated using logic adapted from the [Observable D3 word cloud example](https://observablehq.com/@d3/word-cloud).

<!--  -->
<!-- Copyright 2020-2023 Observable, Inc. -->

<div id="wordcloud" style="width: 100%; height: 600px; margin: 20px 0;"></div>

<script src="https://d3js.org/d3.v7.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/d3-cloud@1.2.7/build/d3.layout.cloud.min.js"></script>

<script>
  // Common stop words and technical terms to exclude
  const stopWords = new Set([
    'the', 'be', 'to', 'of', 'and', 'a', 'in', 'that', 'have', 'i',
    'it', 'for', 'not', 'on', 'with', 'he', 'as', 'you', 'do', 'at',
    'this', 'but', 'his', 'by', 'from', 'they', 'we', 'say', 'her', 'she',
    'or', 'an', 'will', 'my', 'one', 'all', 'would', 'there', 'their',
    'what', 'so', 'up', 'out', 'if', 'about', 'who', 'get', 'which', 'go',
    'me', 'when', 'make', 'can', 'like', 'time', 'no', 'just', 'him', 'know',
    'take', 'people', 'into', 'year', 'your', 'good', 'some', 'could', 'them',
    'see', 'other', 'than', 'then', 'now', 'look', 'only', 'come', 'its', 'over',
    'think', 'also', 'back', 'after', 'use', 'two', 'how', 'our', 'work',
    'first', 'well', 'way', 'even', 'new', 'want', 'because', 'any', 'these',
    'give', 'day', 'most', 'us', 'is', 'was', 'are', 'been', 'has', 'had',
    'were', 'said', 'did', 'having', 'may', 'such', 'being', 'am', 'does',
    // Technical/HTML/PDF terms
    'endobj', 'stream', 'endstream', 'length', 'filter', 'flatedecode', 'type',
    'length1', 'length2', 'length3', 'subtype', 'otimes', 'obj', 'xref', 'startxref',
    'null', 'font', 'fontdescriptor', 'widths', 'bbox', 'fontfile', 'nbsp', 'mdash', 'ndash',
    'href', 'http', 'https', 'www', 'html', 'span', 'div',
    'xobject', 'procset', 'imageb', 'imagec', 'imagei', 'xheight', 'capheight',
    'ascent', 'descent', 'stemv', 'italicangle', 'flags', 'fontbbox', 'fontname'
  ]);

  async function fetchPageText(url) {
    try {
      // Convert absolute URLs to relative paths for local fetching
      let path = url;
      if (url.startsWith('http')) {
        const urlObj = new URL(url);
        path = urlObj.pathname;
      }
      
      console.log('Fetching:', path);
      const response = await fetch(path);
      
      if (!response.ok) {
        console.warn(`Failed to fetch ${path}: ${response.status}`);
        return '';
      }
      
      const html = await response.text();
      const parser = new DOMParser();
      const doc = parser.parseFromString(html, 'text/html');
      
      // Remove script and style elements
      const scripts = doc.querySelectorAll('script, style, nav, footer, header');
      scripts.forEach(el => el.remove());
      
      // Get text content
      const text = doc.body.textContent || '';
      console.log(`Extracted ${text.length} characters from ${path}`);
      return text;
    } catch (error) {
      console.error(`Error fetching ${url}:`, error);
      return '';
    }
  }

  async function getAllPageURLs() {
    try {
      console.log('Fetching sitemap...');
      const response = await fetch('/sitemap.xml');
      
      if (!response.ok) {
        throw new Error(`Sitemap fetch failed: ${response.status}`);
      }
      
      const xml = await response.text();
      const parser = new DOMParser();
      const xmlDoc = parser.parseFromString(xml, 'text/xml');
      const locs = xmlDoc.querySelectorAll('loc');
      const urls = Array.from(locs)
        .map(loc => loc.textContent)
        .filter(url => !url.toLowerCase().endsWith('.pdf')); // Exclude PDFs
      console.log(`Found ${urls.length} URLs in sitemap (PDFs excluded)`);
      return urls;
    } catch (error) {
      console.error('Error fetching sitemap:', error);
      console.log('Using fallback page list');
      // Fallback to known pages
      return [
      ];
    }
  }

  function processText(text) {
    // Convert to lowercase and extract words
    const words = text.toLowerCase()
      .replace(/[^a-z\s]/g, ' ') // Only keep letters and spaces
      .split(/\s+/)
      .filter(word => {
        // Only keep words that:
        // - Are 4+ characters
        // - Not in stop words
        // - Don't contain numbers
        // - Are mostly alphabetic (at least 80% letters)
        if (word.length < 4 || stopWords.has(word)) return false;
        if (/\d/.test(word)) return false; // No words with numbers
        
        // Filter out words that don't look like English
        // (too many consonants in a row, unusual patterns)
        if (/[bcdfghjklmnpqrstvwxyz]{5,}/.test(word)) return false;
        if (word.includes('xxx') || word.includes('zzz')) return false;
        
        return true;
      });
    
    // Count word frequencies
    const wordCounts = {};
    words.forEach(word => {
      wordCounts[word] = (wordCounts[word] || 0) + 1;
    });
    
    return wordCounts;
  }

  function mergeWordCounts(counts1, counts2) {
    const merged = { ...counts1 };
    Object.entries(counts2).forEach(([word, count]) => {
      merged[word] = (merged[word] || 0) + count;
    });
    return merged;
  }

  async function generateWordCloud() {
    const statusDiv = document.createElement('div');
    statusDiv.id = 'loading-status';
    statusDiv.textContent = 'Loading pages...';
    statusDiv.style.textAlign = 'center';
    statusDiv.style.padding = '20px';
    statusDiv.style.fontSize = '18px';
    document.getElementById('wordcloud').appendChild(statusDiv);

    try {
      // Get all page URLs
      const urls = await getAllPageURLs();
      console.log('URLs to process:', urls);
      statusDiv.textContent = `Found ${urls.length} pages. Analyzing...`;

      // Fetch and process all pages
      let allWordCounts = {};
      let processed = 0;
      
      for (const url of urls) {
        const text = await fetchPageText(url);
        if (text) {
          const wordCounts = processText(text);
          allWordCounts = mergeWordCounts(allWordCounts, wordCounts);
        }
        processed++;
        statusDiv.textContent = `Processing: ${processed}/${urls.length} pages...`;
      }

      console.log('Total unique words found:', Object.keys(allWordCounts).length);
      
      if (Object.keys(allWordCounts).length === 0) {
        statusDiv.textContent = 'Error: No words found. Check console for details.';
        statusDiv.style.color = 'red';
        return;
      }

      statusDiv.remove();

      // Convert to array and sort by frequency
      const wordArray = Object.entries(allWordCounts)
        .map(([word, count]) => ({ text: word, size: count }))
        .sort((a, b) => b.size - a.size)
        .slice(0, 100); // Top 100 words

      console.log('Top 10 words:', wordArray.slice(0, 10));

      // Create word cloud
      const width = document.getElementById('wordcloud').offsetWidth;
      const height = 600;

      // Scale font sizes
      const maxSize = wordArray[0].size;
      const minSize = wordArray[Math.min(99, wordArray.length - 1)].size;
      const fontScale = d3.scaleLog()
        .domain([minSize, maxSize])
        .range([10, 80]);

      console.log('Creating word cloud layout...');
      const layout = d3.layout.cloud()
        .size([width, height])
        .words(wordArray)
        .padding(5)
        .rotate(() => (Math.random() > 0.5 ? 0 : 90))
        .fontSize(d => fontScale(d.size))
        .on('end', draw);

      layout.start();

      function draw(words) {
        console.log('Drawing', words.length, 'words');
        const svg = d3.select('#wordcloud')
          .append('svg')
          .attr('width', width)
          .attr('height', height);

        const g = svg.append('g')
          .attr('transform', `translate(${width / 2},${height / 2})`);

        // Elegant grayscale gradient based on word frequency
        const color = d3.scaleLinear()
          .domain([0, words.length - 1])
          .range(['#2c3e50', '#7f8c8d']);

        g.selectAll('text')
          .data(words)
          .enter()
          .append('text')
          .style('font-size', d => `${d.size}px`)
          .style('font-family', 'Georgia, serif')
          .style('fill', (d, i) => color(i))
          .style('opacity', 0.85)
          .attr('text-anchor', 'middle')
          .attr('transform', d => `translate(${d.x},${d.y})rotate(${d.rotate})`)
          .text(d => d.text)
          .style('cursor', 'pointer')
          .style('transition', 'all 0.3s ease')
          .on('mouseover', function() {
            d3.select(this)
              .style('opacity', 1)
              .style('fill', '#34495e');
          })
          .on('mouseout', function(event, d) {
            const i = words.indexOf(d);
            d3.select(this)
              .style('opacity', 0.85)
              .style('fill', color(i));
          })
          .append('title')
          .text(d => `${d.text}: ${wordArray.find(w => w.text === d.text).size} occurrences`);
        
        console.log('Word cloud rendered successfully');
      }
    } catch (error) {
      console.error('Error generating word cloud:', error);
      statusDiv.textContent = `Error: ${error.message}. Check console for details.`;
      statusDiv.style.color = 'red';
    }
  }

  // Generate the word cloud when page loads
  generateWordCloud();

  // This was made possible thanks to AI.
</script>

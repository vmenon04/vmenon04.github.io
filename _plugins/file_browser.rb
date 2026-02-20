require 'cgi'

module Jekyll
  class FileBrowserTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      super
      @dirs_var = markup.strip
    end

    def render(context)
      dirs_var = @dirs_var
      directories = context[dirs_var]

      if directories.nil? && context.respond_to?(:environments)
        directories = context.environments[0][dirs_var] if context.environments[0]
      end

      if directories.nil? && context.respond_to?(:registers)
        page = context.registers[:page]
        directories = page[dirs_var] if page && page.respond_to?(:[])
      end

      return generate_styles if directories.nil? || directories.empty?

      html  = generate_styles
      html += "<div class=\"file-browser\">\n"
      html += "  <div class=\"fb-search\">\n"
      html += "    <input type=\"text\" id=\"fbSearch\" class=\"fb-search-input\" placeholder=\"Search files...\" autocomplete=\"off\" />\n"
      html += "  </div>\n"
      html += "  <div class=\"fb-tree\" id=\"fbTree\">\n"

      directories.each do |dir_config|
        next if dir_config.nil?
        path     = dir_config.is_a?(Hash) ? dir_config['path']  : dir_config.to_s
        title    = dir_config.is_a?(Hash) ? (dir_config['title'] || File.basename(path)) : File.basename(path)
        dir_path = File.expand_path(path, Dir.pwd)
        next unless Dir.exist?(dir_path)

        tree = build_tree(dir_path)
        html += render_children(tree, "/#{path}", 0)
      end

      html += "  </div>\n"
      html += "</div>\n"
      html += generate_script
      html
    end

    private

    # ------------------------------------------------------------------ #
    # Tree builder                                                         #
    # ------------------------------------------------------------------ #

    def build_tree(dir_path)
      node = { dirs: {}, files: [] }

      Dir.glob("#{dir_path}/**/*").sort.each do |full_path|
        next if File.directory?(full_path)
        next if should_exclude_file?(full_path)

        relative = full_path.sub("#{dir_path}/", '')
        parts    = relative.split('/')
        cursor   = node

        parts.each_with_index do |part, idx|
          if idx == parts.length - 1
            cursor[:files] << { name: part, rel: part }
          else
            cursor[:dirs][part] ||= { dirs: {}, files: [] }
            cursor = cursor[:dirs][part]
          end
        end
      end

      node
    end

    # ------------------------------------------------------------------ #
    # HTML renderer                                                        #
    # ------------------------------------------------------------------ #

    # Render the contents of a tree node without a wrapper folder row.
    # Used for the top-level configured directories so their children
    # appear directly in the tree (no redundant root label).
    def render_children(node, base_url, depth)
      html = ''
      node[:dirs].sort.each do |dir_name, subtree|
        html += render_node(dir_name, subtree, "#{base_url}/#{dir_name}", depth)
      end
      node[:files].sort_by { |f| f[:name] }.each do |file|
        url   = "#{base_url}/#{file[:rel]}".gsub(' ', '%20')
        label = CGI.escapeHTML(file[:name])
        type  = get_type_label(File.extname(file[:name]))
        indent = '  ' * (depth + 2)
        html += "#{indent}<div class=\"fb-file fb-file-root\" data-name=\"#{label.downcase}\">\n"
        html += "#{indent}  <span class=\"fb-file-icon\"></span>\n"
        html += "#{indent}  <a href=\"#{url}\" class=\"fb-file-link\" target=\"_blank\">#{label}</a>\n"
        html += "#{indent}  <span class=\"fb-badge\">#{type}</span>\n"
        html += "#{indent}</div>\n"
      end
      html
    end

    def render_node(name, node, base_url, depth, open: false)
      has_children = node[:dirs].any? || node[:files].any?
      open_attr    = open ? ' open' : ''
      indent       = '  ' * (depth + 2)

      html  = "#{indent}<details class=\"fb-folder\" data-depth=\"#{depth}\"#{open_attr}>\n"
      html += "#{indent}  <summary class=\"fb-folder-row\">\n"
      html += "#{indent}    <span class=\"fb-folder-icon\"></span>\n"
      html += "#{indent}    <span class=\"fb-folder-name\">#{CGI.escapeHTML(name)}</span>\n"
      html += "#{indent}  </summary>\n"

      if has_children
        html += "#{indent}  <div class=\"fb-children\">\n"

        node[:dirs].sort.each do |dir_name, subtree|
          html += render_node(dir_name, subtree, "#{base_url}/#{dir_name}", depth + 1)
        end

        node[:files].sort_by { |f| f[:name] }.each do |file|
          url   = "#{base_url}/#{file[:rel]}".gsub(' ', '%20')
          label = CGI.escapeHTML(file[:name])
          type  = get_type_label(File.extname(file[:name]))

          html += "#{indent}    <div class=\"fb-file\" data-name=\"#{label.downcase}\">\n"
          html += "#{indent}      <span class=\"fb-file-icon\"></span>\n"
          html += "#{indent}      <a href=\"#{url}\" class=\"fb-file-link\" target=\"_blank\">#{label}</a>\n"
          html += "#{indent}      <span class=\"fb-badge\">#{type}</span>\n"
          html += "#{indent}    </div>\n"
        end

        html += "#{indent}  </div>\n"
      end

      html += "#{indent}</details>\n"
      html
    end

    # ------------------------------------------------------------------ #
    # Helpers                                                              #
    # ------------------------------------------------------------------ #

    def should_exclude_file?(file_path)
      excluded = [
        /\.aux$/, /\.fdb_latexmk$/, /\.fls$/, /\.log$/, /\.out$/,
        /\.synctex\.gz$/, /\.toc$/, /\.bbl$/, /\.DS_Store$/,
        /\/scripts\//, /compile\.sh$/
      ]
      excluded.any? { |p| file_path.match?(p) }
    end

    def get_type_label(ext)
      {
        '.pdf'      => 'PDF',
        '.tex'      => 'LaTeX',
        '.md'       => 'Markdown',
        '.markdown' => 'Markdown',
        '.py'       => 'Python',
        '.js'       => 'JS',
        '.rb'       => 'Ruby',
        '.txt'      => 'Text',
        '.csv'      => 'CSV',
        '.jpg'      => 'JPEG',
        '.jpeg'     => 'JPEG',
        '.png'      => 'PNG',
        '.gif'      => 'GIF'
      }[ext] || ext.sub(/^\./, '').upcase
    end

    # ------------------------------------------------------------------ #
    # Styles                                                               #
    # ------------------------------------------------------------------ #

    def generate_styles
      <<~CSS
        <style>
          /* ── layout ─────────────────────────────────────────────────── */
          .file-browser { max-width: 800px; margin: 2rem auto; padding: 0 1rem; }

          /* ── search ─────────────────────────────────────────────────── */
          .fb-search { margin-bottom: 2rem; }
          .fb-search-input {
            width: 100%; padding: 0.5em 0;
            border: none; border-bottom: 1px solid var(--border-secondary);
            font-size: 0.95em; background: transparent;
            color: var(--text-primary); font-family: inherit;
            transition: border-color 0.2s; box-shadow: none;
          }
          .fb-search-input:focus { outline: none; border-bottom-color: var(--text-primary); }
          .fb-search-input::placeholder { color: var(--text-secondary); opacity: 0.5; }

          /* ── tree ─────────────────────────────────────────────────────  */
          .fb-tree { font-size: 0.95em; }

          /* ── folder ──────────────────────────────────────────────────── */
          .fb-folder { border: none; }
          .fb-folder > summary {
            list-style: none;
            display: flex; align-items: center; gap: 0.5em;
            padding: 0.55rem 0;
            border-bottom: 1px solid var(--border-secondary);
            cursor: pointer;
            user-select: none;
          }
          .fb-folder > summary::-webkit-details-marker { display: none; }
          .fb-folder > summary::marker { display: none; }

          /* chevron – rotates on open */
          .fb-folder-icon {
            display: inline-block; flex-shrink: 0;
            width: 0.55em; height: 0.55em;
            border-right: 1.5px solid var(--text-secondary);
            border-bottom: 1.5px solid var(--text-secondary);
            transform: rotate(-45deg);
            transition: transform 0.18s;
            margin-left: 0.1em;
          }
          .fb-folder[open] > summary .fb-folder-icon { transform: rotate(45deg); }

          .fb-folder-name { font-weight: 500; color: var(--text-primary); }
          .fb-folder > summary:hover .fb-folder-name { opacity: 0.65; }

          /* depth-based indentation */
          .fb-folder[data-depth="0"] > summary { padding-left: 0; }
          .fb-folder[data-depth="1"] > summary { padding-left: 1.4em; }
          .fb-folder[data-depth="2"] > summary { padding-left: 2.8em; }
          .fb-folder[data-depth="3"] > summary { padding-left: 4.2em; }
          .fb-folder[data-depth="4"] > summary { padding-left: 5.6em; }

          /* ── file row ─────────────────────────────────────────────────  */
          .fb-file {
            display: flex; align-items: baseline; gap: 0.5em;
            padding: 0.5rem 0;
            border-bottom: 1px solid var(--border-secondary);
          }
          .fb-folder[data-depth="0"] > .fb-children > .fb-file { padding-left: 1.4em; }
          .fb-folder[data-depth="1"] > .fb-children > .fb-file { padding-left: 2.8em; }
          .fb-folder[data-depth="2"] > .fb-children > .fb-file { padding-left: 4.2em; }
          .fb-folder[data-depth="3"] > .fb-children > .fb-file { padding-left: 5.6em; }
          .fb-folder[data-depth="4"] > .fb-children > .fb-file { padding-left: 7.0em; }
          .fb-file-root { padding-left: 0; }

          .fb-file-icon {
            display: inline-block; flex-shrink: 0;
            width: 0.5em; height: 0.65em;
            border: 1.5px solid var(--text-secondary);
            border-radius: 1px; opacity: 0.4;
            position: relative; top: 0.05em;
          }

          .fb-file-link {
            color: var(--text-primary); text-decoration: none;
            transition: opacity 0.18s; flex: 1;
            word-break: break-word;
          }
          .fb-file-link:hover { opacity: 0.55; }

          .fb-badge {
            font-size: 0.75em; color: var(--text-secondary);
            white-space: nowrap; margin-left: auto; padding-left: 0.5em;
          }

          /* ── search state ─────────────────────────────────────────────  */
          .fb-hidden { display: none !important; }
          .fb-no-results { padding: 1.5rem 0; color: var(--text-secondary); font-size: 0.9em; }

          /* ── responsive ───────────────────────────────────────────────  */
          @media (max-width: 600px) {
            .fb-tree { font-size: 0.9em; }
            .fb-badge { display: none; }
          }
        </style>
      CSS
    end

    # ------------------------------------------------------------------ #
    # Search / interaction script                                          #
    # ------------------------------------------------------------------ #

    def generate_script
      <<~JS
        <script>
        (function() {
          var input = document.getElementById('fbSearch');
          var tree  = document.getElementById('fbTree');
          if (!input || !tree) return;

          var allDetails = Array.from(tree.querySelectorAll('details.fb-folder'));
          var originalOpen = new Map(allDetails.map(function(d) { return [d, d.open]; }));

          input.addEventListener('input', function() {
            var q = this.value.trim().toLowerCase();

            var old = tree.querySelector('.fb-no-results');
            if (old) old.remove();

            if (!q) {
              tree.querySelectorAll('.fb-file').forEach(function(f) { f.classList.remove('fb-hidden'); });
              allDetails.forEach(function(d) {
                d.open = originalOpen.get(d);
                d.classList.remove('fb-hidden');
              });
              return;
            }

            // Show/hide files
            var allFiles = Array.from(tree.querySelectorAll('.fb-file'));
            allFiles.forEach(function(f) {
              var name = f.getAttribute('data-name') || '';
              f.classList.toggle('fb-hidden', name.indexOf(q) === -1);
            });

            // Open folders that have a visible descendant; close + hide the rest
            allDetails.slice().reverse().forEach(function(d) {
              var hasVisible = d.querySelector('.fb-file:not(.fb-hidden)');
              d.open = !!hasVisible;
              d.classList.toggle('fb-hidden', !hasVisible);
            });

            // No-results message
            var anyVisible = allFiles.some(function(f) { return !f.classList.contains('fb-hidden'); });
            if (!anyVisible) {
              var msg = document.createElement('div');
              msg.className = 'fb-no-results';
              msg.textContent = 'No files matching \u201c' + this.value + '\u201d';
              tree.appendChild(msg);
            }
          });
        })();
        </script>
      JS
    end
  end
end

Liquid::Template.register_tag('file_browser', Jekyll::FileBrowserTag)
# Keep the old tag name working so existing pages don't break
Liquid::Template.register_tag('file_browser_flat', Jekyll::FileBrowserTag)

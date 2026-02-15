require 'cgi'

module Jekyll
  # Flat file browser - traditional list view
  class FileBrowserFlatTag < Liquid::Tag
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
      
      all_files = []
      directories.each do |dir_config|
        next if dir_config.nil?
        path = dir_config.is_a?(Hash) ? dir_config['path'] : dir_config.to_s
        source_dir = dir_config.is_a?(Hash) ? (dir_config['title'] || File.basename(path)) : File.basename(path)
        dir_path = File.expand_path(path, Dir.pwd)

        if Dir.exist?(dir_path)
          files = scan_directory(dir_path)
          files.each { |f| f[:source_dir] = source_dir; f[:base_path] = path }
          all_files.concat(files)
        end
      end
      
      html = "<div class=\"flat-browser\">\n"
      html += "<div class=\"browser-search\">\n"
      html += "<input type=\"text\" id=\"fileSearch\" class=\"file-search\" placeholder=\"Search files...\" />\n"
      html += "</div>\n"
      html += "<table class=\"file-table\">\n"
      html += "<thead><tr><th class=\"col-name\">Name</th><th class=\"col-type\">Type</th><th class=\"col-folder\">Folder</th></tr></thead>\n"
      html += "<tbody class=\"file-list-body\">\n"
      
      sorted_files = all_files.sort_by { |f| [f[:source_dir], f[:name]] }
      
      sorted_files.each do |file|
        file_url = "/#{file[:base_path]}/#{file[:path]}".gsub(/\s+/, '%20')
        type_label = get_type_label(file[:ext])
        
        html += "<tr class=\"file-row\" data-name=\"#{file[:name].downcase}\" data-type=\"#{type_label.downcase}\">\n"
        html += "<td class=\"col-name\"><a href=\"#{file_url}\" class=\"file-link\">#{CGI.escapeHTML(file[:name])}</a></td>\n"
        html += "<td class=\"col-type\">#{type_label}</td>\n"
        html += "<td class=\"col-folder\">#{CGI.escapeHTML(file[:source_dir])}</td>\n"
        html += "</tr>\n"
      end
      
      html += "</tbody>\n</table>\n"
      html += "<script>\n"
      html += "document.getElementById('fileSearch').addEventListener('keyup', function(e) {\n"
      html += "  const query = e.target.value.toLowerCase();\n"
      html += "  const rows = document.querySelectorAll('.file-row');\n"
      html += "  rows.forEach(row => {\n"
      html += "    const name = row.getAttribute('data-name');\n"
      html += "    const type = row.getAttribute('data-type');\n"
      html += "    const folder = row.querySelector('.col-folder').textContent.toLowerCase();\n"
      html += "    if (name.includes(query) || type.includes(query) || folder.includes(query)) {\n"
      html += "      row.style.display = '';\n"
      html += "    } else {\n"
      html += "      row.style.display = 'none';\n"
      html += "    }\n"
      html += "  });\n"
      html += "});\n"
      html += "</script>\n"
      html += "</div>\n"
      html += generate_styles
      
      html
    end

    private

    def scan_directory(dir_path)
      files = []
      Dir.glob("#{dir_path}/**/*").sort.each do |file_path|
        next if File.directory?(file_path)
        next if should_exclude_file?(file_path)
        relative_path = file_path.sub("#{dir_path}/", '')
        ext = File.extname(file_path)
        files << {
          name: File.basename(file_path),
          path: relative_path,
          ext: ext,
          category: categorize_file(relative_path, ext)
        }
      end
      files
    end

    def should_exclude_file?(file_path)
      excluded = [/\.aux$/, /\.fdb_latexmk$/, /\.fls$/, /\.log$/, /\.out$/, /\.synctex\.gz$/, /\.toc$/, /\.bbl$/, /\.DS_Store$/, /\/scripts\//, /compile\.sh$/]
      excluded.any? { |p| file_path.match?(p) }
    end

    def categorize_file(file_path, ext)
      case ext
      when '.pdf' then 'pdfs'
      when '.tex' then 'latex'
      when '.md', '.markdown' then 'markdown'
      when '.py', '.js', '.rb' then 'code'
      when '.txt', '.csv' then 'data'
      when '.jpg', '.jpeg', '.png', '.gif' then 'images'
      else 'other'
      end
    end

    def get_file_icon(category)
      return ''
    end

    def get_type_label(ext)
      types = {
        '.pdf' => 'PDF', '.tex' => 'LaTeX', '.md' => 'Markdown',
        '.markdown' => 'Markdown', '.py' => 'Python', '.js' => 'JavaScript',
        '.rb' => 'Ruby', '.txt' => 'Text', '.csv' => 'CSV',
        '.jpg' => 'JPEG', '.jpeg' => 'JPEG', '.png' => 'PNG', '.gif' => 'GIF'
      }
      types[ext] || ext.sub(/^\./, '').upcase
    end

    def generate_styles
      <<~CSS
      <style>
        .flat-browser { max-width: 800px; margin: 2rem auto; padding: 0 1rem; }
        .browser-search { margin-bottom: 2rem; }
        .file-search { width: 100%; padding: 0.5em 0; border: none; border-bottom: 1px solid var(--border-secondary); font-size: 0.95em; background: transparent; color: var(--text-primary); font-family: inherit; transition: border-color 0.2s; box-shadow: none; }
        .file-search:focus { outline: none; border-bottom-color: var(--text-primary); }
        .file-search::placeholder { color: var(--text-secondary); opacity: 0.5; }
        .flat-browser .file-table { width: 100%; border-collapse: collapse; font-size: 0.95em; box-shadow: none !important; border-radius: 0 !important; overflow: visible !important; margin: 0 !important; }
        .flat-browser .file-table thead tr { background-color: transparent !important; background: transparent !important; color: var(--text-secondary) !important; }
        .flat-browser .file-table th { padding: 0.85rem 0.75rem !important; text-align: left !important; font-weight: 400 !important; color: var(--text-secondary) !important; font-size: 0.8em; text-transform: uppercase; letter-spacing: 1px; background: transparent !important; border: none !important; }
        .flat-browser .file-table thead { border-bottom: 1px solid var(--border-secondary); }
        .flat-browser .file-table tbody tr { border-bottom: 1px solid var(--border-secondary); background-color: transparent !important; transition: opacity 0.15s; }
        .flat-browser .file-table tbody tr:nth-of-type(even) { background-color: transparent !important; }
        .flat-browser .file-table tbody tr:hover { opacity: 0.7; background-color: transparent !important; }
        .flat-browser .file-table td { padding: 0.85rem 0.75rem !important; text-align: left !important; vertical-align: baseline; border: none !important; }
        .flat-browser .col-name { width: 50%; text-align: left !important; }
        .flat-browser .col-type { width: 15%; color: var(--text-secondary); font-size: 0.9em; text-align: left !important; }
        .flat-browser .col-folder { width: 35%; color: var(--text-secondary); font-size: 0.9em; text-align: left !important; }
        .flat-browser .file-link { color: var(--text-primary); text-decoration: none; transition: opacity 0.2s; word-break: break-word; }
        .flat-browser .file-link:hover { opacity: 0.6; }
        @media (max-width: 768px) { .flat-browser .file-table { font-size: 0.9em; } .flat-browser .file-table th { padding: 0.6rem 0.5rem !important; } .flat-browser .file-table td { padding: 0.6rem 0.5rem !important; } .flat-browser .col-name { width: 65%; } .flat-browser .col-type { width: 20%; } .flat-browser .col-folder { display: none; } .file-search { font-size: 1em; } }
      </style>
      CSS
    end
  end
end

Liquid::Template.register_tag('file_browser_flat', Jekyll::FileBrowserFlatTag)

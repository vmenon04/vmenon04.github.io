# Vasudev Menon's Personal Website

A minimal Jekyll-powered personal website showcasing projects, experience, and contact information.

## Setup

### Prerequisites

- Ruby (version 2.7 or higher recommended)
- RubyGems
- Bundler

### Installation

1. Clone this repository:
```bash
git clone https://github.com/vmenon04/vmenon04.github.io.git
cd vmenon04.github.io
```

2. Clean up old gems and install dependencies:
```bash
# Remove Gemfile.lock to start fresh
rm -f Gemfile.lock

# Install bundler if needed
gem install bundler

# Install Jekyll and dependencies
bundle install
```

### Running Locally

To preview the site locally:

```bash
bundle exec jekyll serve
```

Then open your browser and navigate to `http://localhost:4000`

**Note:** When you change `_config.yml`, restart the Jekyll server for changes to take effect.

### Building for Production

To build the site for production:

```bash
bundle exec jekyll build
```

The generated site will be in the `_site` directory.

## Project Structure

```
.
├── _config.yml          # Jekyll configuration
├── _layouts/            # Page layouts
│   ├── default.html     # Base layout
│   ├── page.html        # Page layout
│   └── post.html        # Post layout
├── assets/              # Static assets
│   ├── css/             # Stylesheets
│   └── *.pdf, *.png     # Images and documents
├── projects/            # Project pages
├── index.html           # Home page
├── about.html           # About page
├── contact.html         # Contact page
├── projects.html        # Projects listing
└── Gemfile              # Ruby dependencies
```

## Customization

- Edit `_config.yml` to update site metadata
- Modify layouts in `_layouts/` directory
- Update styles in `assets/css/main.css`
- Add new pages by creating HTML files with YAML front matter

## Deployment

This site is configured to work with GitHub Pages. Simply push changes to the `main` branch and GitHub will automatically build and deploy your site.

## License

© 2025 Vasudev Menon
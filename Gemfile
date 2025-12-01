source "https://rubygems.org"

gem "jekyll", "~> 4.3.4"
gem "webrick", "~> 1.8"
gem "csv"
gem "logger"
gem "base64"

group :jekyll_plugins do
  gem "jekyll-feed", "~> 0.12"
  gem "jekyll-seo-tag", "~> 2.8"
end

# Lock platforms to avoid architecture issues
platforms :ruby do
  gem "http_parser.rb", "~> 0.6.0", :platforms => [:jruby]
end
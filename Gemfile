source 'https://rubygems.org'
ruby '2.4.2'

gem 'jekyll', '>= 3.8.6'
gem 'nokogiri', '1.10.3'

group :development do
  # Get error feedback during development
  gem 'rubocop-jekyll'
end

group :development, :test do
  # Test your rendered HTML files to make sure they're accurate
  gem 'html-proofer', '3.11.1'
end

group :jekyll_plugins do
  gem 'jekyll-feed'
  gem 'jekyll-seo-tag'
  gem 'jekyll-sitemap'
  gem 'github-pages'
end


gem 'jekyll-github-metadata'

#Controls timezone conversion
gem 'tzinfo', '>= 1.2'

#For Windows environment
gem 'wdm', '>= 0.1.0' if Gem.win_platform?

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

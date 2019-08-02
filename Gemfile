# If you do not have OpenSSL installed, change
# the following line to use 'http://'
source 'https://rubygems.org'

# For faster file watcher updates on Windows:
gem 'wdm', '~> 0.1.0', platforms: %i[mswin mingw x64_mingw]

# Windows does not come with time zone data
gem 'tzinfo-data', platforms: %i[mswin mingw x64_mingw jruby]

# Middleman Gems
gem 'middleman'
gem 'middleman-blog'
gem 'middleman-livereload'
gem 'middleman-minify-html'
gem 'middleman-autoprefixer'
gem 'middleman-syntax'

gem 'kramdown'
gem 'nokogiri'
gem 'sassc'
gem 'stringex'
gem 'countries'

# Replacement of therubyracer
gem 'mini_racer', '~> 0.2'

# For feed.xml.builder
gem 'builder', '~> 3.0'

# Handbook CHANGELOG generation
# gem 'gitlab'
# gem "rss", "~> 0.2.8"

group :development, :test do
  gem 'html-proofer'
  gem 'docopt'
  gem 'rspec', require: false
  gem 'rubocop', require: false
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'selenium-webdriver'
  gem 'webmock'
end

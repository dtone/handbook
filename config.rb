require 'extensions/breadcrumbs'
require "thwait"

###
# Page options, layouts, aliases and proxies
###

# Disable HAML warnings
# https://github.com/middleman/middleman/issues/2087#issuecomment-307502952
Haml::TempleEngine.disable_option_validator!

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

set :haml, {
  format: :xhtml
}

activate :syntax, line_numbers: false

set :markdown_engine, :kramdown
set :markdown, tables: true, hard_wrap: false, input: 'GFM'

activate :autoprefixer do |config|
  config.browsers = ['last 2 versions', 'Explorer >= 9']
end

activate :breadcrumbs, wrapper: :li, separator: '', hide_home: true, convert_last: false

# Reload the browser automatically whenever files change
unless ENV['ENABLE_LIVERELOAD'] != '1'
  configure :development do
    activate :livereload
  end
end

# Build-specific configuration
configure :build do
  set :build_dir, 'public'
  activate :minify_css
  activate :minify_javascript
  activate :minify_html
end

page '/404.html', directory_index: false

# Ignore all templates
ignore '/templates/*'

# Ignore all the rest
ignore '/includes/*'
ignore '/source/stylesheets/highlight.css'
ignore '/.gitattributes'
ignore '**/.gitkeep'

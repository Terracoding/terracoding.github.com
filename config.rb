require "active_support/core_ext/integer/inflections"

###
# Blog settings
###

Time.zone = "UTC"

activate :blog do |blog|
  blog.prefix = "blog"
  blog.sources = ":title.html"
  blog.default_extension = ".md"
  blog.layout = "post"
  blog.permalink = ":title.html"
  blog.taglink = "tags/:tag.html"

  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = ":year.html"
  # blog.month_link = ":year/:month.html"
  # blog.day_link = ":year/:month/:day.html"
  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/:num"
  # blog.calendar_template = "calendar.html"

  blog.tag_template = "tag.html"
end

require 'extensions/image_resizer'
activate :image_resizer do |ir|
  ir.input_folders = ['assets/images']
  ir.filename_suffix = '@1x'
end

page "/feed.xml", :layout => false
page "/rss/index.xml", :layout => false

###
# Compass
###

set :haml, { format: :html5, attr_wrapper: '"' }
set :markdown_engine, :kramdown
set :markdown, { smartypants: true, fenced_code_blocks: true }

module Haml::Filters::Kramdown
  include Haml::Filters::Base

  def render(text)
    Kramdown::Document.new(text).to_html
  end
end

# Susy grids in Compass
# First: gem install susy
# require 'susy'

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'
set :partials_dir, 'partials'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  # activate :cache_buster

  # Use relative URLs
  # activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.method = :git
  deploy.remote = "origin"
  deploy.branch = "master"
end

activate :directory_indexes
activate :alias
activate :syntax

require "#{Dir.pwd}/helpers/rake_helpers"
include RakeHelpers

desc 'Create a post file and folder'
task :post, :title do |t, args|
  title = args[:title]
  slug = slugify(title)

  post_dir = "source/blog/"

  post = '---
title: "'+title+'"
date: '+Time.now.strftime("%F %R")+'
tags:
author:
summary:
image:
---

'

  File.open(post_dir+slug+".md", 'w') { |f| f.puts post }
  Dir.mkdir(post_dir+slug)
end

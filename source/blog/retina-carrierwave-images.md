---
title: Easy Retina Images with Carrierwave
date: 2016-05-19 12:03
tags: web, development, open source
author: sam
summary: How to automate creation and serving of high-resolution images in a Rails app
---

We recently launched [Dry July][dj], a platform where people can raise funds for adults in Australia living with cancer.

When Dry July approached us, they emphasised that the majority of their traffic comes from smartphones and tablets. With the proliferation of "retina" mobile devices and Macs over the last few years, we wanted to selectively serve high-resolution images to keep things looking crisp for all users.

Almost every image on the Dry July platform, including for the [customisable website theme][theme], are uploaded through [Carrierwave][cw]. That meant we could auto-generate multiple versions of an image on upload. In our uploader, we configured @2x and @3x versions for each version size:

~~~ ruby
# image_uploader.rb
version :small_3x do
  process resize_to_limit: [900, 900]
end

version :small_2x, from_version: :small_3x do
  process resize_to_limit: [600, 600]
end

version :small, from_version: :small_2x do
  process resize_to_limit: [300, 300]
end

version :thumb_3x, from_version: :small do
  process resize_to_limit: [150, 150]
end

version :thumb_2x, from_version: :thumb_3x do
  process resize_to_limit: [100, 100]
end

version :thumb, from_version: :thumb_2x do
  process resize_to_limit: [50, 50]
end
~~~

[srcset][], the HTML5 `img` attribute for serving multiple resolutions is thankfully [widely supported][caniuse] these days. By adding this method to our `application_helper.rb` we could provide retina-capable image tags with ease:

~~~ ruby
# application_helper.rb
def retina_image_tag(uploader, version, options={})
  options.symbolize_keys!
  options[:srcset] ||=  (2..3).map do |multiplier|
                          name = "#{version}_#{multiplier}x"
                          if uploader.version_exists?(name) &&
                            source = uploader.url(name).presence
                            "#{source} #{multiplier}x"
                          else
                            nil
                          end
                        end.compact.join(', ')

  image_tag(uploader.url(version), options)
end

# view.html.haml
= retina_image_tag user.avatar, :thumb
~~~
produces

~~~ html
<img src="/users/avatars/thumb_me.jpg" srcset="/users/avatars/thumb_2x_me.jpg 2x, /users/avatars/thumb_3x_me.jpg 3x" />
~~~

Feel free to use the code above in your next project. And check out [Dry July][dj] to see it in action!

[dj]: https://dryjuly.com
[theme]: /blog/rails-app-themer/
[cw]: https://github.com/carrierwaveuploader/carrierwave
[srcset]: https://webkit.org/demos/srcset/
[caniuse]: http://caniuse.com/#feat=srcset

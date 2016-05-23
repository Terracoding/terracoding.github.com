---
title: Rails Polymorphic Feed Caching
date: 2016-05-19 16:11
tags: web, development, open source
author: dominic
summary: How to improve polymorphic feeds in a Rails application with fragment caching
---

When building a social platform, we're often required to build a feed of some sort, usually containing multiple types of content such as posts, photos, etc.

With this in mind, it's usually best to have a `FeedItem` model with a polymorphic association for the different types of feed items. Let's say:

~~~ruby
class FeedItem < ActiveRecord::Base
  belongs_to :source, polymorphic: true
  has_many :comments
end

class Post < ActiveRecord::Base
  belongs_to :user
  has_one :feed_item, as: :source, dependent: :destroy
end

class Photo < ActiveRecord::Base
  belongs_to :user
  has_one :feed_item, as: :source, dependent: :destroy
end
~~~

This is all well and good, but when you come to [eager-load][el] associations on the collection to improve performance, this technique becomes problematic. This is where [Rails Fragment Caching][fragcache] comes into play.

[Fragment caching][fragcache] is a really useful tool in Rails to cache partials and collections so they are pulled straight from memory without needing to access the database (besides checking if new records exist or existing records have been updated).

In the view that includes our feed partial we have the following:

~~~html
  - cache(cache_key_for_user_feed_items(resource, params[:page])) do
    = render 'feed_items'
~~~

~~~ruby
  module FragmentCacheHelper
    def cache_key_for_user_feed_items(resource, page = 1)
      count = resource.feed_items.count
      max_updated_at = resource.feed_items.maximum(:updated_at).try(:utc)
        .try(:to_s, :number)
      "user/#{resource.id}/feed_items_#{count}_#{max_updated_at}_#{page}"
    end
  end
~~~

The `FragmentCacheHelper` generates a key for us to use. If the key differs when the next page is loaded, it will pull the records as usual and skip the cache. This works per page, so each page with [will_paginate][wp] will also pull from the database if needs be.

This cuts down the database calls by only ever needing to check the count of the records for the user and the latest `updated_at` value.

[el]: http://guides.rubyonrails.org/active_record_querying.html#eager-loading-associations
[wp]: https://github.com/mislav/will_paginate
[fragcache]: http://guides.rubyonrails.org/caching_with_rails.html#fragment-caching

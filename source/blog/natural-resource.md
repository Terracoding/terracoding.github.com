---
title: "Natural Resource: Avoiding ActiveAdmin"
date: 2016-05-23 14:15 UTC
tags: web, development, open source, ruby on rails
author: robert
summary: A small gem for a nice middle-ground between a roll-your-own admin and ActiveAdmin
---

## Background

[Natural Resource][nr] was born from frustrations experienced on legacy projects that used gems like [ActiveAdmin][aa] to provide an admin interface for an app. For the very basics ActiveAdmin is great; it provides you a set of functionality out of the box that you don't have to implement yourself.

Unfortunately, we are all aware that requirements change and functionality grows. ActiveAdmin forces you to extend it using its own concepts outside of standard Rails practices, sometimes going so far as to mix routing, controller and view details in the same file.

## Rolling your own admin functionality?

After a frustrating few hours grappling with AA's quirks, it's easy to understand why someone would resort to rolling their own admin interface. Advanced admin features shouldn't be any harder to implement than the rest of your app.

Secondly, it's often hard to integrate large, opinionated admin gems because they try to blend authentication and/or authorisation logic with their own concepts. Whilst Natural Resource is also opinionated, it exists and performs in a very simple way and is easily overridden.

## Enough talk - show me the code!

The following is a typical NR-based controller:

~~~ ruby
# Controller for generating and displaying Reports for orders received
class Admin::OrdersController < ApplicationController
  include AdminController
  include ReportDownloading

  resource :order

  def resource_scope
    Order.includes(:txns, line_items: [:product])
  end

  def report_class
    OrderReport
  end
end
~~~

If we take the above to have authenticated our admin-user (via your own `AdminController` concern) then our view could look like this:

~~~ haml
%h1 Order Report

= search_form_for [current_context, query] do |f|
  = f.input :user_email_cont, label: 'Recipient Email'
  = f.input :amount_cents_gt, label: 'Amount greater than'
  = f.button :submit, "Apply filters"
  = link_to 'Download report', [:download, current_context, :orders,
    q: params[:q])

%table
  %tr
    %th Order Reference
    %th Payment Method
    %th Recipient Name
    %th Amount
    %th Created At
  - resources.each do |resource|
    %tr
      %td= resource.reference
      %td= resource.source_type.titleize
      %td= resource.user.name
      %td= resource.amount.format
      %td= resource.created_at

= will_paginate resources
~~~

The above controller offers several helper methods:

  * `current_context` is a method defined to specify the area of the site you are in. It is used for consistently defining routes.
  * `query` is the [Ransack][rs] search object used for defining simple querying using the Ransack syntax.
  * `resource_scope` is the initial scope of the objects scoped via its respective policy, i.e. `policy_scope(resource_scope)`
  * `resources` is the lazy-loaded, [paginated][wp] result of applying the Ransack query across the `resource_scope` method.


## In Summary

The main motivation behind Natural Resource is to be pragmatic. There are further extensions that can be made to it to allow auto-generating initial views if a sensible standard set can be decided upon without introducing too much overhead/complexity.

It provides a rich set of foundational functionality and tries its best to take a sensible modular, easily overridden approach to standardised components.

There is an [NR example][demo] repo that contains a more detailed example, but nothing beats [reading the source][nr]. The majority of functionality is only ~100 lines long. I will add to the NR example repository as we use NR at Terracoding, converting the git history to a series of steps you can follow in [the README][rm].

[nr]: https://github.com/haar/natural_resource
[aa]: http://activeadmin.info/
[demo]: https://github.com/haar/nr_example
[rs]: https://github.com/activerecord-hackery/ransack
[wp]: https://github.com/mislav/will_paginate
[rm]: https://github.com/Haar/natural_resource/blob/master/README.md

---
title: "Natural Resource: Avoiding ActiveAdmin"
date: 2016-05-23 14:15 UTC
tags: web, development, ruby, open source
author: robert
summary: A small gem to meet halfway between roll-your-own admins vs utilising ActiveAdmin
---

### Background

Natural Resource was born from frustrations experienced on legacy projects that used gems like ActiveAdmin to provide admin functionality. For the very basics ActiveAdmin is great; it provides you a set of functionality out of the box that you don't have to implement yourself.

Unfortunately we are all aware that requirements change and funtionality grows, and ActiveAdmin forces you to extend it using its own concepts outside of standard Rails practices, sometimes going so far as to even mix routing, controller and view details in the same file.

### Rolling your own Admin functionality?

Some times after a frustrating few hours of head butting against different it's easy to sympathise why someone would want to roll their own; complex admin behaviour shouldn't be any harder to implement over the rest of your site.

Secondly there is often difficulty integrating large opinionated admin gems, they do their best to blend authentication and/or authorisation logic with their own concepts. Whilst Natural Resource is also opinionated, it exists and performs in a very simple way and is easily overriden.

## Enough talk - show me the code.

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

If we take the above to have authenticated our admin-user (via your own AdminController concern) then our view could look like this:

~~~ haml
%h1 Order Report

= search_form_for [current_context, query] do |f|
  .row.gutters-sm
    .col-sm-3
      = f.input :user_email_cont, label: 'Recipient Email'
      = f.input :amount_cents_gt, label: 'Amount greater than',
        hint: 'Value in cents'

  = f.button :submit, "Apply filters", class: "btn btn-primary"
  = link_to 'Download report', [:download, current_context, :orders,
    q: params[:q]), class: 'btn btn-warning'

%table.table.m-t-3
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
      %td= resource.created_at.to_tzs(:long, current_instance.timezone)

= render 'pagination'
~~~

The above files exposes several helper methods:

  * `current_context` is a method defined to specify the "context" of the site, it is used for consistently defining routes.
  * `query` is the [Ransack](https://github.com/activerecord-hackery/ransack) search object used for defining simple querying using the Ransack syntax.
  * `resources` is the lazy-loaded, [paginated](https://github.com/mislav/will_paginate) result of applying the Ransack query across the `resource_scope` method.
  * `resource_scope` is the initial scope of the objects scoped via its respective policy, i.e. `policy_scope(resource_scope)`


### In Summary

The main motivation behind Natural Resource is to be pragmatic, and there are further extensions that can be made to it to allow auto-generating initial views (if a sensible standard set can be decided upon without introducing too much overhead/complexity).

It provides a rich set of initial functionality to easily build upon, and tries its best to provide a sensible modular/overrideable approach to standardised components.

There is an [NR example](https://github.com/haar/nr_example) repo that contains a more detailed example, but nothing beats [reading the source](https://github.com/haar/natural_resource) (the majority of functionality is ~100 lines long). I will add to the NR example repository as and when I can, converting the git history to a series of steps you can follow in the README.

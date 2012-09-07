---
layout: post
title: "DWTagList for iOS"
category: Tutorial
author: Dominic Wroblewski
twitter: domness
tags: [ios, tutorial]
---
{% include JB/setup %}

The other day I started development on a new iOS app for a website, but I soon came across the notion of having to list sets of tags in a nice way in a `UITableViewCell`.

I started off thinking the task would be quick hard compared to the rest of the application, however, with a few methods and a subclass of `UIView` it was done just short of 20 minutes.

<div class="thumbnail"><img width="200" src="/assets/images/dwtaglist.png" /></div>

I've set the code that you simply initialise it with the frame size, add an array of tags and then add it to your view. Almost everything is customisable including the padding, margins, background colour and font.

You can see the code [here](https://github.com/domness/DWTagList).

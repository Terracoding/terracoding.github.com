---
title: Dynamic Rails App Theming
date: 2015-12-04 14:36
tags: web, development, open source, ruby on rails
author: sam
summary: How we built a simple UI for users to customise the theme of a Rails app
---

[<img src="/blog/rails-app-themer/icon.png" width="150" alt="Themer UI" class="pull-right">][gh]

We started work on an exciting new project this week that requires a single Rails app to power multiple similar websites. The websites are all going to have the same features and basic structure but the client wanted to be able to customise colours, fonts and images for each site themselves.

To get our heads around the feature, we built a [prototype app][gh] that provides a theme editing interface. You can [try out the demo][app]!

[<img src="/blog/rails-app-themer/themer.jpg" alt="Themer UI" class="img-responsive img-thumbnail">][app]

## Technical Details

You include theme style rules in special comment blocks using `color()`, `font()`, and `image_url()` helpers:

    body {
      /* defaults */
      background: white;
      color: black;
      font-family: sans-serif;

      /* THEME --------
      background-image: image_url(bg);
      color: color(text);
      font-family: font(body);
      -------- THEME */
    }

Running `rake theme:update` will then generate a theme template from those comments at `app/views/themes/show.css.erb`.

Theme attributes can be easily added to the `Theme` model. The controller `:show` action is cached and the generated stylesheet is available at `/theme.css` to be included in the `head` of any page.

The theme editor presents a live preview by injecting styles into an `iframe` as the theme values are changed. This includes images, using the [FileReader API][frapi] to read them locally in Base64 before they are uploaded to the server.

To make sure override rules with missing values degrade gracefully, the app utilises browsers' behaviour of ignoring any invalid rules whilst continuing to render the rest of the styles. This means any default styling can simply be included in the app's main stylesheet (or anywhere you like).

## Open Source

All of the source code is [available on GitHub][gh]. Please fork and reuse the code as much as you like! Feel free to open an Issue on GitHub or you can reach us on Twitter [@terracoding][tw].

[frapi]: https://developer.mozilla.org/en/docs/Web/API/FileReader
[gh]: https://github.com/samrayner/rails-app-themer
[app]: http://app-themer.herokuapp.com/theme/edit
[efs]: https://devcenter.heroku.com/articles/dynos#ephemeral-filesystem
[sass]: http://sass-lang.com/
[tw]: http://twitter.com/terracoding

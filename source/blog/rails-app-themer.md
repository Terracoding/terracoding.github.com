---
title: Dynamic Rails App Theming
date: 2015-12-04 14:36
tags: web, development, open source
author: sam
summary: How we built a simple UI for users to customise the theme of a Rails app
---

We started work on a exciting new project this week that requires a single Rails app to power multiple similar websites. The websites are all going to have the same features and basic structure but the client wanted to be able to customise colours, fonts and images for each site themselves.

To get our heads around the feature, we built a [prototype app][gh] that provides a theme editing interface. You can [try out the demo][app]!

[<img src="/blog/rails-app-themer/themer.jpg" alt="Themer UI" class="img-responsive img-thumbnail">][app]

## Technical Details

The app uses a template at `app/views/themes/show.css.erb` to define overriding styles. You easily add theme attributes to the `Theme` model and helper methods are provided for pulling their values from the database. The controller `:show` action is cached and the generated stylesheet is available at `/theme.css` to be included in the `head` of any page.

The theme editor presents a live preview by injecting styles into an `iframe` as the theme values are changed. This includes images, using the [FileReader API][frapi] to read them locally in Base64 before they are uploaded to the server.

## Challenges

Originally we had hoped to allow the user to customise [SASS][sass] variables and recompile the CSS on every save but [Heroku's ephemeral filesystem][efs] would have made that a real pain. We instead settled on the override stylesheet that targets specific elements. It keeps the whole system far simpler at the expense of a little more preparation on the front-end.

To make sure override rules with missing values degrade gracefully, the app utilises browsers' behaviour of ignoring any invalid rules whilst continuing to render the rest of the styles. This means any default styling can simply be included in the app's main stylesheet (or anywhere you like).

## Open Source

All of the source code is [available on GitHub][gh]. Please fork and reuse the code as much as you like! Feel free to open an Issue on GitHub or you can reach us on Twitter [@terracoding][tw].

[frapi]: https://developer.mozilla.org/en/docs/Web/API/FileReader
[gh]: https://github.com/samrayner/rails-app-themer
[app]: http://app-themer.herokuapp.com/theme/edit
[efs]: https://devcenter.heroku.com/articles/dynos#ephemeral-filesystem
[sass]: http://sass-lang.com/
[tw]: http://twitter.com/terracoding

---
title: "Automated Testing - What is it, and why should you care?"
date: 2015-01-23 17:30
author: Robert White
tags:
- teams
- testing
summary_text: 'When working with a software development team, what are automated tests, and are your team using them?'
---

You’ve just started working with a software development company on a large project and you want to make sure everything goes smoothly and reliably. Unpredictable changes can cause no end of problems, from increased costs through to missed deadlines.

The software development procedure is rarely cut and dry, instead a series of evolutions as new requirements are discovered and built upon. Naturally, you want to be able to reliably expand on existing features whilst developing new ones that compliment and improve upon them.

## How can we _reliably_ build without compromising existing functionality?

Take the following example:

     Given I am a user with an account on the website
     When I visit my profile page
     Then I should be able to change my contact details.

This scenario is simple, and common across numerous websites. As a client you want to be confident that a user is able to update their email address and other contact information. How can we ensure this functionality continues to work properly?

### Manual testing

One option is to manually test out the website yourself, going through each of the features in turn and making sure they work. Whilst this process does work in catching bugs that occur, unless the project is reasonably small, it becomes very costly on your time.

As a system grows and more features are added to it, it becomes an unrealistic burden to be expected of you. Finally, in addition to this, with manual testing comes manual errors, it becomes quite easy without a rigid process to accidentally leave aspects of a system untested.

### Automated testing

Wouldn’t be awesome if we could just tell a web browser to visit each of our pages for us, and check that everything works as expected? Turns out we can make the web browser do everything for us, and set expectations as to what a page should contain afterwards.

The caveat usually associated with automated testing is a predictable overall increase in developer time for implementing features, after all - they need to write the feature and the appropriate tests to go with it. However, this time cost is usually paid back quite quickly, as bugs are detected as they occur, rather than after several days or weeks of development having gone by. As a result, bugs are typically fixed before they even make it out the door, resulting in a better product and development cycle for your product.

So now you know _what_ Automated Testing is, be sure to check your product is being tested.


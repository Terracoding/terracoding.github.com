---
title: "The 6 Stages of App Development - Part 2"
date: 2015-04-04
author: sam
tags:
- design
- ios
- web
- process
---

In [Part 1 of this series][part1] I outlined the reasons why we follow a methodical approach to developing apps for clients and discussed the intial stages: analysing the problem, feature design and interaction design.

This post covers the final stages leading up to release: [visual design][stage4], [building the app][stage5] and [testing][stage6].

##Stage 4 - Visual Design

With a set of features laid out for our app, we can start to add polish to how it looks. During this design phase we tend to produce mockups of how the app will look in [Photoshop][ps] and work closely with the client to make sure everyone is happy with the style, colours and branding.

It's important to remember that these mockups aren't exactly how the final app will look. Due to the range of screen sizes and orientations, this stage is more about creating a guide for common elements used throughout the app. Still, focusing on the major views as a whole lets us design elements like toolbars and buttons in the context they'll be used.

<a href="/blog/museum-ibeacon-app/museum-app.jpg"><img src="/blog/museum-ibeacon-app/museum-app.jpg" alt="iBeacon App Mockup" /></a>

When we reach this stage it's easy to think that the bulk of the hard work has been done; we've planned out exactly what the app will do and here it is on screen looking great! In fact, there is still a lot of work to do converting these static mockups into a stable, functional app.

##Stage 5 - Building the App

This stage - turning our designed app into a reality - is the one that will involve the client the least. We'll need to get our heads down and write the code that detects the user's actions (e.g. a button tap or swipe) and does something in response. It might be as easy as presenting the next view or something very complex like running a real-time 3D simulation but it all needs to be programmed.

In this stage we'll also build any back-end infrastructure that the app needs to communicate with. This is usually a web server that the app sends and receives data to/from.

Progress updates might not be as exciting for a week or two but, given time, we'll produce a working app that we can install on a device for you to test.


##Stage 6 - Testing

Finally, with a working version of the app built, we're ready to start putting it through its paces.

For saftey-critical applications we will spend time writing automated tests that cover all possible tasks required of the app and can be run at high-speed often. This helps us ensure changes we make in the future don't break existing functionality elsewhere.

More commonly though, this stage will involve sitting down with the end-user (be that you or potential customers) and observing them and asking questions. We can do a private release targetted at specific email addresses.

We'll also set up analytics so that we can collect data on user activity. This will help us uncover bugs and see what features are being used most.


---


So that's it! A well thought out, good looking, first version of your app. Hopefully it will have gone down well with test subjects and be ready for a wider launch.

At each stage, especially based on feedback in Stage 6, we can revisit any of the earlier stages of development and rethink something. It might be that users are put off by the colours used so we jump back to Stage 4 and redesign something. Maybe testers flag up a vital missing feature that we can go back to [Stage 2][stage2] and plan.

The whole process is flexible, but using this framework we can be sure that things progress in a logical way towards a quality app.


[part1]: /blog/app-dev-stages-part-1
[stage2]: /blog/app-dev-stages-part-1#stage-2---feature-design
[stage4]: #stage-4---visual-design
[stage5]: #stage-5---building-the-app
[stage6]: #stage-6---testing
[ps]: http://www.photoshop.com/

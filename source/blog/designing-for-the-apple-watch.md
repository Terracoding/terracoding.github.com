---
title: "Designing for the Apple Watch"
date: 2015-05-29
author: dominic
tags:
- ios
- app
- watch
- watchkit
- apple
summary_text: 'The Apple Watch is such a small and personal device, development of apps need to be approached in a completely different way to mobile. Here are a few thoughts and tips.'
---

Since the release of the Apple Watch, we have already had discussions with clients about how they were interested in releasing a watch app. As the Apple Watch is such a small and personal device, development of apps need to be approached in a completely different way to mobile.

We now have a very limited number of interactions:

- Force Touch (bring up menu options)
- Tap (tap an menu option or button)
- Scroll (scroll with the digital crown or using the touch display)

With the Apple Watch being on the wrist, the attention required of the user should be as short as possible. The user has to raise their wrist to use the interface and holding out an arm can get tiring very quickly.

What is being displayed should be exactly what the user needs right now and should cut out any form of fancy images or overlays that do not contribute to the information being conveyed.

As a quick example, a few weeks ago I built an Apple Watch app for [Sprinter](https://itunes.apple.com/app/sprinter/id568151529). Sprinter for iOS allows the user to see which tasks are assigned to whom, and which tasks are being worked on, completed or are yet to be started. It also allows the user to add items, view and reply to comments and view attachments.

Trying to copy as much functionality into a Watch app would have been crazy and borderline impossible technically. Right away I knew exactly what I could change to show only the information that is required by the user:

- Only show what is assigned to me
- Only show what is in-progress
- Option to switch project (using a Force Touch interaction)

These made sure that the app showed only what the user cared about. There was no need to scroll through tons of tasks that weren’t assigned to the user, and basically allowed the user to say “So that’s what I’m working on today”.

It’s quick and shortens the attention required of the user. There’s no way to create new tasks, or make and read comments. The user can do that on their phone or desktop if they want to read through lots of text and options.

Overall, Apple Watch apps are designed for short glances and not to consume content. They should be limited to display only what the user needs to see right now, nothing more. That's not a slight on the device; in fact, the simplified interaction is vital to its usefulness sitting pride of place on your wrist.

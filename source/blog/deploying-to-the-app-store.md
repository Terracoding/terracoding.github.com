---
title: "Deploying to the App Store"
date: 2015-04-16
author: dominic
tags:
- ios
- app
- store
- apple
---

When you or your team has finished developing their new iOS App, the focus then moves over to making sure it is ready for the App Store. This blog post will go over some fundamentals that you and your team will need to think about when submitting an app to the App Store.

# Testing

I can’t stress enough how important testing is when getting your app ready for the App Store. Unlike the web, you can't release small bug fixes every couple of days. Whilst some may say that this is a huge flaw with Apple having to review apps before they go live, I think it gives you a chance to think about the importance of what the first or latest release of an app will contain.

Apple provides us with two main ways of getting apps onto devices for testing:

### Xcode & Provisioning Profiles

I’m not going to go into much detail about this as it’s mainly aimed towards developers. The quickest way for an app to go into the developers hands is via Xcode itself. This is the tool that is used to write, debug and package iOS Apps.

It is fine for a small handful of developers who only need to look after their own devices, but when you want to start testing apps with more users who are not tech savvy, you’ll need to look at TestFlight.

### TestFlight

TestFlight is a service provided by Apple that allows you to give out new builds of an app to users so they can use the app before it’s released on the App Store. Unfortunately there are still some hurdles that need to be looked at before your app can be installed.

There are two types of user that can use TestFlight. These are Internal Testers and External Testers.

- Internal Testing
  - Limited to users who are counted as part of the organisation
  - Must have an Admin or Technical role on iTunes Connect
  - Limited to 25 members by default
  - Does not require Apple to review the build
- External Testing
  - Can be given to anyone with an email address
  - Must have iOS 8 installed for it to work
  - Limited to 1,000 testers
  - Requires Apple to review the build

When building for TestFlight, you must try to make sure you get a build reviewed by Apple as early as possible if you want any external testers trying out your application. In our past experience the review time for external testing was around 2 days.

# Localisation

I’ve seen it happen time and time again, people will spend all their time working on an app and be super excited for it to be submitted to the App Store, only to realise that they’ve forgotten that not everyone speaks English.

Apple allows you to create localised App Store descriptions when submitting, so make sure that if you want the marketing material to be in the users local language, you actually get people to translate the material well before you want to submit the application.

Secondly, don’t forget that it has been localised, if you change major features of the app, make sure you also update the localised versions of the material to keep in line with how the primary language reads. Remember that you will also have to update your screenshots on all localisations.

# Imagery

When submitting an App for the App Store, you’ll be required to add a large App Icon as well as some screenshots. These are the face of your application, they are as important, if not more, as your app name. The only way users can see if your app is the one they want to download is by browsing through the content they can see on the App Store.

To prevent any hiccups you’ll need icons and screenshots to be of a certain size and quality. Thankfully Apple provides a list of exactly how you should export your images on their [iTunes Connect Developer Guide](https://developer.apple.com/library/ios/documentation/LanguagesUtilities/Conceptual/iTunesConnect_Guide/Appendices/Properties.html).

# Review Times

Almost all clients ask Terracoding how long it will take from the app to be submitted until it’s actually live on the App Store. All I can say is that it varies. It can also depend on a lot of factors that may include:

- New iOS device being released
  - Usually when a new device with a different screen size comes out, developers will be pushing out lots of updates to make sure their app looks good on the new device
- New major iOS version released
  - As with any major release, Apple usually brings out new features that can be utilised in apps. Companies love adding in the new popular features into there apps, and with that comes a big spike of new apps or updates being submitted to Apple for review

Other than that, we can tell you that we’ve had new apps or updates accepted anywhere between 1 day and 1.5 months. Most often it’s between 1-2 weeks for a first app to be reviewed and accepted.

# Rejections

So you’ve followed all the advice above and your app has been rejected. Don’t panic! Rejections can happen for a long list of reasons, and most of them being from a small bug or a slight complaint about the meta data provided for the application.

Some common rejections could be:

- Link to a site that contains a payment form
  - If you’re app costs money, and you’re also linking to a site that has a payment form on it, you’ll probably get rejected.
- No demo account provided
  - If you’re app has any form of user accounts, you’ll need to provide Apple with a demo username and password for the app. Without this they will just reject your application
- UI Bugs
  - Make sure you test your application on the iOS Simulator without an onscreen keyboard. Developers can often forget that some users will and do use an external keyboard with their iOS device, and if apps break because of it, you will get rejected.
- Crashes
  - If your app crashes whilst Apple is reviewing the app, they will reject it. Make sure you have tested the app as if you were a brand new user, as well as someone who is logging in with an existing account.

A really good site to look at when making sure your app is App Store ready, is by having a good read through of [Apple’s iOS Human Interface Guidelines](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/MobileHIG/)  (or HIG for short). These contain all kinds of default behaviours for key components of iOS.

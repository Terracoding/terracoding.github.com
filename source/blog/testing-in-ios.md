---
title: "Testing in iOS"
date: 2012-09-08
author: Dominic Wroblewski
tags:
- ios
- tutorial
- testing
---

Since doing some programming in a TDD format, I realised the lack of documentation about testing in iOS. A number of the testing documents on the Apple Developer site have now vanished and redirect to "Real-World Testing", which is not desired.  The community behind Ruby (on Rails) seems to be heavily biased towards writing tests and testing a relatively large percentage of code coverage, if not all of it. Switching from a number of heavily tested projects in Rails to a new iOS application, I thought testing should be a large part of it to make sure everything was working.

## Test-Driven Development

Test-Driven Development (TDD) is a way of developing websites/applications by writing the most basic of tests, and making them pass with your code. By only writing enough code to past the tests, and nothing more, the coverage of tests can be endless. You will have the knowledge that almost anything you break will get tested and show up in red.

When developing Rails apps, I usually use features such as `rspec` and `cucumber` to run all my tests (including user interaction). Moving from testing in Rails to iOS was a little harder to find well documented steps.

## Testing in iOS

SenTestingKit (*OCUnit*) is the default testing library included in the Apple Docs (however some of the docs are pretty old). This is a simple unit testing kit for testing methods return the correct values, and runs very similar to the Java equivalent (JUnit). Most testing will be done with this kit when using Xcode, and with a few other libraries such as OCMock, you can develop iOS in a close-to-TDD way.

Creating tests using OCUnit is a very simple process that for each test, you create a method, and a simple comparison between objects, values etc.

A simple test can look like the following:

    - (void)testFullName
    {
        Person * person = [[Person alloc] init];
        [person setFirstName:@"John"];
        [person setLastName:@"Doe"];
        STAssertTrue([[person fullName] isEqualToString:@"John Doe"], @"");
        [person release];
    }

Testing certain UI elements can also be done using OCUnit. This requires you to share your view controller and view with the test implementation file. Such that:

    - (void) setUp {
        app_delegate    = [[UIApplication sharedApplication] delegate];
        myController    = app_delegate.myController;
        myView          = myController.view;
    }
    
    - (void)testUI
    {
        [myController press:[myView viewWithTag:1]];
        STAssertTrue([[myController.lbl text] isEqualToString:@"John Doe"], @"");
    }

## Mocking

OCMock is a tool that is used for creating and testing mock objects in your application. Mock objects are simulated objects that mimic the behaviour of real objects in an application.

Advantages of using mock objects:

- Testing objects that may not exist yet, or objects that may change behaviour
- Testing whilst not effecting a database
- Objects that may contain modified methods just for testing purposes

Mock objects can be tested as follows using OCMock:

    myMock = [OCMockObject mockForClass:[NSString class]];
    [[myMock expect] isEqualToString:@"myString"];
    [myMock isEqualToString:@"myString"];

## Instruments

Xcode's [instruments](http://developer.apple.com/library/ios/#documentation/DeveloperTools/Conceptual/InstrumentsUserGuide/Introduction/Introduction.html) are great for testing your application when using real or test data. This was something that I only started using pretty recently. Basically, Instruments are a set of tools that enable you to profile and track processes when testing your applications.

Originally, I had many problems when learning about memory management in CocoaTouch, I soon learnt the basics, but my only real knowledge came when profiling my applications and actually seeing graphics of where memory was being retained well after it should have been released.

Instruments gives you memory counters and graphics to see where abouts and at what time memory is being retained when it shouldn't. It also gives great insight into when memory is being allocated to objects, that may never get used. For example, initialising objects in `viewDidLoad` or in the controller `init` well before the object is being used may cause threads to hang whilst methods are being called, whereas a user may access the view controller without calling on the object. It also taught me when and where to initialise objects, and where to check if the object has already been initialised previously (for example, in methods that may get called a few times).

## Real-World Testing

I've never been so impressed with any iOS libraries as much as I have been with [TestFlight](https://testflightapp.com/). TestFlight is an awesome site where you can upload IPA's of your applications and have them delivered to testers over-the-air.

Using something like TestFlight means you can have them register their device using MobileSafari, and having their device id available for you to add them to the AdHoc provisioning on the Apple Developer site. TestFlight gives you an SDK that enables any error logs, NSLogs and checkpoints to be uploaded directly to the build reports on the website. Checkpoints on TestFlight let you check how deep testers are using your application. Other reports include how long a testers session lasts for and what devices the app has been installed onto.

I'd have to say, TestFlight is a god send when you have a group of beta testers that you want to deliver an app update to without having to email or sync any devices to iTunes.

## Conclusion

Testing in iOS may not be widely spoken about, however there are definitely some great tools to get you started. I've added a list of links below to give you some insight in setting up your iOS testing environment:

- [OCUnit](http://www.sente.ch/software/ocunit/)
- [OCMock](http://ocmock.org/)
- [GHUnit](https://github.com/gabriel/gh-unit)
- [iPhoneUnitTests](http://developer.apple.com/library/ios/#samplecode/iPhoneUnitTests/Introduction/Intro.html)


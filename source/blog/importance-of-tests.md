---
title: "Costs Saved When You Write Automated Tests"
date: 2013-10-23
category: Test Driven Development, Automated Tests
author: Iz El-Bahnasy
tags:
- testing
---

Just as the developer thinks it will be a smooth morning, they are bombarded with error reports or bug tickets on entrance to the office; the 5 year old software is broken again!

After some time debugging, the developer concludes that the bug was caused by a change introduced a couple of days ago.

"But why could we not prevent it from happening?"

"There were no tests!"

"Ah."

"We must increase the test coverage then!"

"We can, but it will be difficult to: 'draw up construction plans for a house, when we don't even know what's between the walls and what's under the floor'! "

The keyword in focus here is _construction plans_.

##Automated Testing as a Hidden Cost Saving

When it comes to collaboration on a software project, It is important for the technical team to have visibility into why feature decisions are made and how new features play out in the market.

This is just as important as for product owners (or the business development team) to have enough visibility into what is 'under the hood', and the infrastructure work required for building or changing features.

Automated testing is an integral part of any feature implementation.  A great automated test suite forms the solid infrastructure for maintainable software.  And Software that is difficult to maintain is costly.

While it is debatable if testing adds additional time to feature completion, we have witnessed that a good test suite certainly results in huge savings when it comes to changing or maintaining a product.

But because savings in developer costs during the actual building of a feature often cannot easily be quantified to a product owner, automated testing is sometimes not given the importance it should be, at the early stages of software building.

Therefore, the lack of a good test suite often disguises itself as a hidden cost.  A cost that doesn't bite till later.  The role of a developer is to emphasis to a product owner the importance of testing, mainly for the wellbeing of the product.

##The Analogy

At Terracoding we cannot emphasise the importance of automated tests enough. We illustrate its importance using this analogy:

A software product that lacks adequate automated tests is like building a skyscraper without construction plans.

In construction (where I first started out), building a structure from design plans is a given; it is standard everyday work.  You would not get approval otherwise.  Without plans, you would not know what to build and in what sequence.

Now, the argument against this analogy would be: in software we build from a product spec.  i.e. it is the product spec that is synonymous to construction plans for a building, not the tests.

That is correct.

However, consider this: Construction plans are used by engineers as a reference for carrying out maintenance work.  Maintenance in construction takes place on a schedule or when required (which typically isn't often).  This is when software projects are always changing and continuously evolving (i.e. maintenance takes place more often).

Unlike a construction project, a software application rarely becomes the final product when first released.

What automated testing offers is a way to automatically make sure that a product still works to the spec when a change is made.  The alternative is expensive human resources who manually test the product.

If the luxury of automation in maintenance was available in construction, a lot of money would be saved.  In fact, there are efforts in construction to use 3D modeling technologies to make use of automation, leading to cost savings.

##Different Techniques for Testing

Some of the naming conventions used by developers to describe techniques for testing and designing software include [Test Driven Development](http://en.wikipedia.org/wiki/Test-driven_development), [Test First Development](http://www.extremeprogramming.org/rules/testfirst.html) and [Behaviour Driven Development](http://en.wikipedia.org/wiki/Behavior-driven_development).  There are differences between these techniques, and choices are made subjectively.

However, no matter what methodology your developer chooses, the take away here is the importance of a good test suite as a primary expectation when commissioning developers.

Have you witnessed the monetary savings a good test suite has given your project or organisation? We would love your comments :)

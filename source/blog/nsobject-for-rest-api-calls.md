---
title: "NSObject for REST API Calls"
date: 2012-09-07
author: Dominic Wroblewski
tags:
- ios
- tutorial
---

In this tutorial I am going to teach you how to create your own `NSObject` that can make calls to your own web REST API and use it to retrieve the response received from the server. I am going to do this with the help of `ASIFormDataRequest` (`ASIHTTPRequest`). This will mean your iOS app will be able to make calls to your web server and download information to your app. The following tutorial is useful for if you want to perform tasks such as logging into an online account or registering a new user from within your application.

#### Getting Started - Initial Steps

Before we do anything, we need to create a new XCode iOS project. Do this, making sure that the project is a navigation-based project. Then we need to make sure that `ASIHTTPRequest` builds correctly in your project. So firstly, download it from their GitHub page here: Download Link. You then need to copy the files over into your project making sure iPhone projects have `ASIAuthenticationDialog.h/m` and `Reachability.h/m` included.Once you have included the files into your XCode project, the next step is to add the following frameworks into your project as well:

- CFNetwork.framework
- SystemConfiguration.framework
- MobileCoreServices.framework
- CoreGraphics.framework
- libz.1.2.3.dylib

After these initial steps, you should be able to build your project without any errors. If you do come into any problems, refer to the `ASIHTTPRequest` setup instructions.

#### Let's Do This!

Now you have the required classes in your project we can really start to have some fun! Let us start by creating an `NSObject` that will handle all the calls to your server and return only the necessary data back to your controllers. This is very useful as it keeps all the networking code away from your view controllers. By the end of this tutorial you will be able to use the following few lines of code to make a call to an API and return back information:

    DWNetwork * network = [[DWNetwork alloc] init];
    int response= [network sendTitle:@"My Title" withBody:@"This is the body for the post"];

For example, the two lines above would create our own object (in this case called `DWNetwork`) and the second line will use the object to send two strings to a web API. Later on in the tutorial I will show you how to use threading to make sure your application does not hang whilst this data is being sent.

#### Creating the NSObject

With your project already open, create a new file by clicking

    File > New > New File > Objective-C Class > Subclass of NSObject > Next

and then save the file as DWNetwork.

When we initialise the object from our controller, we want to return our `DWNetwork` object and use this method to initialise any values within our object. So from `DWNetwork.h`, make the file contain the following:

    #import
    @interface DWNetwork : NSObject
    - (DWNetwork *)init;
    @end

And the counterpart (DWNetwork.m) to contain:

    #import "DWNetwork.h"

    @implementation DWNetwork

    - (DWNetwork *)init
    {
      return self;
    }

    @end

Now with what we have written we can already create an instance of our object ready to make calls to it. Now we need to include `ASIHTTPRequest` into the application and make our first API call!

#### Including ASIFormDataRequest in the NSObject

All we have to do for this is include `#import "ASIFormDataRequest.h"` at the top of the `DWNetwork.m` file.

#### Making our first API call

As an example, I am going to use my DWNetwork object to create a blog post on a website using POST data to its API. The URL string that I am going to use is:

    http://website.com/api/blog/new_post

On the server this takes the following form POST keys:

    @"post_title"
    @"post_body"

So naturally, I want to create a public method in DWNetwork that allows me to pass in the __title__ and __body__ of a blog post that it will handle and send to the API in the correct format. To do this I first go into the header file and write the following line beneath the `init`:

    - (int) sendTitle:(NSString *)title withBody:(NSString *)body;

This lets other controllers that are using my object to see that this method is available and therefore can be used. Then within the implementation, I will write the following code:

    - (int) sendTitle:(NSString *)title withBody:(NSString *)body
    {
      return nil;
    }

Now our object has its first proper method that can be called (Albiet returns nil)!

Within this method we want to utilize the __title__ and __body__ that we pass into it plus use the URL that they are going to be posted to. Now we get down implementing ASIFormDataRequest that will take all this information and do something magical with it!

In the line above `return nil;` we will write the following:

    NSString * urlString = [NSString stringWithFormat:@"http://website.com/api/blog/new_post"];

This is the URL that `ASIFormDataRequest` will use. Then we write:

    ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];

If all is written down correctly, then building the project shouldn’t come up with any errors (although it will come up with a warning for a the unused request).Now we can start adding the title and body to our API call:

    [request setPostValue:title forKey:@"post_title"];
    [request setPostValue:body forKey:@"post_body"];

As I wrote previously, post_title and post_body are the keys that the REST API on the server will use for the title and body of the new blog post. So we use the `[request setPostValue:(id) forKey:(NSString *)];` to pass in our variables.

Finally, we call:

    [request startSynchronous];

to start up the connection to the API and transmit the data from our application.

Following this correctly so far, your `DWNetwork.m` file should look like the following:

    #import "DWNetwork.h"
    #import "ASIFormDataRequest.h"

    @implementation DWNetwork

    - (DWNetwork *)init
    {
      return self;
    }

    - (int) sendTitle:(NSString *)title withBody:(NSString *)body
    {
      NSString *urlString = [NSString stringWithFormat:@"http://website.com/api/blog/new_post"];

      ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
      [request setPostValue:title forKey:@"post_title"];
      [request setPostValue:body forKey:@"post_body"];
      [request startSynchronous];

      return nil;
    }

    @end

At the moment (if the server is set up correctly) the request will send the data to the server. However, we are yet to know if this has failed or succeeded. So our next step is to return the response status code from the server.

#### Returning the response status code

This is a very simple step as ASIFormDataRequest has a built in method to call to retrieve the status code from the server.

All we have to do is replace `return nil;` with `return [request responseStatusCode];`

This will return an int that can be checked by your application to notify the user of the response from the API call. For example, the following numbers may be returned:

    200 – Successful
    400 – Bad Request
    401 - Unauthorized
    403 – Forbidden
    404 – Not Found
    405 – Method Not Allowed

ASIFormDataRequest also allows you to return an NSString with different information. We won’t be using it yet, but in the future you could return methods such as:

    // Returns the status message
    return [request responseStatusMessage];
    // Returns the whole response as a string
    return [request responseString];

Now we have an NSObject (DWNetwork) that:

- Can be initialised
- Get sent an NSString of the post title and post body
- Send the strings to a server
- Check the response status code

Now you just have to link this up to the UI!

#### Creating a new thread

Threads are really useful and will come in handy when you create a web heavy application such as a Twitter client, online game etc. And the great thing is, they are so simple to implement! All we need to do is create the method that the actual thread runs, and two other methods that will handle the response once the thread has completed.

Modify your `RootViewController.m` file so that the following is added:

    - (void)post
    {
      [NSThread detachNewThreadSelector:@selector(postThread:) toTarget:self withObject:nil];
    }

    - (void)postThread:(NSConnection *)connection
    {
      NSLog(@"New thread started");
      NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

      DWNetwork * network = [[DWNetwork alloc] init];
      int response = [network sendTitle:titleField.text withBody:bodyField.text];
      if (response == 200) {
        [self performSelectorOnMainThread:@selector(postSuccess) withObject:nil waitUntilDone:YES];
      } else {
        [self performSelectorOnMainThread:@selector(postFailure) withObject:nil waitUntilDone:YES];
      }

      [pool release];
    }

    - (void)postSuccess
    {
      UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Success!"
                                                           message:@"Your post has been sent"
                                                          delegate:self
                                                 cancelButtonTitle:@"Ok"
                                                 otherButtonTitles:nil, nil];
      [alertView show];
      [alertView release];
    }

    - (void)postFailure
    {
      UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                           message:@"Your post failed to send"
                                                          delegate:self
                                                 cancelButtonTitle:@"Ok"
                                                 otherButtonTitles:nil, nil];
      [alertView show];
      [alertView release];
    }

Now when the user clicks a post button, the UI will not lock up, and also a UIAlertView will be shown with its contents dependant on whether the post succeeded or failed to send!

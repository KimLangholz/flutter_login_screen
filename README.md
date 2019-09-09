# A Flutter / Firebase login screen

A simple flutter/dart based login-screen that connects with Firebase Auth to enable users to sign-in/up with Email or through Facebook. 

It's created as a template that I or you can use in upcoming projects instead of having to reinvent the wheel over and over again.  

![Flutter login screen](/assets/screenshots/screenshot.png?raw=true)

## Getting Started With This Template

As it's based on Firebase and uses Facebook to login, you'll need to do the following to make it work:

### 1) Register your app on Firebase

Register on https://firebase.google.com/ and create your app in there.

Make sure to register it as both an android and iOS app. 

Go to Authentication -> Sign-In method and enable both Email/Password & Facebook. Follow Firebase' notes to set it up correctly. 

When done, go to the settings page for your app and fill out the following:

#### Android: 

* Package name of your flutter project
* SHA fingerprints for all your development environments. 

When done, download the google-services.json file and place it in your android/app/ folder. 

#### iOS

* AppNickname
* BundleID from your flutter project.

When done,download the GoogleService-Info.plist file and place it in the ios/runner/ folder.

IMPORTANT: This file should also be added to your Runner.xcodeproj through Xcode.

When you open the file in Xcode, find the Runner project in the left side menu and right click it. 

Select "Add Files to Runner", navigate to the file you just added to your ios/runner/ folder and select it. 

Now just close Xcode.

#### Additional resources:

* https://firebase.google.com/docs/flutter/setup
* https://pub.dev/packages/firebase_auth

### 2) Register your app on Facebook

Follow this quick setup guide: https://medium.com/flutterpub/firebase-fb-sign-in-and-flutter-7ab4bdc7172e

## Easy changes you can make:

As I've decided to follow the MVC pattern, you can easily change the text by navigating to the Model class in the main file. Also, all colors & text-styling should be easily changed by navigating to the Theme in the bottom of the main file. 

## Update Notes:

09-09-2019: Committed the vers. 1.00 of the login_screen. It's tested on both iOS and Android and should work fine on devices larger than an iPhone SE.

## Roadmap:

* Improve UX by testing it on additional phones. Making sure there're no overflow errors. 
* Add error messages to login form

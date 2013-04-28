Html5WebWrapperiOS
==================

A basic HTML5 Web Wrapper for iOS that supports adding a zip file of html content into the app bundle.


Usage
-----

Download the Zip project on your Mac, you will need the latest version of XCode installed.

You can run the application in the simulator with no change, if you want to run this application on a device, you will need to change the bundle name and create a Provisioning Profile and Certificates in your Apple Developer Account, you will need a paid Developer account to do this (I think its still $99 USD for this account with Apple).

Once you have your HTML code working, just zip it up.

You need to have the zip package containing a folder or "www" with the startup file of index.html, look at the included www.zip file for an example.

You will need to remove the existing www.zip file in the project (Right click and Delete) and then you can drag your version of www.zip onto the project (Make sure you select the copy checkbox at the top of the dialog).

Once you have this just Run the project, it will build the project with your new www.zip file included.

You should see the app start with the index.html file loaded in the startup view.

This is a free app that you can use for your own usage. No Limitations.

Please Enjoy!

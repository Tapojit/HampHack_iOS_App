# HampHack_iOS_App
This is an iOS app dedicated to the event HampHack, a yearly hackathon event in Hampshire College. Backend database and authentication (For event organizers only) is implemented in Firebase. App is available in App Store. Link: https://itunes.apple.com/us/app/hamp-hack-2017/id1222384071?ls=1&mt=8

# View Controllers
**Feeds-**
Contains social media news for event and will display important announcements during the event. Feeds are clickable and will take user to social media posts in an UIWebView. Push notifications activated for both. A timer counts down to the event's start. Another timer will start at the beginning of the event until it is over. Swift file: FirstViewController.swift
![Alt text](http://a5.mzstatic.com/us/r30/Purple122/v4/77/1a/a5/771aa5e1-edbd-ee83-b916-d63eefbc4b22/screen696x696.jpeg "Optional title")





**QR code-**
Creates and displays generated QR images for registration and workshops. Number of workshop tickets generated is kept track of in Firebase database. Such tickets can be verified using built-in scanner in **Scan** view controller. Swift file: SecondViewController.swift

![Alt text](http://a4.mzstatic.com/us/r30/Purple111/v4/39/bc/24/39bc2437-d452-e73f-322a-aa8516019d0e/screen696x696.jpeg "Optional title")
![Alt text](http://a1.mzstatic.com/us/r30/Purple111/v4/a6/b7/48/a6b748db-816b-77d3-2727-44b1f5912e37/screen696x696.jpeg "Optional title")

**Website-**
An UIWebView intent to HampHack Website. Swift file: ThirdViewController.swift

**Organizers-**
 **For organizers only**. Has email and password authentication exclusive only to event organizers. Swift file: Authentication.swift.

Successful authentication opens a new view controller. Here, organizers can post new announcements and feeds. Swift file: Organizers.swift.

Qrcode scanner is accessible from this view controller upon pressing camera button. Swift file: Scan.swift.

# Other Features:
**Notifications:**
 Push notifications sent using **OneSignal** based on changes to Firebase Database. Changes are detected using a node.js server script named **server.js**. 


# Important-Excluded Files and links:
For security issues, **google-services.plist** has been excluded.

# HampHack_iOS_App
This is an iOS app dedicated to the event HampHack, a yearly hackathon event in Hampshire College. Backend database and authentication (For event organizers only) is implemented in *Firebase*. App is available in App Store. Link: https://itunes.apple.com/us/app/hamp-hack-2017/id1222384071?ls=1&mt=8

# View Controllers
**Feeds-**
Contains social media news for event and will display important announcements during the event. Feeds are clickable and will take user to social media posts in an *UIWebView*. Push notifications activated for both. There is a timer located in the top right corner, which counts down to the event's start. It will reset when the event starts and count down to the end. Swift file: FirstViewController.swift
![Alt text](http://a5.mzstatic.com/us/r30/Purple122/v4/77/1a/a5/771aa5e1-edbd-ee83-b916-d63eefbc4b22/screen696x696.jpeg "Optional title")





**QR code-**
"QR tickets" for registration and workshops are generated and displayed here. *Firebase* database is used to keep track of limited number of workshop tickets made available and to cross-verify participants who registered through our website. These tickets can be verified using built-in scanner in **Scan** view controller. Swift file: SecondViewController.swift

![Alt text](http://a4.mzstatic.com/us/r30/Purple111/v4/39/bc/24/39bc2437-d452-e73f-322a-aa8516019d0e/screen696x696.jpeg "Optional title")
![Alt text](http://a1.mzstatic.com/us/r30/Purple111/v4/a6/b7/48/a6b748db-816b-77d3-2727-44b1f5912e37/screen696x696.jpeg "Optional title")

**Website-**
An *UIWebView intent* to HampHack Website. Swift file: ThirdViewController.swift

![Alt text](http://a3.mzstatic.com/us/r30/Purple122/v4/eb/e6/dd/ebe6dde8-c3d8-7a99-8e37-cfc8a529a32f/screen696x696.jpeg "Optional title")

**Organizers-**
 **For organizers only**. Allows email and password authentication, which is exclusive only to event organizers. Swift file: Authentication.swift.
 
 <img src="https://raw.githubusercontent.com/Tapojit/HampHack_iOS_App/master/sign%20in_ios.png" alt="alt text" width="392" height="696">

Successful authentication opens a new *view controller*. Here, organizers can post new announcements and feeds. Swift file: Organizers.swift.

<img src="https://raw.githubusercontent.com/Tapojit/HampHack_iOS_App/master/organize_iOS.png" alt="alt text" width="392" height="696">

Qrcode scanner is accessible from this *view controller* upon pressing camera button. Swift file: Scan.swift.

<img src="https://raw.githubusercontent.com/Tapojit/HampHack_iOS_App/master/scan_ios.png" alt="alt text" width="392" height="696">

# Other Features:
**Notifications:**
Push notifications are sent using **OneSignal**'s *RESTful API* based on changes to Firebase Database. Changes are detected using a node.js server script named **server.js** running in Google Cloud Platform's App Engine. 


# Important-Excluded Files and links:
For security issues, **google-services.plist** has been excluded.

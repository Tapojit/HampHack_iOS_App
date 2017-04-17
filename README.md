# HampHack_iOS_App
This is an iOS app dedicated to the event HampHack, a yearly hackathon event in Hampshire College. Backend database and authentication (For event organizers only) is implemented in Firebase.

# View Controllers
**Feeds-** Contains social media news for event and will display important announcements during the event. Feeds are clickable and will take user to social media posts in an UIWebView. Push notifications activated for both. A timer counts down to the event's start. Another timer will start at the beginning of the event until it is over. Swift file: FirstViewController.swift

**QR code-**
Creates and displays generated QR images for registration and workshops. Number of workshop tickets generated is kept track of in Firebase database. Such tickets can be verified using built-in scanner in **Scan** view controller. Swift file: SecondViewController.swift

**Website-**
An UIWebView intent to HampHack Website. Swift file: ThirdViewController.swift

**Organizers-**
 **For organizers only**. Has email and password authentication exclusive only to event organizers. Swift file: Authentication.swift.

Successful authentication opens a new view controller. Here, organizers can post new announcements and feeds. Swift file: Organizers.swift.

Qrcode scanner is accessible from this view controller upon pressing camera button. Swift file: Scan.swift.

# Important-Excluded Files and links:
For security issues, **google-services.plist** has been excluded.

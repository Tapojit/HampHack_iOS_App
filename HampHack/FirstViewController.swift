//
//  FirstViewController.swift
//  HampHack
//
//  Created by Tapojit Debnath Tapu on 3/3/17.
//  Copyright © 2017 HampHack_Tapojit. All rights reserved.
//

import UIKit
import FirebaseDatabase
import UserNotifications
import Foundation
import SystemConfiguration
class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var countDown: UILabel!
    let formatter=DateFormatter()
    
    let userCalendar=Calendar.current
    
    let requestedComponent : Set<Calendar.Component> = [
    Calendar.Component.day,
    Calendar.Component.hour,
    Calendar.Component.minute,
    Calendar.Component.second
    ]
    
    
    
    
    
    
    
    
    
    @IBOutlet weak var animLabel: UILabel!
    @IBOutlet weak var Feed: UITableView!
    
    var announ=""
    var databaseHandlerA: FIRDatabaseHandle?
    var posData = [String]()
    var key1=[Int]()
    
    var img=[String]()
    
    var key2=[Int]()
    var databaseHandler2: FIRDatabaseHandle?
    
    
    var URL=[String]()
    
    var key3=[Int]()
    var databaseHandler3: FIRDatabaseHandle?
    
    var ref: FIRDatabaseReference?
    
    var databaseHandler: FIRDatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(viewDidAppear(_:)), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
        
        
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timePrinter), userInfo: nil, repeats: true)
        
        timer.fire()
        
        if !isInternetAvailable()
        {
            alertDialog(title: "Warning!", text: "Please connect to the Internet")
        }
        
        
        
        Feed.delegate=self
        Feed.dataSource=self
        
        ref=FIRDatabase.database().reference()
        
        databaseHandler = ref?.child("HampHack").child("Feeds").observe(.childAdded, with: { (snapshot) in
            
            if self.posData.count==0{
                self.posData.insert((snapshot.value as? String)!, at: 0)
                self.key1.insert(Int(snapshot.key)!, at: 0)
                self.pushNoti(info: (snapshot.value as? String)!, title: "Feeds")
            }
            else {
                let key = Int(snapshot.key)!
                if key<self.key1[0]{
                    self.posData.insert((snapshot.value as? String)!, at: 0)
                    self.key1.insert(Int(snapshot.key)!, at: 0)
                    self.pushNoti(info: (snapshot.value as? String)!, title: "Feeds")
                }
                else{
                    self.posData.append((snapshot.value as? String)!)
                    self.key1.append(Int(snapshot.key)!)
                    self.pushNoti(info: (snapshot.value as? String)!, title: "Feeds")
                }
                
            }
            

            
            self.Feed.reloadData()
            
        })
        
        databaseHandler2 = ref?.child("HampHack").child("Icon").observe(.childAdded, with: { (snapshot) in
            
            if self.img.count==0{
                self.img.insert((snapshot.value as? String)!, at: 0)
                self.key2.insert(Int(snapshot.key)!, at: 0)
            }
            else {
                let key = Int(snapshot.key)!
                if key<self.key2[0]{
                    self.img.insert((snapshot.value as? String)!, at: 0)
                    self.key2.insert(Int(snapshot.key)!, at: 0)
                }
                else{
                    self.img.append((snapshot.value as? String)!)
                    self.key2.append(Int(snapshot.key)!)
                }
                
            }
            
            
            
            self.Feed.reloadData()
            
        })
        
        
        databaseHandler3 = ref?.child("HampHack").child("FeedsURL").observe(.childAdded, with: { (snapshot) in
            
            if self.URL.count==0{
                self.URL.insert((snapshot.value as? String)!, at: 0)
                self.key3.insert(Int(snapshot.key)!, at: 0)
            }
            else {
                let key = Int(snapshot.key)!
                if key<self.key3[0]{
                    self.URL.insert((snapshot.value as? String)!, at: 0)
                    self.key3.insert(Int(snapshot.key)!, at: 0)
                }
                else{
                    self.URL.append((snapshot.value as? String)!)
                    self.key3.append(Int(snapshot.key)!)
                }
                
            }
            
            
            
            self.Feed.reloadData()
            self.animate()
        })
        databaseHandlerA = ref?.child("HampHack").child("Announcements").observe(.value, with: { (snapshot) in
            
            let b=snapshot.value as? String
            
            if b=="null"
            {
                self.announ="No announcements available now. Tune in for more later."
                self.animLabel?.textColor=UIColor.gray
            }
            else {
                self.announ=b!
                self.animLabel?.textColor=UIColor.red
                self.pushNoti(info: b!, title: "Announcements")
            }
            self.animLabel?.text=self.announ
            self.Feed.reloadData()
            self.animate()
            
        })
        self.animate()
        
    }
    
    
    func timeCalculator(dateFormat: String, endTime: String, startTime: Date = Date()) -> DateComponents {
        formatter.dateFormat = dateFormat
        let _startTime = startTime
        let _endTime = formatter.date(from: endTime)
        
        
        let timeDifference = userCalendar.dateComponents(requestedComponent, from: _startTime, to: _endTime!)
        return timeDifference
    }
    
    func timePrinter() -> Void {
        let time = timeCalculator(dateFormat: "MM/dd/yyyy hh:mm:ss a", endTime: "4/14/2017 6:00:00 p")
        if (Date()>formatter.date(from: "4/15/2017 6:00:00 p")!){
            countDown.text="EVENT OVER!"
            countDown.textColor=UIColor.red
        }
        else if (Date()>formatter.date(from: "4/14/2017 6:00:00 p")!){
            let time2=timeCalculator(dateFormat: "MM/dd/yyyy hh:mm:ss a", endTime: "4/15/2017 6:00:00 p")
            countDown.text = "\(time2.day!) Days \(time2.minute!) Minutes \(time2.second!) Seconds"
            countDown.textColor=UIColor.green
            timerLabel.text="Hacking time remaining:"
        }

        
        else {
            
            countDown.text = "\(time.day!) Days \(time.minute!) Minutes \(time.second!) Seconds"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        databaseHandlerA = ref?.child("HampHack").child("Announcements").observe(.value, with: { (snapshot) in
            
            let b=snapshot.value as? String
            
            if b=="null"
            {
                self.announ="No announcements available now. Tune in for more later."
                self.animLabel?.textColor=UIColor.gray
            }
            else {
                self.announ=b!
                self.animLabel?.textColor=UIColor.red
                self.pushNoti(info: b!, title: "Announcements")
            }
            self.animLabel?.text=self.announ
            self.Feed.reloadData()
            self.animate()
            
        })
    }
    
    
    
    
    
    func animate(){
        
        self.animLabel.transform=CGAffineTransform(translationX: 500, y: 0)
        
        UIView.animate(withDuration: 10.0, delay: 0.0, options: [.repeat], animations: {
            self.animLabel.transform=CGAffineTransform(translationX: -500, y: 0)
        }) { (false) in
//            self.animLabel.transform=CGAffineTransform(translationX: 500, y: 0)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=Feed.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! FeedTableViewCell
        cell.FeedInfo.text=posData[indexPath.row]
        if !(img.count==0) && !(self.announ.isEmpty) {
            if img[indexPath.row]=="tw"
            {
                cell.FeedImage.image=UIImage(named: "twitter"+".jpg")
            }
            
            if img[indexPath.row]=="fb"
            {
                cell.FeedImage.image=UIImage(named: "fb"+".jpg")
            }
            
            if img[indexPath.row]=="hh"
            {
                cell.FeedImage.image=UIImage(named: "hh_logo_bckgrnd"+".jpg")
            }
            
            if img[indexPath.row]=="git"
            {
                cell.FeedImage.image=UIImage(named: "googl"+".jpg")
            }
        }


        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell=Feed.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        
        if cell.isSelected {
            let _val=URL[indexPath.row]
            if !(_val=="null"){
                performSegue(withIdentifier: "Website", sender: _val)
            }
            
            
        }
        self.Feed.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        
    }
    
    
    func pushNoti(info: String, title: String) -> Void {
        let content=UNMutableNotificationContent()
        content.title=title
        content.body=info
        content.badge=1
        
        let trigger=UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request=UNNotificationRequest(identifier: "Sent", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let d22=segue.destination as? ThirdViewController{
            if let ur=sender as? String{
                d22.urlP=ur
            }
        }
    }
    
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    func alertDialog(title: String, text: String)
    {
        let alert=UIAlertController(title: title, message: text, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }


}


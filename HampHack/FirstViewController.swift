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


    let formatter=DateFormatter()
    
    let userCalendar=Calendar.current
    
    let requestedComponent : Set<Calendar.Component> = [
    Calendar.Component.day,
    Calendar.Component.hour,
    Calendar.Component.minute,
    Calendar.Component.second
    ]

    @IBOutlet weak var day: UILabel!
    
    @IBOutlet weak var hr: UILabel!
    
    @IBOutlet weak var min: UILabel!
    
    @IBOutlet weak var sec: UILabel!
    
    @IBOutlet weak var emoji: UIImageView!
    
    
    
    
    
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
    
    var emojiHandler: FIRDatabaseHandle?
    
    var ref: FIRDatabaseReference?
    
    var databaseHandler: FIRDatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(viewDidAppear(_:)), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
        
        
        
        
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
            }
            else {
                let key = Int(snapshot.key)!
                if key<self.key1[0]{
                    self.posData.insert((snapshot.value as? String)!, at: 0)
                    self.key1.insert(Int(snapshot.key)!, at: 0)
                }
                else{
                    self.posData.append((snapshot.value as? String)!)
                    self.key1.append(Int(snapshot.key)!)
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
            
            self.emojiHandler=self.ref?.child("HampHack").child("Emoji").observe(.value, with: { (snapshot2) in
                let b=snapshot2.value as? String
                
                if(b=="cool")
                {
                    self.emoji.image=UIImage(named: "cool"+".jpg")
                }
                
                if(b=="drink")
                {
                    self.emoji.image=UIImage(named: "drink"+".jpg")
                }
                
                if(b=="eyes")
                {
                    self.emoji.image=UIImage(named: "eyes"+".jpg")
                }
                
                if(b=="headph")
                {
                    self.emoji.image=UIImage(named: "headph"+".jpg")
                }
                if(b=="nerd")
                {
                    self.emoji.image=UIImage(named: "nerd"+".jpg")
                }
                
                if(b=="noodles")
                {
                    self.emoji.image=UIImage(named: "noodles"+".jpg")
                }
                
                if(b=="owl")
                {
                    self.emoji.image=UIImage(named: "owl"+".jpg")
                }
                
                if(b=="pizza")
                {
                    self.emoji.image=UIImage(named: "pizza"+".jpg")
                }
                
                if(b=="prize")
                {
                    self.emoji.image=UIImage(named: "prize"+".jpg")
                }
                
                if(b=="rocket")
                {
                    self.emoji.image=UIImage(named: "rocket"+".jpg")
                }
                
                if(b=="sleep")
                {
                    self.emoji.image=UIImage(named: "sleep"+".jpg")
                }
                
                if(b=="taco")
                {
                    self.emoji.image=UIImage(named: "taco"+".jpg")
                }
                
                if(b=="time")
                {
                    self.emoji.image=UIImage(named: "time"+".jpg")
                }
                
            })
            
            
            let b=snapshot.value as? String
            
            if b=="null"
            {
                self.announ="No announcements available now. Tune in for more later."
                self.animLabel?.textColor=UIColor.gray
            }
            else {
                self.announ=b!
                self.animLabel?.textColor=UIColor.red

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
        let time = timeCalculator(dateFormat: "MM/dd/yyyy hh:mm:ss a", endTime: "4/14/2017 6:30:00 p")
        if (Date()>formatter.date(from: "4/15/2017 6:30:00 p")!){
            day.text="OVER!"
            hr.text="OVER!"
            min.text="OVER!"
            sec.text="OVER!"
            day.textColor=UIColor.red
            hr.textColor=UIColor.red
            min.textColor=UIColor.red
            sec.textColor=UIColor.red
        }
        else if (Date()>formatter.date(from: "4/14/2017 6:30:00 p")!){
            let time2=timeCalculator(dateFormat: "MM/dd/yyyy hh:mm:ss a", endTime: "4/15/2017 6:30:00 p")
            day.text="\(time2.day!)"
            hr.text="\(time2.hour!)"
            min.text="\(time2.minute!)"
            sec.text="\(time2.second!)"
            
            day.textColor=UIColor.green
            hr.textColor=UIColor.green
            min.textColor=UIColor.green
            sec.textColor=UIColor.green
        }

        
        else {
            
            day.text="\(time.day!)"
            hr.text="\(time.hour!)"
            min.text="\(time.minute!)"
            sec.text="\(time.second!)"
        }
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        UIApplication.shared.applicationIconBadgeNumber = 0
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
            if img[indexPath.row]=="inst"
            {
                cell.FeedImage.image=UIImage(named: "Instagram"+".jpg")
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
    
    @IBAction func unwindToFirst(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    
}


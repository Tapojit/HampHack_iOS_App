//
//  SecondViewController.swift
//  HampHack
//
//  Created by Tapojit Debnath Tapu on 3/3/17.
//  Copyright © 2017 HampHack_Tapojit. All rights reserved.
//

import UIKit
import CoreData
import FirebaseDatabase
import Foundation
import SystemConfiguration
class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tickets: UITableView!
    @IBOutlet weak var qrImage: UIImageView!
    
    var ref: FIRDatabaseReference?
    var databaseHandler: FIRDatabaseHandle?
    
    let ticketsL=["Registration",
                  "Idea Jam (6:45pm)",
                  "Pitch your product idea (7:15pm)",
                  "Virtual Reality Games for beginners (7:15pm)",
                  "Quick and dirty prototype 101 (7:15pm)",
                  "Viacom workshop (7:45pm)",
                  "Design Thinking (7:45pm)",
                  "Introduction to 3D printing (7:45pm)",
                  "Intro to Docker, app making (8:15pm)",
                  "Introduction to 3D Scanning (8:15pm)",
                  "Controlling things using mind waves (8:15pm)"]
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override var shouldAutorotate: Bool{
        return false
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (ticketsL.count)
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell=UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "ticketCell")
        cell.textLabel?.text=ticketsL[indexPath.row]
        cell.textLabel?.font=UIFont(descriptor: cell.textLabel!.font.fontDescriptor, size: 12)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let rename=UITableViewRowAction(style: .normal, title: "Rename") { (action, index) in
            let appDelegate=UIApplication.shared.delegate as! AppDelegate
            let context=appDelegate.persistentContainer.viewContext
            if indexPath.row==0
            {
                self.alTF(title: "Hey There!", text: "Please enter the full name you registered with", entity: "RegisTicket", context: context)
                self.tickets.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            }

        }
        rename.backgroundColor=UIColor.blue
        
        return [rename]
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell=tickets.dequeueReusableCell(withIdentifier: "ticketCell", for: indexPath)
        ref=FIRDatabase.database().reference()
        
        if cell.isSelected {
            let pos=indexPath.row
            
            let appDelegate=UIApplication.shared.delegate as! AppDelegate
            let context=appDelegate.persistentContainer.viewContext
            
            if pos==1
            {
                imgLoader(img: "ticket1", entity: "TicketFinal", context: context, ind: 1)
                
            }
            
            else if pos==2
            {
                imgLoader(img: "ticket2", entity: "TicketFinal", context: context, ind: 2)
            }
            
            else if pos==3
            {
                imgLoader(img: "ticket3", entity: "TicketFinal", context: context, ind: 3)
            }
            
            else if pos==4
            {
                imgLoader(img: "ticket4", entity: "TicketFinal", context: context, ind: 4)
            }
            else if pos==5
            {
                imgLoader(img: "ticket5", entity: "TicketFinal", context: context, ind: 5)
            }
            else if pos==6
            {
                imgLoader(img: "ticket6", entity: "TicketFinal", context: context, ind: 6)
            }
            
            else if pos==7
            {
                imgLoader(img: "ticket7", entity: "TicketFinal", context: context, ind: 7)
            }
                
            else if pos==8
            {
                imgLoader(img: "ticket8", entity: "TicketFinal", context: context, ind: 8)
            }
                
            else if pos==9
            {
                imgLoader(img: "ticket9", entity: "TicketFinal", context: context, ind: 9)
            }
            else if pos==10
            {
                imgLoader(img: "ticket10", entity: "TicketFinal", context: context, ind: 10)
            }
            
            else if pos==0
            {
                let request=NSFetchRequest<NSFetchRequestResult>(entityName: "RegisTicket")
                
                request.returnsObjectsAsFaults=false
                
                do
                {
                    let results=try context.fetch(request)
                    if results.count>0
                    {
                        for result in results as! [NSManagedObject]
                        {
                            if let name=result.value(forKey: "name") as? String
                            {
                                qrImage.image=generateQRCodeFromString(string: name)
                            }
                        }
                    }
                    else{
                        alTF(title: "Hey There!", text: "Please enter the full name you registered with", entity: "RegisTicket", context: context)
                    }
                }
                catch{
                    //error handling
                }
                
                
            }
            
            
            
        }
            self.tickets.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
        }
    
        
    
    
    func generateQRCodeFromString(string : String) -> UIImage? {
        let data=string.data(using: String.Encoding.ascii)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        let transform=CGAffineTransform(scaleX: 10, y: 10)
        let output = filter?.outputImage?.applying(transform)
        if !(output==nil)
        {
            return UIImage(ciImage: output!)
        }
        return nil
        
        
        
    }
    func imgLoader(img : String, entity: String, context : NSManagedObjectContext, ind: Int) -> Void {
        let request=NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        request.returnsObjectsAsFaults=false
        
        do
        {
            let results=try context.fetch(request)
            
            if results.count>0
            {
                print(results.count)
                var count=0
                for result in results as! [NSManagedObject]
                {
                    if ((result.value(forKey: img) as? Int) != 0)
                    {
                        qrImage.image=generateQRCodeFromString(string: ticketsL[ind])
                        break
                    }
                        
                    else if(count==results.count-1) {
                            imgCreator(img: img, entity: entity, context: context, ind: ind)
                        
                    }
                    count+=1
                }
            }
            else {
                imgCreator(img: img, entity: entity, context: context, ind: ind)

                
            }

            
        }
        catch
        {
            //Error Handling
        }

    }
    
    func imgCreator(img : String, entity: String, context : NSManagedObjectContext, ind: Int) -> Void {
        if (isInternetAvailable()==false)
        {
            alertDialog(title: "Warning!", text: "Internet Unavailable. Please connect to the Internet")
        }
        
        else {
            let newImg=NSEntityDescription.insertNewObject(forEntityName: entity, into: context)
            
            let varImg=generateQRCodeFromString(string: ticketsL[ind])
            
            

            
            ref?.child("HampHack").child("QR").child(img).observeSingleEvent(of: .value, with: { (snapshot) in
                let valString=snapshot.value as? Int ?? 0
                var value=Int(valString)
                
                if(!(value==0))
                {
                    newImg.setValue(1, forKey: img)
                    do
                    {
                        try context.save()
                        self.qrImage.image=varImg
                        
                    }
                    catch
                    {
                        //Save error handling
                    }
                    value=value-1
                }
                else {
                    self.alertDialog(title: "Warning!", text: "Sorry, no tickets available")
                }
                
                self.ref?.child("HampHack").child("QR").child(img).setValue(value)
                
                
                
            })
            
        }
        


    }
    
    func imgLoader2(img : String) -> Void {
        if let data=UserDefaults.standard.object(forKey: img)
        {
            qrImage.image=UIImage(data: data as! Data)
        }
        else{
            let imgcr=generateQRCodeFromString(string: img)
            let imageData=UIImageJPEGRepresentation(imgcr!, 1)
            UserDefaults.standard.set(imageData, forKey: img)
            qrImage.image=imgcr
        }
        
    }
    
    func alertDialog(title: String, text: String)
    {
        let alert=UIAlertController(title: title, message: text, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func alTF(title: String, text: String, entity: String, context : NSManagedObjectContext) {
        let alert=UIAlertController(title: title, message: text, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField { (textField:UITextField) in
            textField.placeholder="Enter something"
        }
        
        let action=UIAlertAction(title: "Submit", style: UIAlertActionStyle.default) { [weak self](paramAction:UIAlertAction!) in
            if let textFields=alert.textFields{
                let theTextFields=textFields as [UITextField]
                let enteredText=theTextFields[0].text
                
                let newImg=NSEntityDescription.insertNewObject(forEntityName: entity, into: context)
                
                newImg.setValue(enteredText, forKey: "name")
                do
                {
                    try context.save()
                    
                }
                catch
                {
                    //Save error handling
                }
                
                let varImg=self?.generateQRCodeFromString(string: enteredText!)
                self?.qrImage.image=varImg
            }
        }
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
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
    
    
        
    
    
}





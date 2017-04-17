//
//  Organizer.swift
//  HampHack
//
//  Created by Tapojit Debnath Tapu on 3/12/17.
//  Copyright © 2017 HampHack_Tapojit. All rights reserved.
//

import UIKit
import FirebaseDatabase

class Organizer: UIViewController, UITextFieldDelegate {
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        changeVC()
    }
    
    var ref:FIRDatabaseReference?

    @IBOutlet weak var announcementsTF: UITextField!
    
    @IBOutlet weak var feedTF: UITextField!
    
    @IBOutlet weak var urlTF: UITextField!
    @IBOutlet weak var emoji: UITextField!
    
    @IBOutlet weak var imgTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addEntry(_ sender: UIBarButtonItem) {
        ref=FIRDatabase.database().reference()


        if(!(announcementsTF.text=="") && !(emoji.text==""))
        {
            if ((announcementsTF.text?.characters.count)!>40)
            {
                alertDialog(title: "Warning!", text: "Number of characters has exceeded limit of 40")
            }
            else
            {
                self.ref?.child("HampHack").child("Announcements").setValue(announcementsTF.text)
                announcementsTF.text=""
                
                self.ref?.child("HampHack").child("Emoji").setValue(emoji.text)
                emoji.text=""
            }
            
            
        }
        if(!(feedTF.text=="") && !(urlTF.text=="") && !(imgTF.text==""))
        {
            ref?.child("HampHack").child("Feeds").observeSingleEvent(of: .value, with: { (snapshot) in
                for child in snapshot.children
                {
                    let y=Int(((child as? FIRDataSnapshot)?.key)!)
                    self.ref?.child("HampHack").child("Feeds").child(String(y!-1)).setValue(self.feedTF.text)
                    self.ref?.child("HampHack").child("FeedsURL").child(String(y!-1)).setValue(self.urlTF.text)
                    self.ref?.child("HampHack").child("Icon").child(String(y!-1)).setValue(self.imgTF.text)
                    self.feedTF.text=""
                    self.urlTF.text=""
                    self.imgTF.text=""
                    break
                }
            })
        
        }
        
        
        
        
    }
    
    @IBAction func unwindToOrganizer(segue: UIStoryboardSegue) {
        
    }
    
    func alertDialog(title: String, text: String)
    {
        let alert=UIAlertController(title: title, message: text, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func changeVC() -> Void {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Tab")
        self.present(nextViewController, animated:true, completion:nil)
    }
    

    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

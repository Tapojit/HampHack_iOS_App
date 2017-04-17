//
//  Authentication.swift
//  HampHack
//
//  Created by Tapojit Debnath Tapu on 3/11/17.
//  Copyright © 2017 HampHack_Tapojit. All rights reserved.
//

import UIKit
import FirebaseAuth
class Authentication: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        if let email=emailTextField.text, let pass=passwordTextField.text
        {
            FIRAuth.auth()?.signIn(withEmail: email, password: pass, completion: { (user, error) in
                if let u=user{
                    self.performSegue(withIdentifier: "organizerInput", sender: self)
                }
                else {
                    self.alertDialog(title: "Warning!", text: "Login Failed")
                }
            })
        }
        
        else {
            alertDialog(title: "Warning!", text: "Email or Password missing!")
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    func alertDialog(title: String, text: String)
    {
        let alert=UIAlertController(title: title, message: text, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func unwindToAuthentication(segue: UIStoryboardSegue) {
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField==emailTextField)
        {
            scrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
        }
        else
        {
            scrollView.setContentOffset(CGPoint(x: 0, y: 150), animated: true)
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
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

//
//  ThirdViewController.swift
//  HampHack
//
//  Created by Tapojit Debnath Tapu on 3/3/17.
//  Copyright © 2017 HampHack_Tapojit. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UIScrollViewDelegate {
    
    
    
    private var _urlP=String()
    
    var urlP: String{
        get {
            return _urlP
        } set {
            _urlP = newValue
        }
    }
    

    @IBOutlet weak var web: UIWebView!
    
    var hhURLS = "http://hamphack.hampshire.edu"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var val=self.hhURLS
        if !self._urlP.isEmpty{
            val=self._urlP
        }
        // Do any additional setup after loading the view.
        let hhURL=URL(string: val)
        let hh=URLRequest(url: hhURL!)
        web.loadRequest(hh)
        web.scrollView.delegate=self
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if (scrollView.contentOffset.y<0)
        {
            changeVC()
        }
    }
    
    func changeVC() -> Void {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Tab")
        self.present(nextViewController, animated:true, completion:nil)
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func SwipeLeft(_ sender: UISwipeGestureRecognizer) {
        web.goForward()
    }
    
    @IBAction func SwipeRight(_ sender: UISwipeGestureRecognizer) {
        web.goBack()
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

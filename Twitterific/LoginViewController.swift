//
//  ViewController.swift
//  Twitterific
//
//  Created by Aditya Purandare on 14/02/16.
//  Copyright © 2016 Aditya Purandare. All rights reserved.
//

import UIKit
import BDBOAuth1Manager



class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                
            }
        }
    }
}


//
//  ComposeTweetViewController.swift
//  Twitterific
//
//  Created by Aditya Purandare on 27/02/16.
//  Copyright © 2016 Aditya Purandare. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    
    var defaultText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(defaultText)
        // Do any additional setup after loading the view.
        tweetTextView.text = defaultText
        tweetTextView.becomeFirstResponder()
        tweetTextView.delegate = self
        
    }
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let newLength:Int = (textView.text as NSString).length + (text as NSString).length - range.length
        let remainingChar:Int = 140 - newLength
        counterLabel.text = "\(remainingChar) left"
        
        return (newLength < 140)

    }
    @IBAction func onSendTweet(sender: AnyObject) {
        TwitterClient.sharedInstance.sendNewTweet(["status": tweetTextView.text!]) { (response, error) -> () in
            if (error == nil){
                self.navigationController?.popViewControllerAnimated(true)
            }else{
                let alert = UIAlertController(title: nil, message: "Tweet Update Failed", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
                self.presentViewController(alert,animated: true,completion: nil)
            }
        }
    }
            override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

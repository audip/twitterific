//
//  TweetDetailsViewController.swift
//  Twitterific
//
//  Created by Aditya Purandare on 26/02/16.
//  Copyright © 2016 Aditya Purandare. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    var tweet: Tweet!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var favoriteStatus: Bool = false
    var retweetStatus: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.retweetButton.selected = false
        self.favoriteButton.selected = false
        
        if let imageURL = tweet.user!.profileImageUrl {
            profileImageView.setImageWithURL(NSURL(string: imageURL)!)
        } else {
            profileImageView.image = nil
        }
        screennameLabel.text = tweet.user!.name!
        usernameLabel.text = "@\(tweet.user!.screenname!)"
        tweetLabel.text = tweet.text!
        //timestampLabel.text = "\(tweet.createdAt!)"
        timestampLabel.text = "\(tweet.createdAt!)"
        retweetLabel.text = "\(tweet.retweetedCount!)"
        likeLabel.text = "\(tweet.favoriteCount!)"
        self.favoriteStatus = tweet.favoriteStatus!
        self.retweetStatus = tweet.retweetedStatus!
        
        if favoriteStatus == true {
            self.favoriteButton.selected = true
        } else {
            self.favoriteButton.selected = false
        }
        if retweetStatus == true {
            self.retweetButton.selected = true
        } else {
            self.retweetButton.selected = false
        }
        
    }
    @IBAction func onRetweet(sender: AnyObject) {
        if retweetStatus == false{
            retweetLabel.text = "\(Int(retweetLabel.text!)! + 1)"
            retweetStatus = true
            self.retweetButton.selected = true
        }
        else {
            retweetLabel.text = "\(Int(retweetLabel.text!)! - 1)"
            retweetStatus = false
            self.retweetButton.selected = false
        }

    }
    @IBAction func onFavorite(sender: AnyObject) {
        if favoriteStatus == false{
            likeLabel.text = "\(Int(likeLabel.text!)! + 1)"
            favoriteStatus = true
            self.favoriteButton.selected = true
        }
        else {
            likeLabel.text = "\(Int(likeLabel.text!)! - 1)"
            favoriteStatus = false
            self.favoriteButton.selected = false
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

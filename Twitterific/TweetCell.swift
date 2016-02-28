//
//  TweetCell.swift
//  Twitterific
//
//  Created by Aditya Purandare on 19/02/16.
//  Copyright © 2016 Aditya Purandare. All rights reserved.
//

import UIKit
import AFNetworking

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var favoriteStatus: Bool = false
    var retweetStatus: Bool = false
    
    var tweet: Tweet! {
        didSet{
            //Configure images
            if let imageURL = tweet.user?.profileImageUrl {
                profileImageView.setImageWithURL(NSURL(string: imageURL)!)
            } else {
                profileImageView.image = nil
            }
            nameLabel.text = tweet.user!.name!
            usernameLabel.text = "@\(tweet.user!.screenname!)"
            tweetTextLabel.text = tweet.text!
            //timestampLabel.text = "\(tweet.createdAt!)"
            timestampLabel.text = "\(convertTimeToString(Int(NSDate().timeIntervalSinceDate(tweet.createdAt!))))"
            retweetCountLabel.text = "\(tweet.retweetedCount!)"
            favoriteCountLabel.text = "\(tweet.favoriteCount!)"
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

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func convertTimeToString(number: Int) -> String{
        let day = number/86400
        let hour = (number - day * 86400)/3600
        let minute = (number - day * 86400 - hour * 3600)/60
        if day != 0{
            return String(day) + "d"
        }else if hour != 0 {
            return String(hour) + "h"
        }else{
            return String(minute) + "m"
        }
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        if retweetStatus == false {
            TwitterClient.sharedInstance.retweetWithTweetID(["tweet_id": tweet.tweetID!], completion: { (response, error) -> Void in
                if (error == nil) {
                    self.retweetCountLabel.text = "\(Int(self.retweetCountLabel.text!)! + 1)"
                    self.retweetStatus = true
                    self.retweetButton.selected = true
                    print("Tweet retweeted")
                } else {
                    print("Retweet failed: \(error!.description)")
                }
                
            })
        } else {
            TwitterClient.sharedInstance.unretweetWithTweetID(["tweet_id": tweet.tweetID!], completion: { (response, error) -> Void in
                if (error == nil) {
                    self.retweetCountLabel.text = "\(Int(self.retweetCountLabel.text!)! - 1)"
                    self.retweetStatus = false
                    self.retweetButton.selected = false
                    print("Tweet unretweeted")
                } else {
                    print("Unretweet failed: \(error!.description)")
                }
            })
        }
        
    }

    @IBAction func onFavorite(sender: AnyObject) {
        if favoriteStatus == false{
            TwitterClient.sharedInstance.favoriteWithTweetID(["tweet_id": tweet.tweetID!], completion: { (response, error) -> Void in
                if (error == nil) {
                    self.favoriteCountLabel.text = "\(Int(self.favoriteCountLabel.text!)! + 1)"
                    self.favoriteStatus = true
                    self.favoriteButton.selected = true
                    print("Tweet favorited")
                } else {
                    print("Favorite failed: \(error!.description)")
                }
                
            })
        }
        else {
            TwitterClient.sharedInstance.unretweetWithTweetID(["tweet_id": tweet.tweetID!], completion: { (response, error) -> Void in
                if (error == nil) {
                    self.favoriteCountLabel.text = "\(Int(self.favoriteCountLabel.text!)! - 1)"
                    self.favoriteStatus = false
                    self.favoriteButton.selected = false
                    print("Tweet favorited")
                } else {
                    print("Unfavorite failed: \(error!.description)")
                }
            })
        }
    }

}

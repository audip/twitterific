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
        print("Retweet button clicked")
        print("Retweet Status: \(retweetStatus)")
        if retweetStatus == false{
            retweetCountLabel.text = "\(Int(retweetCountLabel.text!)! + 1)"
            retweetStatus = true
            self.retweetButton.selected = true
        }
        else {
            retweetCountLabel.text = "\(Int(retweetCountLabel.text!)! - 1)"
            retweetStatus = false
            self.retweetButton.selected = false
        }
        
    }
    @IBAction func onFavorite(sender: AnyObject) {
        print("Favorite button clicked")
        print("Favorite Status: \(favoriteStatus)")
        if favoriteStatus == false{
            favoriteCountLabel.text = "\(Int(favoriteCountLabel.text!)! + 1)"
            favoriteStatus = true
            self.favoriteButton.selected = true
        }
        else {
            favoriteCountLabel.text = "\(Int(favoriteCountLabel.text!)! - 1)"
            favoriteStatus = false
            self.favoriteButton.selected = false
        }
    }

}

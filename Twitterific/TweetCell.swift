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
        timestampLabel.text = "\(tweet.createdAt!)"
        retweetCountLabel.text = "\(tweet.retweetedCount!)"
        favoriteCountLabel.text = "\(tweet.favoriteCount!)"
        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        favoriteButton.setImage(UIImage(named:"heart.png"), forState:UIControlState.Normal)
        retweetButton.setImage(UIImage(named:"retweet.png"), forState:UIControlState.Normal)
        retweetButton.setImage(UIImage(named: "retweet-on.png"), forState: UIControlState.Selected)
        favoriteButton.setImage(UIImage(named:"heart-on.png"),forState: UIControlState.Selected)
        favoriteButton.setImage(UIImage(named:"heart.png"),forState: UIControlState.Normal)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
//            retweetButton.setImage(UIImage(named:"retweet.png"),forState: UIControlState.Normal)
            retweetCountLabel.text = "\(Int(retweetCountLabel.text!)! - 1)"
            retweetStatus = false
            self.retweetButton.selected = false
        }
        
    }
    @IBAction func onFavorite(sender: AnyObject) {
        print("Favorite button clicked")
        print("Favorite Status: \(favoriteStatus)")
        if favoriteStatus == false{
//            favoriteButton.setImage(UIImage(named:"heart-on.png"),forState: UIControlState.Selected)
            favoriteCountLabel.text = "\(Int(favoriteCountLabel.text!)! + 1)"
            favoriteStatus = true
            self.favoriteButton.selected = true
        }
        else {
//            favoriteButton.setImage(UIImage(named:"heart.png"),forState: UIControlState.Normal)
            favoriteCountLabel.text = "\(Int(favoriteCountLabel.text!)! - 1)"
            favoriteStatus = false
            self.favoriteButton.selected = false
        }
    }

}

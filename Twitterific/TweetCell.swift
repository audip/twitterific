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
        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

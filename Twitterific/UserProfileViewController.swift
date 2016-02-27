//
//  UserProfileViewController.swift
//  Twitterific
//
//  Created by Aditya Purandare on 27/02/16.
//  Copyright © 2016 Aditya Purandare. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usernameLabel.text = user.name!
        handleLabel.text = "@\(user.screenname!)"
        tweetsCountLabel.text = "\(user.tweets_count!)"
        followingLabel.text = "\(user.following_count!)"
        followersLabel.text = "\(user.followers_count!)"
        if let imageURL = user.profile_image_url {
            profileImageView.setImageWithURL(NSURL(string: imageURL)!)
        } else {
            profileImageView.image = nil
        }
        if let imageURL = user.profile_background_image_url {
            backgroundImageView.setImageWithURL(NSURL(string: imageURL)!)
        } else {
            backgroundImageView.image = nil
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

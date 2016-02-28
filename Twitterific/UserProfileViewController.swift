//
//  UserProfileViewController.swift
//  Twitterific
//
//  Created by Aditya Purandare on 27/02/16.
//  Copyright © 2016 Aditya Purandare. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    var user: User!
    var tweets: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        usernameLabel.text = user.name!
        handleLabel.text = "@\(user.screenname!)"
        tweetsCountLabel.text = "\(user.tweets_count!)"
        followingLabel.text = "\(user.following_count!)"
        followersLabel.text = "\(user.followers_count!)"
        bioLabel.text = user.biographic!
        if let imageURL = user.profileImageUrl {
            userImageView.setImageWithURL(NSURL(string: imageURL)!)
        } else {
            userImageView.image = nil
        }
        if let imageURL1 = user.profile_background_image_url {
            backgroundImageView.setImageWithURL(NSURL(string: imageURL1)!)
        } else {
            backgroundImageView.image = nil
        }
        
        TwitterClient.sharedInstance.userTimeLineWithParams(["user_id":user.userID!], completion: {(tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweet = tweets![indexPath.row]
        cell.selectionStyle = .None
        cell.contentView.layer.cornerRadius = 5
        cell.contentView.layer.masksToBounds = true
        
        return cell
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

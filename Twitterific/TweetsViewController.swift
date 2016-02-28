//
//  TweetsViewController.swift
//  Twitterific
//
//  Created by Aditya Purandare on 17/02/16.
//  Copyright © 2016 Aditya Purandare. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationBarDelegate{
    
    @IBOutlet weak var tableView: UITableView!    
    
    var tweets: [Tweet]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
//        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 64)) // Offset by 20 pixels vertically to take the status bar into account
//        
//        navigationBar.backgroundColor = UIColor.whiteColor()
//        navigationBar.delegate = self;
//        
//        // Create a navigation item with a title
//        let navigationItem = UINavigationItem()
//        navigationItem.title = "Home"
//        
//        // Create left and right button for navigation item
//        let leftButton =  UIBarButtonItem(title: "Logout", style:   UIBarButtonItemStyle.Plain, target: self, action: "onLogout:")
//        let rightButton = UIBarButtonItem(title: "Tweet", style: UIBarButtonItemStyle.Plain, target: self, action: "newTweet:")
//        
//        // Create two buttons for the navigation item
//        navigationItem.leftBarButtonItem = leftButton
//        navigationItem.rightBarButtonItem = rightButton
//        
//        // Assign the navigation item to the navigation bar
//        navigationBar.items = [navigationItem]
//        
//        // Make the navigation bar a subview of the current view controller
//        self.view.addSubview(navigationBar)
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)

        TwitterClient.sharedInstance.homeTimeLineWithParams(nil, completion: {(tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })
        print(User.currentUser!)
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
        
        let userProfileTapAction = UITapGestureRecognizer(target: self, action: "profileTap:")
        cell.profileImageView.tag = indexPath.row
        cell.profileImageView.userInteractionEnabled = true
        cell.profileImageView.addGestureRecognizer(userProfileTapAction)
        
        let tweetDetailsTapAction = UITapGestureRecognizer(target: self, action: "tweetTextTap:")
        cell.tweetTextLabel.tag = indexPath.row
        cell.tweetTextLabel.userInteractionEnabled = true
        cell.tweetTextLabel.addGestureRecognizer(tweetDetailsTapAction)
        
        return cell
    }

    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        TwitterClient.sharedInstance.homeTimeLineWithParams(nil, completion: {(tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })
        
        // Tell the refreshControl to stop spinning
        refreshControl.endRefreshing()	

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func profileTap(sender: UITapGestureRecognizer){
        if sender.state != .Ended{
            return
        }
        let index = sender.view?.tag
        if let index = index{
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as! TweetCell
            self.performSegueWithIdentifier("UserProfile", sender: cell);
        }
    }
    func tweetTextTap(sender: UITapGestureRecognizer){
        if sender.state != .Ended{
            return
        }
        let index = sender.view?.tag
        if let index = index{
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as! TweetCell
            self.performSegueWithIdentifier("TweetDetails", sender: cell);
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let cell = sender as? UITableViewCell{
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]

            if segue.identifier == "TweetDetails"{
                print("Tweet details screen")
                let tweetDetailsViewController = segue.destinationViewController as! TweetDetailsViewController
                tweetDetailsViewController.tweet = tweet
            } else if segue.identifier == "UserProfile" {
                print("UserProfile screen")
                let userProfileViewController = segue.destinationViewController as! UserProfileViewController
                userProfileViewController.user = tweet.user
            } else if segue.identifier == "TweetBack" {
                print("TweetBack Screen")
                let composeTweetViewController = segue.destinationViewController as! ComposeTweetViewController
                print("@\(tweet.user!.screenname!)")
                composeTweetViewController.defaultText = "@\(tweet.user!.screenname!)"
                composeTweetViewController.tweetTextView.text = "@\(tweet.user!.screenname!)"
            }
        } else if segue.identifier == "currentUserProfile"{
            let userProfileViewController = segue.destinationViewController as! UserProfileViewController
            userProfileViewController.user = User.currentUser!
        } 
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

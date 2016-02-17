//
//  TwitterClient.swift
//  Twitterific
//
//  Created by Aditya Purandare on 15/02/16.
//  Copyright © 2016 Aditya Purandare. All rights reserved.
//

import UIKit
import BDBOAuth1Manager 

let twitterBaseURL = NSURL(string: "https://api.twitter.com")
let twitterConsumerKey = "3PIBp35bTWx29T72BiKhE2hQD"
let twitterConsumerSecret = "jACfwaxOB5KH8vfni3xSxYUUGeCRyWDRv57IvsjJfdSE6qGL0C"

class TwitterClient: BDBOAuth1SessionManager {

    var loginCompletion: ((user: User?, error: NSError?) -> ())?

    class var sharedInstance: TwitterClient {
        struct Static {
                static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
            }
        return Static.instance
    }

    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        // Fetch request token & redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterificaudi://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token")
            
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
        }) { (error: NSError!) in
            print("Failed to get request token")
            self.loginCompletion?(user: nil, error: error )
        }
    }
    
    func openURL(url: NSURL){
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) in
            
            print("Got the access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) in
                // print("user: \(response!)")
                var user = User(dictionary: response as! NSDictionary)
                print("user: \(user.name)")
                self.loginCompletion?(user: user, error: nil)
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError) in
                    print("error getting current user")
                    self.loginCompletion?(user: nil, error: error )

            })
            
            TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) in
                // print("user: \(response!)")
                var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                
                for tweet in tweets {
                    print("text: \(tweet.text), createdAt: \(tweet.createdAt)")
                }
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError) in
                    print("error getting current user")
            })
            
        }) { (error: NSError!) in
            print("Failed to recieve access token")
            self.loginCompletion?(user: nil, error: error )
        }
 
    }
}

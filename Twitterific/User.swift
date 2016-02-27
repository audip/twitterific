//
//  User.swift
//  Twitterific
//
//  Created by Aditya Purandare on 15/02/16.
//  Copyright © 2016 Aditya Purandare. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary
    var tweets_count: Int?
    var followers_count: Int?
    var following_count: Int?
    var location: String?
    var profile_background_image_url: String?
    var profile_image_url: String?
    var userID: String?
    var following: Bool?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
        tweets_count = dictionary["listed_count"] as? Int
        followers_count = dictionary["followers_count"] as? Int
        following_count = dictionary["friends_count"] as? Int
        location = dictionary["location"] as? String
        profile_image_url = dictionary["profile_image_url_https"] as? String
        profile_background_image_url = dictionary["profile_background_image_url_https"] as? String

        userID = dictionary["id_str"] as? String
        following = dictionary["following"] as? Bool
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    let dictionary:NSDictionary = NSKeyedUnarchiver.unarchiveObjectWithData(data!)! as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
        
            if _currentUser != nil {
                let data : NSData = NSKeyedArchiver.archivedDataWithRootObject((user?.dictionary)!)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }

}

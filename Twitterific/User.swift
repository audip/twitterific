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

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
    }
    
    class var currentUser: User? {
        get {
            if currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as NSData
                if data != nil {
                    let dictionary:NSDictionary = NSKeyedUnarchiver.unarchiveObjectWithData(data!)! as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }1
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

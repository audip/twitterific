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

class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
    return Static.instance
    }
}

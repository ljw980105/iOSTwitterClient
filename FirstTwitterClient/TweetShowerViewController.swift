//
//  ViewController.swift
//  FirstTwitterClient
//
//  Created by Jing Wei Li on 12/20/17.
//  Copyright © 2017 Jing Wei Li. All rights reserved.
//

import UIKit
import TwitterKit

class TweetShowerViewController: UIViewController {
    
    @IBOutlet weak var showTweetButton: UIButton!
    @IBOutlet weak var tweetField: UILabel!
    //var tweetView: TWTRTweetView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func showTweets() -> Void {
        let client = TWTRAPIClient() // generates a twitter client
//        client.loadTweet(withID: "921872668223332352") { tweet, error in
//            if tweet != nil{
//                //let tweetView = TWTRTweetView(tweet: t)
//                self.tweetField.text = tweet?.text
//                //self.tweetView.configure(with: tweet)
//            } else {
//                print("Failed to load Tweet:" + (error?.localizedDescription)!)
//            }
//        }
        client.loadUser(withID: "1250167489") { user, error in
            if user != nil {
                self.tweetField.text = user?.screenName
            } else {
                if error == nil{
                    print ("no error")
                } else{
                    print(error!)
                }
            }
        }
    }

    @IBAction func showTweetAction(_ sender: UIButton) {
        showTweets()
    }
    
    func loadSingleTweet(with identifier:String) -> Void{
        TWTRAPIClient().loadTweet(withID: identifier) { tweet, error in
        if let t = tweet {
            let tweetView = TWTRTweetView(tweet: t)
            tweetView.center = self.view.center
            self.tweetField.text = tweet?.text
            self.view.addSubview(tweetView)
        } else {
            print("Failed to load Tweet: \(error)")
        }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


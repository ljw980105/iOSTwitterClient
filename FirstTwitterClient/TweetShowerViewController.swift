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
    let client = TWTRAPIClient() // generates a twitter client
    
    @IBOutlet weak var showTweetButton: UIButton!
    @IBOutlet weak var tweetField: UILabel!
    //var tweetView: TWTRTweetView
    func showTweets() -> Void {
        client.loadTweet(withID: "20") { (tweet, error) -> Void in
            //print(tweet?.author.formattedScreenName)
//            self.tweetField?.text = tweet?.author.formattedScreenName
//            print(error!.localizedDescription)
            
            if tweet != nil {
                self.tweetField.text = tweet?.text
                //self.tweetView.configure(with: tweet)
            } else {
                print("Failed to load Tweet:" + (error?.localizedDescription)!)
            }
        }
    }

    @IBAction func showTweetAction(_ sender: UIButton) {
        tweetField.text = "Button Pressed"
        showTweets()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


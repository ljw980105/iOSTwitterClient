//
//  TweetIDTableViewController.swift
//  FirstTwitterClient
//
//  Created by Jing Wei Li on 12/24/17.
//  Copyright © 2017 Jing Wei Li. All rights reserved.
//

import UIKit
import TwitterKit

class TweetIDTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var TweetIDField: UITextField!
    
    var tweetIDs: String = "" {
        didSet{
            tweets = tweetIDs.components(separatedBy: " ") // separate strings into arrays with " "
        }
    }
    
    //global data structures for storing a list of tweet ids
    var tweets: [String] = ["918697712597340160","945049058917445633","940703861391675392"] {
        didSet{
            tableView.reloadData() // hammer: large performance costs
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TweetID"
        TweetIDField.delegate = self
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //number of sections in tableview
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //number of rows in each section of the tableview
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tweet", for: indexPath)
        // Configure the cell...
        let client = TWTRAPIClient() // generates a twitter client
        client.loadTweet(withID: tweets[indexPath.row]) { tweet, error in
            if tweet != nil {
                if let tweetCell = cell as? TweetTableViewCell{
                    tweetCell.updateUI(tweeterName: (tweet?.author.name)!, tweeterScreenName: "@" + (tweet?.author.screenName)!, tweetContent: (tweet?.text)!, imageURL: (tweet?.author.profileImageURL)!)
                }
            } else {
                if error == nil{
                    print ("no error")
                } else{
                    print(error!)
                }
            }
        }
        return cell
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        TweetIDField.resignFirstResponder()
        if textField == TweetIDField{
            tweetIDs = TweetIDField.text!
        }
        return true
    }
}

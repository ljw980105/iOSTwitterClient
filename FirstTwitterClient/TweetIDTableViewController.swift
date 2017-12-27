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
    var tweetContents:[String] = []
    var tweetUsers: [String] = []
    
    var tweetIDs: String = "" {
        didSet{
            tweetUsers.removeAll()
            tweetContents.removeAll()
            tweets = tweetIDs.components(separatedBy: " ") // separate strings into arrays with " "
            checkExistence()
            storeDefaults(using: tweetIDs)
        }
    }
    
    //global data structures for storing a list of tweet ids
    var tweets: [String] = ["918697712597340160","945049058917445633","940703861391675392"] {
        didSet{
            tableView.reloadData() // hammer: large performance costs
            
            checkExistence()
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
                    let tName = (tweet?.author.name)!
                    let tSName = "@" + (tweet?.author.screenName)!
                    let tContent = (tweet?.text)!
                    let tImgURL = (tweet?.author.profileImageURL)!
                    let tLargeImgURL = (tweet?.author.profileImageLargeURL)!
                    tweetCell.updateUI(tweeterName: tName, tweeterScreenName: tSName, tweetContent: tContent, imageURL: tImgURL)
                    self.tweetUsers.append(tSName)
                    self.tweetContents.append(tLargeImgURL + " " + tContent)
                }
            } else {
                print (error!)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationViewController = segue.destination
        if let navigationViewController = destinationViewController as? UINavigationController {
            destinationViewController = navigationViewController.visibleViewController ?? destinationViewController
        }
        if let dest = destinationViewController as? DestTableViewController{
            if let indexPath = tableView.indexPathForSelectedRow{
                dest.navigationItem.title = tweets[indexPath.row]
                dest.tweetIdentifier = tweets[indexPath.row]
                
                var validContents: [[String]] = []
                for _ in 0...4{ // generate an length-4 array loaded with empty arrays
                    validContents.append([])
                }
                // add current user into the data structure
                validContents[3].append(tweetUsers[indexPath.row])
                // separate tweets into words separated by spaces, storing each word in the array
                let contentsArr = tweetContents[indexPath.row].components(separatedBy: " ")
                validContents[0].append(contentsArr[0])// get the image url
                var counts = 0
                for item in contentsArr{
                    if counts > 0 {
                        if item.hasPrefix("http") { validContents[1].append(item) }
                        if item.hasPrefix("#") { validContents[2].append(item) }
                        if item.hasPrefix("@") { validContents[3].append(item) }
                    }
                    counts += 1
                }
                dest.destContents = validContents
            }
        }
    }
}

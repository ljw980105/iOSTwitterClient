//
//  DestTableViewController.swift
//  FirstTwitterClient
//
//  Created by Jing Wei Li on 12/25/17.
//  Copyright © 2017 Jing Wei Li. All rights reserved.
//

import UIKit

class DestTableViewController: UITableViewController {
    var tweetIdentifier: String = String()
    let sectionTitles: Dictionary<Int,String> = [0:"Images", 1: "URLs", 2: "Hashtags", 3: "Users"]
    var destContents : [[String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return destContents.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return destContents[section].count
    }

    // dequeue different cells for different uses
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{ // images
            let cell = tableView.dequeueReusableCell(withIdentifier: "img", for: indexPath)
            if let imgCell = cell as? TweetIDImageTableViewCell{
                imgCell.updateImage(with: destContents[indexPath.section][indexPath.row])
            }
            return cell
        }
        // for everything else
        let cell = tableView.dequeueReusableCell(withIdentifier: "hw", for: indexPath)
        cell.textLabel?.text = destContents[indexPath.section][indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contents = destContents[indexPath.section][indexPath.row]
        if(contents.hasPrefix("http")){
            UIApplication.shared.open(URL(string:contents)!, options: [:], completionHandler: nil)
        }
    }
}

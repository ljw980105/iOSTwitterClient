//
//  TweetTableViewCell.swift
//  FirstTwitterClient
//
//  Created by Jing Wei Li on 12/24/17.
//  Copyright © 2017 Jing Wei Li. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var content: UILabel!
    
    func updateUI(tweeterName:String, tweeterScreenName: String, tweetContent: String, imageURL: String){
        name.text = tweeterName
        screenName.text = tweeterScreenName
        content.text = tweetContent
        
        DispatchQueue.global(qos: .userInitiated).async{ [weak self] in
            let urlContents = try? Data(contentsOf: URL(string: imageURL)!)
            if let imageData = urlContents{
                DispatchQueue.main.async {
                    self?.tweetImage.image = UIImage(data: imageData)
                }
            } else {
                self?.tweetImage = nil
            }
        }
    }
}

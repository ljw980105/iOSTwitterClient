//
//  TweetIDImageTableViewCell.swift
//  FirstTwitterClient
//
//  Created by Jing Wei Li on 12/26/17.
//  Copyright © 2017 Jing Wei Li. All rights reserved.
//

import UIKit

class TweetIDImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var TweetIDImage: UIImageView!
    
    func updateImage(with link:String){
//        DispatchQueue.global(qos: .userInitiated).async{ [weak self] in
//            let urlContents = try? Data(contentsOf: URL(string: link)!)
//            if let imageData = urlContents{
//                DispatchQueue.main.async {
//                    print("main queue: " + link)
//                    self?.TweetIDImage.image = UIImage(data: imageData)
//                }
//            } else {
//                print("Image set to nil")
//                self?.TweetIDImage = nil
//            }
//        }
        self.TweetIDImage.image = UIImage(data: try! Data(contentsOf: URL(string: link)!))
    }
    

}

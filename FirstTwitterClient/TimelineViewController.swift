//
//  TimelineViewController.swift
//  FirstTwitterClient
//
//  Created by Jing Wei Li on 12/22/17.
//  Copyright © 2017 Jing Wei Li. All rights reserved.
//

import UIKit
import TwitterKit

class TimelineViewController: TWTRTimelineViewController, TWTRTweetViewDelegate, UITextFieldDelegate {
    
    var ScreenName:String?{
        didSet{
            var searchText: String = "MrProLi"
            if ScreenName != nil{
                searchText = ScreenName!
            } 
            self.dataSource = TWTRUserTimelineDataSource(screenName: searchText, apiClient: TWTRAPIClient())
            self.title = "@" + searchText
            checkExistence()
            storeDefaults(using: "@" + searchText)
            self.showTweetActions = true
        }
    }

    @IBOutlet weak var screenNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenNameField.delegate = self
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let client = TWTRAPIClient.withCurrentUser()
        
        self.dataSource = TWTRUserTimelineDataSource(screenName: "MrProLi", apiClient: client)
        self.title = "@MrProLi"
        self.showTweetActions = true
        TWTRTweetView.appearance().theme = .dark
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        screenNameField.resignFirstResponder() // collapse keyboard upon pressing return
        if textField == screenNameField{ // search upon pressing return
            ScreenName = screenNameField.text
        }
        return true
    }
}

//extension that customizes the status bar to be light
extension UINavigationController{
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

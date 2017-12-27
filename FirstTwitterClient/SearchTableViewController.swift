//
//  SearchTableViewController.swift
//  FirstTwitterClient
//
//  Created by Jing Wei Li on 12/24/17.
//  Copyright © 2017 Jing Wei Li. All rights reserved.
//

import UIKit
import TwitterKit

class SearchTableViewController: TWTRTimelineViewController, TWTRTweetViewDelegate, UITextFieldDelegate {
    
    var searchData:String?{
        didSet{
            var searchText: String = "Trump"
            if searchData != nil{
                searchText = searchData!
            }
            self.dataSource = TWTRSearchTimelineDataSource(searchQuery: searchText,apiClient: TWTRAPIClient())
            self.title = searchText
            checkExistence()
            storeDefaults(using: searchText)
        }
    }
    
    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.delegate = self
        
        let client = TWTRAPIClient.withCurrentUser()
        
        self.dataSource = TWTRSearchTimelineDataSource(searchQuery: "Trump",apiClient: client)
        self.title = "Trump"
        
        TWTRTweetView.appearance().theme = .dark
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.resignFirstResponder() // collapse keyboard upon pressing return
        if textField == searchField{ // search upon pressing return
            searchData = searchField.text
        }
        return true
    }
}

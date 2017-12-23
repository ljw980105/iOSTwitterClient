//
//  TimelineViewController.swift
//  FirstTwitterClient
//
//  Created by Jing Wei Li on 12/22/17.
//  Copyright © 2017 Jing Wei Li. All rights reserved.
//

import UIKit
import TwitterKit

class TimelineViewController: TWTRTimelineViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let client = TWTRAPIClient.withCurrentUser()
        
        let dataSource = TWTRUserTimelineDataSource(screenName: "twitterdev", apiClient: client)
        self.title = "@\(dataSource.screenName)"
        self.showTweetActions = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

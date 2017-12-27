//
//  HistoryTableViewController.swift
//  FirstTwitterClient
//
//  Created by Jing Wei Li on 12/26/17.
//  Copyright © 2017 Jing Wei Li. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "History"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return retrieveDefaults().count
    }
    
    
    @IBAction func refreshControl(_ sender: UIRefreshControl) {
        tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hist", for: indexPath)

        cell.textLabel?.text = retrieveDefaults()[indexPath.row]

        return cell
    }
}

//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Emily Ou on 2/4/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var tweetsArray = [NSDictionary]()
    var numOfTweets: Int!
    let refresh_Control = UIRefreshControl()

    @IBAction func logoutButton(_ sender: Any) {
        // Logout when button is click
        TwitterAPICaller.client?.logout()
        // Dismiss homescreen
        self.dismiss(animated: true, completion: nil)
        // Set LoggedIn key to false
        UserDefaults.standard.set(false, forKey: "LoggedIn")
    }
    
    // Get and load tweets function
    @objc func getTweets() {
        // Home timeline URL
        let homeURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count": 50]
        
        // Get tweets
        TwitterAPICaller.client?.getDictionariesRequest(url: homeURL, parameters: params, success: { (tweets: [NSDictionary]) in
            // Preserve order
            self.tweetsArray.removeAll()
            // Append tweets into array
            for tweet in tweets {
                self.tweetsArray.append(tweet)
            }
            // reload data to all cells
            self.tableView.reloadData()
            self.refresh_Control.endRefreshing()
            
        }, failure: { (Error) in
            print(Error.localizedDescription)
            //self.getTweets()
        })
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        // Get username
        let username = tweetsArray[indexPath.row]["user"] as! NSDictionary
        
        // Populate the labels in the cell
        cell.usernameLabel.text = username["name"] as? String
        cell.contentLabel.text = tweetsArray[indexPath.row]["text"] as? String
        //cell.contentLabel.sizeToFit()
        
        // Get profile pic
        let imageURL = URL(string: ((username["profile_image_url_https"] as? String)!))!
        let data = try? Data(contentsOf: imageURL)
        
        // Populate profile pic
        if let imageData = data {
            cell.profilePic.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Make cells self sizing depending of tweet content size
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150

        // Get and load tweets
        getTweets()
        
        // refresh tweets
        refresh_Control.addTarget(self, action: #selector(getTweets), for: .valueChanged)
        tableView.refreshControl = refresh_Control

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return all tweets
        return tweetsArray.count
    }
}

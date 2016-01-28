//
//  ViewController.swift
//  Instagram
//
//  Created by Kevin Tran on 1/27/16.
//  Copyright © 2016 Kevin Tran. All rights reserved.
//

import UIKit
import AFNetworking



class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var instaposts: [NSDictionary]?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 320
        
        
        
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            self.instaposts = responseDictionary["data"] as? [NSDictionary]
                            self.tableView.reloadData()
                    }
                }
        });
        task.resume()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let instaposts = instaposts {
            return instaposts.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("InstagramCell", forIndexPath: indexPath) as! InstagramCell
        
        let instapost = instaposts![indexPath.row]
        let name = instapost["user"]!["username"] as? String!
//        let overview = movie["overview"] as! String
//        let posterPath = movie["poster_path"] as! String
//        
//        let baseURL = "http://image.tmdb.org/t/p/w500"
//        
//        let imageURL = NSURL(string: baseURL + posterPath)

//        cell.nameLabel.text = "test"
//        cell.likeLabel.text = "1000"
//        print("row \(indexPath.row)")
        if let name = name {
            cell.nameLabel!.text = name
        }
        return cell
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


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
        
        tableView.registerClass(InstagramCell.self, forCellReuseIdentifier: "InstagramCell")

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
        
        if let name = instapost.valueForKeyPath("user.username") as? String {
            if let username = cell.nameLabel {
                username.text = name
            }
        }
//        let like = instapost.valueForKeyPath("likes.count") as? String!
        
        if let image = instapost.valueForKeyPath("images.standard_resolution.url") as! String! {
            //if let imageLoad = cell.instagramPic {
                let imageURL = NSURL(string: image)
                cell.instagramPic.setImageWithURL(imageURL!)
            //}
        }
        

        //print("row \(indexPath.row)")
//        if let username = cell.nameLabel {
//            username.text = name
//        }
//        if let likes = cell.likeLabel {
//            likes.text = like
//        }
//
//            imageLoad.setImageWithURL(imageURL!)
//        }
        return cell
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


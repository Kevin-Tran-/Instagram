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

    let CellIdentifier = "TableViewCell", HeaderViewIdentifier = "TableViewHeaderView"


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 320
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        tableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderViewIdentifier)

        
        networkRequest()
        
        
        //tableView.registerClass(InstagramCell.self, forCellReuseIdentifier: "InstagramCell")

    }
    
    func networkRequest() {
        
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
                            //NSLog("response: \(responseDictionary)")
                            self.instaposts = responseDictionary["data"] as? [NSDictionary]
                            self.tableView.reloadData()
                    }
                }
        });
        task.resume()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
//        if let instaposts = instaposts {
//            return instaposts.count
//        } else {
//            return 0
//        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let instaposts = instaposts {
            return instaposts.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as UITableViewCell

        let cell = tableView.dequeueReusableCellWithIdentifier("InstagramCell", forIndexPath: indexPath) as! InstagramCell

        let instapost = instaposts![indexPath.section]
        
        
        if let like = instapost.valueForKeyPath("likes.count") as? Int!{
            cell.likeLabel.text = String("Like: \(like)")
        }
        
        if let image = instapost.valueForKeyPath("images.standard_resolution.url") as! String! {
            let imageURL = NSURL(string: image)
            cell.instagramPic.setImageWithURL(imageURL!)
        }
        return cell
    
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        profileView.layer.borderWidth = 1;
        
        // Use the section number to get the right URL
        if let userImage = instaposts![section].valueForKeyPath("user.profile_picture") as? String {
            let userImageURL = NSURL(string: userImage)
            profileView.setImageWithURL(userImageURL!)

        }
        
        
        headerView.addSubview(profileView)
        
        //print(instaposts)
        print(section)
        // Add a UILabel for the username here
        let nameView = UILabel(frame: CGRect(x: 50, y: 10, width: 300, height: 30))
        
        nameView.font = UIFont.boldSystemFontOfSize(16)
        nameView.textColor = UIColor(red: 8/255.0, green: 64/255.0, blue: 127/255.0, alpha: 1)
        
        
        if let name = instaposts![section].valueForKeyPath("user.username") as? String {
            print(name)
            nameView.text = name
        }
        
        headerView.addSubview(nameView)
        
        //header.textLabel.text = data[section][0]
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


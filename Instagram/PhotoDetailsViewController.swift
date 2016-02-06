//
//  PhotoDetailsViewController.swift
//  Instagram
//
//  Created by Kevin Tran on 2/3/16.
//  Copyright © 2016 Kevin Tran. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    @IBOutlet weak var photoDetailImage: UIImageView!
    
    public var photoURL: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        photoDetailImage.userInteractionEnabled = true
        photoDetailImage.setImageWithURL(NSURL(string: photoURL)!)
        print("In PhotoDetailViewController")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        //        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //        let userVC = mainStoryboard.instantiateViewControllerWithIdentifier("fullVC") as! PhotoDetailsViewController
        //        presentViewController(userVC, animated: true, completion: nil)
        print("Image was tap")
        
        performSegueWithIdentifier("fullSegue", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var destinationViewController = segue.destinationViewController as! FullScreenPhotoViewController
        
        destinationViewController.image = self.photoDetailImage.image
    }
    

}

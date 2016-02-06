//
//  FullScreenPhotoViewController.swift
//  Instagram
//
//  Created by Kevin Tran on 2/4/16.
//  Copyright © 2016 Kevin Tran. All rights reserved.
//

import UIKit

class FullScreenPhotoViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var fullImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self

        // Do any additional setup after loading the view.
        fullImage.image = image
        scrollView.contentSize = fullImage.image!.size

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return fullImage
    }
    @IBAction func onClose(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

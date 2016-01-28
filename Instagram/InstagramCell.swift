//
//  InstagramCell.swift
//  Instagram
//
//  Created by Kevin Tran on 1/27/16.
//  Copyright © 2016 Kevin Tran. All rights reserved.
//

import UIKit

class InstagramCell: UITableViewCell {

    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var instagramPic: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//  ImageThree.swift
//  Test
//  Created by vaayoousa on 12/07/18.
//  Copyright © 2018 Ranjeet Raushan. All rights reserved.

import UIKit

class ImageThree: UITableViewCell {
    @IBOutlet weak var img_s: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_desc: UILabel!
    @IBOutlet weak var img_post: UIImageView!
    @IBOutlet weak var img_post1: UIImageView!
    @IBOutlet weak var img_post2: UIImageView!
    
    
    @IBOutlet weak var imageSubView: UIView!
    @IBOutlet weak var lbl_descHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

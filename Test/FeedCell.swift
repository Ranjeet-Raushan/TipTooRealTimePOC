//  FeedCell.swift
//  Test
//  Created by vaayoousa on 05/07/18.
//  Copyright © 2018 Ranjeet Raushan. All rights reserved.

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet weak var img_featured: UIImageView!
    @IBOutlet weak var lbl_restaurantName: UILabel!
    @IBOutlet weak var lbl_restaurantAddress: UILabel!
    @IBOutlet weak var btn_heiglight: UIButton!
    
    
    @IBOutlet weak var img_userProfile: UIImageView!
    @IBOutlet weak var lbl_userName: UILabel!
    @IBOutlet weak var lbl_userReviews: UILabel!
    @IBOutlet weak var lbl_followers: UILabel!
    @IBOutlet weak var lbl_timeStamp: UILabel!
    @IBOutlet weak var btn_follow: UIButton!
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var lbl_food: UILabel!
    @IBOutlet weak var lbl_ambiance: UILabel!
    @IBOutlet weak var lbl_service: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var img_post: UIImageView!
    
    
    
    @IBOutlet weak var lbl_imgcount: UILabel!
    @IBOutlet weak var btn_like: UIButton!
    @IBOutlet weak var btn_comment: UIButton!
    @IBOutlet weak var btn_share: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

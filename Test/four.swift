//  four.swift
//  Test
//  Created by vaayoousa on 12/07/18.
//  Copyright © 2018 Ranjeet Raushan. All rights reserved.


import UIKit

class four: UITableViewCell {
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
    
     @IBOutlet weak var img_post1: UIImageView!
     @IBOutlet weak var img_post2: UIImageView!
     @IBOutlet weak var img_post3: UIImageView!
    
    @IBOutlet weak var lbl_imgcount: UILabel!
    @IBOutlet weak var btn_like: UIButton!
    @IBOutlet weak var btn_comment: UIButton!
    @IBOutlet weak var btn_share: UIButton!
    
    @IBOutlet weak var img_line: UIImageView!
    @IBOutlet weak var subVHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var lbl_descriptionHeight: NSLayoutConstraint!
    @IBOutlet weak var imageSubView: UIView!
    
    @IBOutlet weak var btn_ac: UIButton!
    @IBOutlet weak var btn_delivery: UIButton!
    @IBOutlet weak var btn_takeAway: UIButton!
    @IBOutlet weak var btn_parking: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

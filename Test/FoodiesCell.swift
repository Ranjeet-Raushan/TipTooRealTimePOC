//
//  FoodiesCell.swift
//  Test
//
//  Created by vaayoousa on 05/07/18.
//  Copyright © 2018 Ranjeet Raushan. All rights reserved.
//

import UIKit

class FoodiesCell: UITableViewCell {
    //foodies
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_reviews: UILabel!
    @IBOutlet weak var lbl_followers: UILabel!
    @IBOutlet weak var btn_follow: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

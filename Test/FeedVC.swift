//  FeedVC.swift
//  Test
//  Created by vaayoousa on 02/07/18.
//  Copyright © 2018 Ranjeet Raushan. All rights reserved.

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
class FeedVC: UIViewController  , UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet weak var feedTable: UITableView!
    var feedArray = Array<JSON>()
    var one: one?
    var two: two?
    var third: three?
    var cell: four?
    let app = UIApplication.shared.delegate as! AppDelegate
    var count: Int = 10
    var spinner: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        feedTable.delegate = self
        feedTable.dataSource = self
        feedTable.separatorStyle = .none
        
        hitService()
        feedTable.register(UINib(nibName: "one", bundle: nil), forCellReuseIdentifier: "on")
        feedTable.register(UINib(nibName: "two", bundle: nil), forCellReuseIdentifier: "tw")
        feedTable.register(UINib(nibName: "three", bundle: nil), forCellReuseIdentifier: "th")
        feedTable.register(UINib(nibName: "four", bundle: nil), forCellReuseIdentifier: "fo")
    }
    func hitService(){
        //call service
        let headers = [
            //"token": UserDefaults.standard.object(forKey: "token") as! String,
            "token": "60fe1a9c-c752-4e07-8646-04da86c4897760fe1a9c-c752-4e07-8646-04da86c48977",
            "Content-Type": "application/json"
        ]
        let endPoint = "http://tiptooservices.azurewebsites.net/api/v1/Feed?latitude=12.925007&longitude=77.593803&Radius=25&index=0&count=10"
        Alamofire.request(endPoint,headers: headers).responseJSON { response in
            self.feedArray.removeAll()
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    if  let value = response.result.value{
                        let json = JSON(value)
                        print("response : \(response.result.value!)")
                        // showAlert(msg: json["message"].stringValue)
                        if json["ControlsData"].isEmpty == false {
                            let ControlsData = (json["ControlsData"].dictionary!)
                            for object in ControlsData["lsv_resturant"]! {
                                self.feedArray.append(object.1)//preparing data set by putting dict into array
                                self.feedTable.reloadData()
                            }
                        }
                    }
                }
                break
            case .failure(_):
                print("Failure : \(response.result.error!)")
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedArray.count
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let dict = feedArray[indexPath.row]
        let count = dict["ImageUrl"].arrayValue
        if count.count == 2
        {
            //second
            
            two = feedTable.dequeueReusableCell(withIdentifier: "tw", for: indexPath) as? two
            
            two?.img_featured.sd_setImage(with: URL.init(string: dict["featured_image"].stringValue), placeholderImage: UIImage.init(named: "suggestMenuBg"), options: [.continueInBackground, .progressiveDownload])
            two?.lbl_restaurantName.text = dict["name"].stringValue
            two?.lbl_restaurantAddress.text = dict["address"].stringValue
            if dict["IsSaved"].boolValue == true {
                two?.btn_heiglight.setImage(#imageLiteral(resourceName: "saved"), for: .selected)
                two?.btn_heiglight.isSelected = true
            }
            else{
                two?.btn_heiglight.setImage(#imageLiteral(resourceName: "save"), for: .normal)
                two?.btn_heiglight.isSelected = false
            }
      
            two?.img_userProfile.sd_setImage(with: URL.init(string: dict["ProfileUrl"].stringValue), placeholderImage: UIImage.init(named: "AvatarSmall"), options: [.continueInBackground, .progressiveDownload])
            two?.img_userProfile.layer.cornerRadius = (two?.img_userProfile.frame.size.width)! / 2
            two?.img_userProfile.clipsToBounds = true
            two?.lbl_userName.text = dict["UserName"].stringValue
            if dict["Reviews"].stringValue.isEmpty == false
            {
                two?.lbl_userReviews.text = "\(dict["Reviews"].stringValue) Reviews,"
            }
            if dict["Followers"].stringValue.isEmpty == false
            {
                two?.lbl_followers.text = "\(dict["Followers"].stringValue) Followers"
            }
            
            two?.lbl_timeStamp.text = dict["hours"].stringValue
            
            two?.btn_ac.setImage(#imageLiteral(resourceName: "ac_grey"), for: .normal)
            two?.btn_delivery.setImage(#imageLiteral(resourceName: "homedelivery_grey"), for: .normal)
            two?.btn_takeAway.setImage(#imageLiteral(resourceName: "takeaway_grey"), for: .normal)
            two?.btn_parking.setImage(#imageLiteral(resourceName: "parking_grey"), for: .normal)
            
            if dict["highlights"].stringValue.isEmpty == false
            {
                let fullNameArr = dict["highlights"].stringValue.components(separatedBy: ";")
                for i in fullNameArr
                {
                    if i == "1"{
                        two?.btn_ac.setImage(#imageLiteral(resourceName: "ac"), for: .normal)
                    }
                    else if i == "2"{
                        two?.btn_delivery.setImage(#imageLiteral(resourceName: "homedelivery"), for: .normal)
                    }
                    else if i == "3"{
                        
                        two?.btn_takeAway.setImage(#imageLiteral(resourceName: "takeaway"), for: .normal)
                        
                    }
                    else if i == "4"{
                        two?.btn_parking.setImage(#imageLiteral(resourceName: "parking"), for: .normal)
                        
                    }else{
                        
                    }
                    
                }
            }
            if dict["IsFollowed"].boolValue == true {
                two?.btn_follow.setImage(#imageLiteral(resourceName: "following"), for: .selected)
                two?.btn_follow.isSelected = true
            }
            else{
                two?.btn_follow.setImage(#imageLiteral(resourceName: "follow"), for: .normal)
                two?.btn_follow.isSelected = false
            }
            if dict["IsLiked"].boolValue == true
            {
                two?.btn_like.setImage(#imageLiteral(resourceName: "like_1"), for: .selected)
                two?.btn_like.isSelected = true
            }
            else
            {
                two?.btn_like.setImage(#imageLiteral(resourceName: "like"), for: .normal)
                two?.btn_like.isSelected = false
            }
            two?.lbl_food.text = dict["food"].stringValue
            two?.lbl_ambiance.text = dict["ambiance"].stringValue
            two?.lbl_service.text = dict["service"].stringValue
            two?.lbl_description.text = dict["Description"].stringValue
            
           
     two?.img_post.sd_setImage(with: URL.init(string: count[0].stringValue), placeholderImage: UIImage.init(named: "suggestMenuBg"), options: [.continueInBackground, .progressiveDownload])
            two?.img_post1.sd_setImage(with: URL.init(string: count[1].stringValue), placeholderImage: UIImage.init(named: "suggestMenuBg"), options: [.continueInBackground, .progressiveDownload])
            return two!
        }
        
        else if count.count == 3
        {
            //third
            
            third = feedTable.dequeueReusableCell(withIdentifier: "th") as? three
            
            third?.img_featured.sd_setImage(with: URL.init(string: dict["featured_image"].stringValue), placeholderImage: UIImage.init(named: "suggestMenuBg"), options: [.continueInBackground, .progressiveDownload])
            third?.lbl_restaurantName.text = dict["name"].stringValue
            third?.lbl_restaurantAddress.text = dict["address"].stringValue
            if dict["IsSaved"].boolValue == true {
                third?.btn_heiglight.setImage(#imageLiteral(resourceName: "saved"), for: .selected)
                third?.btn_heiglight.isSelected = true
            }
            else{
                third?.btn_heiglight.setImage(#imageLiteral(resourceName: "save"), for: .normal)
                third?.btn_heiglight.isSelected = false
            }

            third?.img_userProfile.sd_setImage(with: URL.init(string: dict["ProfileUrl"].stringValue), placeholderImage: UIImage.init(named: "AvatarSmall"), options: [.continueInBackground, .progressiveDownload])
            third?.img_userProfile.layer.cornerRadius = (third?.img_userProfile.frame.size.width)! / 2
            third?.img_userProfile.clipsToBounds = true
            
            third?.lbl_userName.text = dict["UserName"].stringValue
            if dict["Reviews"].stringValue.isEmpty == false
            {
                third?.lbl_userReviews.text = "\(dict["Reviews"].stringValue) Reviews,"
            }
            if dict["Followers"].stringValue.isEmpty == false
            {
                third?.lbl_followers.text = "\(dict["Followers"].stringValue) Followers"
            }
            

            third?.lbl_timeStamp.text = dict["hours"].stringValue
            
            third?.btn_ac.setImage(#imageLiteral(resourceName: "ac_grey"), for: .normal)
            third?.btn_delivery.setImage(#imageLiteral(resourceName: "homedelivery_grey"), for: .normal)
            third?.btn_takeAway.setImage(#imageLiteral(resourceName: "takeaway_grey"), for: .normal)
            third?.btn_parking.setImage(#imageLiteral(resourceName: "parking_grey"), for: .normal)
            
            if dict["highlights"].stringValue.isEmpty == false
            {
                let fullNameArr = dict["highlights"].stringValue.components(separatedBy: ";")
                for i in fullNameArr
                {
                    if i == "1"{
                        third?.btn_ac.setImage(#imageLiteral(resourceName: "ac"), for: .normal)
                    }
                    else if i == "2"{
                        third?.btn_delivery.setImage(#imageLiteral(resourceName: "homedelivery"), for: .normal)
                    }
                    else if i == "3"{
                        
                        third?.btn_takeAway.setImage(#imageLiteral(resourceName: "takeaway"), for: .normal)
                        
                    }
                    else if i == "4"{
                        third?.btn_parking.setImage(#imageLiteral(resourceName: "parking"), for: .normal)
                        
                    }else{
                        
                    }
                    
                }
            }
            
            if dict["IsFollowed"].boolValue == true {
                third?.btn_follow.setImage(#imageLiteral(resourceName: "following"), for: .selected)
                third?.btn_follow.isSelected = true
            }
            else{
                third?.btn_follow.setImage(#imageLiteral(resourceName: "follow"), for: .normal)
                third?.btn_follow.isSelected = false
            }
            
            
            if dict["IsLiked"].boolValue == true
            {
                third?.btn_like.setImage(#imageLiteral(resourceName: "like_1"), for: .selected)
                third?.btn_like.isSelected = true
            }
            else
            {
                third?.btn_like.setImage(#imageLiteral(resourceName: "like"), for: .normal)
                third?.btn_like.isSelected = false
            }
            third?.lbl_food.text = dict["food"].stringValue
            third?.lbl_ambiance.text = dict["ambiance"].stringValue
            third?.lbl_service.text = dict["service"].stringValue
            third?.lbl_description.text = dict["Description"].stringValue
           
            third?.img_post.sd_setImage(with: URL.init(string: count[0].stringValue), placeholderImage: UIImage.init(named: "suggestMenuBg"), options: [.continueInBackground, .progressiveDownload])
            
            
            third?.img_post1.sd_setImage(with: URL.init(string: count[1].stringValue), placeholderImage: UIImage.init(named: "suggestMenuBg"), options: [.continueInBackground, .progressiveDownload])
            
            
            third?.img_post2.sd_setImage(with: URL.init(string: count[2].stringValue), placeholderImage: UIImage.init(named: "suggestMenuBg"), options: [.continueInBackground, .progressiveDownload])
            
              return third!
            
            
        }
        
        else if count.count == 4 || count.count >= 4
        {
            //fourth
            
            cell = feedTable.dequeueReusableCell(withIdentifier: "fo") as? four
            
            cell?.img_featured.sd_setImage(with: URL.init(string: dict["featured_image"].stringValue), placeholderImage: UIImage.init(named: "suggestMenuBg"), options: [.continueInBackground, .progressiveDownload])
            cell?.lbl_restaurantName.text = dict["name"].stringValue
            cell?.lbl_restaurantAddress.text = dict["address"].stringValue
            if dict["IsSaved"].boolValue == true {
                cell?.btn_heiglight.setImage(UIImage.init(named: "saved"), for: .selected)
                cell?.btn_heiglight.isSelected = true
            }
            else{
                cell?.btn_heiglight.setImage(UIImage.init(named: "save"), for: .normal)
                cell?.btn_heiglight.isSelected = false
            }
            cell?.img_userProfile.sd_setImage(with: URL.init(string: dict["ProfileUrl"].stringValue), placeholderImage: UIImage.init(named: "AvatarSmall"), options: [.continueInBackground, .progressiveDownload])
            cell?.img_userProfile.layer.cornerRadius = (cell?.img_userProfile.frame.size.width)! / 2
            cell?.img_userProfile.clipsToBounds = true
            cell?.lbl_userName.text = dict["UserName"].stringValue
            if dict["Reviews"].stringValue.isEmpty == false
            {
                cell?.lbl_userReviews.text = "\(dict["Reviews"].stringValue) Reviews,"
            }
            if dict["Followers"].stringValue.isEmpty == false
            {
                cell?.lbl_followers.text = "\(dict["Followers"].stringValue) Followers"
            }
            
            cell?.lbl_timeStamp.text = dict["hours"].stringValue
            if dict["IsFollowed"].boolValue == true {
                cell?.btn_follow.setImage(#imageLiteral(resourceName: "following"), for: .selected)
                cell?.btn_follow.isSelected = true
            }
            else{
                cell?.btn_follow.setImage(#imageLiteral(resourceName: "follow"), for: .normal)
                cell?.btn_follow.isSelected = false
            }
            
            
            if dict["IsLiked"].boolValue == true
            {
                cell?.btn_like.setImage(#imageLiteral(resourceName: "like_1"), for: .selected)
                cell?.btn_like.isSelected = true
            }
            else
            {
                cell?.btn_like.setImage(#imageLiteral(resourceName: "like"), for: .normal)
                cell?.btn_like.isSelected = false
            }
            cell?.btn_ac.setImage(#imageLiteral(resourceName: "ac_grey"), for: .normal)
            cell?.btn_delivery.setImage(#imageLiteral(resourceName: "homedelivery_grey"), for: .normal)
            cell?.btn_takeAway.setImage(#imageLiteral(resourceName: "takeaway_grey"), for: .normal)
            cell?.btn_parking.setImage(#imageLiteral(resourceName: "parking_grey"), for: .normal)
            if dict["highlights"].stringValue.isEmpty == false
            {
                let fullNameArr = dict["highlights"].stringValue.components(separatedBy: ";")
                for i in fullNameArr
                {
                    if i == "1"{
                        cell?.btn_ac.setImage(#imageLiteral(resourceName: "ac"), for: .normal)
                    }
                    else if i == "2"{
                        cell?.btn_delivery.setImage(#imageLiteral(resourceName: "homedelivery"), for: .normal)
                    }
                    else if i == "3"{
                        
                        cell?.btn_takeAway.setImage(#imageLiteral(resourceName: "takeaway"), for: .normal)
                        
                    }
                    else if i == "4"{
                        cell?.btn_parking.setImage(#imageLiteral(resourceName: "parking"), for: .normal)
                        
                    }else{
                        
                    }
                    
                }
            }
            cell?.lbl_food.text = dict["food"].stringValue
            cell?.lbl_ambiance.text = dict["ambiance"].stringValue
            cell?.lbl_service.text = dict["service"].stringValue
            cell?.lbl_description.text = dict["Description"].stringValue
            
         
            cell?.img_post.sd_setImage(with: URL.init(string: count[0].stringValue), placeholderImage: UIImage.init(named: "suggestMenuBg"), options: [.continueInBackground, .progressiveDownload])
            
            cell?.img_post1.sd_setImage(with: URL.init(string: count[1].stringValue), placeholderImage: UIImage.init(named: "suggestMenuBg"), options: [.continueInBackground, .progressiveDownload])
            
            cell?.img_post2.sd_setImage(with: URL.init(string: count[2].stringValue), placeholderImage: UIImage.init(named: "suggestMenuBg"), options: [.continueInBackground, .progressiveDownload])
            
            cell?.img_post3.sd_setImage(with: URL.init(string: count[3].stringValue), placeholderImage: UIImage.init(named: "suggestMenuBg"), options: [.continueInBackground, .progressiveDownload])
            
            
            let count = dict["ImageUrl"].count - 4
            if count > 0 {
                cell?.lbl_imgcount.text  = "+ \(String(describing: count))"
                
                cell?.lbl_imgcount.isHidden = false
            }
            else
            {
                cell?.lbl_imgcount.isHidden = true
            }
            return cell!
        }
        else
        {
            one = feedTable.dequeueReusableCell(withIdentifier: "on") as? one
            
            one?.img_featured.sd_setImage(with: URL.init(string: dict["featured_image"].stringValue), placeholderImage: UIImage.init(named: "suggestMenuBg"), options: [.continueInBackground, .progressiveDownload])
//            one?.img_featured.setContentMode()
            one?.lbl_restaurantName.text = dict["name"].stringValue
            one?.lbl_restaurantAddress.text = dict["address"].stringValue
            if dict["IsSaved"].boolValue == true {
                one?.btn_heiglight.setImage(#imageLiteral(resourceName: "saved"), for: .selected)
                one?.btn_heiglight.isSelected = true
            }
            else{
                one?.btn_heiglight.setImage(#imageLiteral(resourceName: "save"), for: .normal)
                one?.btn_heiglight.isSelected = false
            }
            one?.img_userProfile.sd_setImage(with: URL.init(string: dict["ProfileUrl"].stringValue), placeholderImage: UIImage.init(named: "AvatarSmall"), options: [.continueInBackground, .progressiveDownload])
            one?.img_userProfile.layer.cornerRadius = (one?.img_userProfile.frame.size.width)! / 2
            one?.img_userProfile.clipsToBounds = true
            one?.lbl_userName.text = dict["UserName"].stringValue
            if dict["Reviews"].stringValue.isEmpty == false
            {
                one?.lbl_userReviews.text = "\(dict["Reviews"].stringValue) Reviews,"
            }
            if dict["Followers"].stringValue.isEmpty == false
            {
                one?.lbl_followers.text = "\(dict["Followers"].stringValue) Followers"
            }
            one?.lbl_timeStamp.text = dict["hours"].stringValue
            one?.btn_ac.setImage(#imageLiteral(resourceName: "ac_grey"), for: .normal)
            one?.btn_delivery.setImage(#imageLiteral(resourceName: "homedelivery_grey"), for: .normal)
            one?.btn_takeAway.setImage(#imageLiteral(resourceName: "takeaway_grey"), for: .normal)
            one?.btn_parking.setImage(#imageLiteral(resourceName: "parking_grey"), for: .normal)
            
            if dict["highlights"].stringValue.isEmpty == false
            {
                let fullNameArr = dict["highlights"].stringValue.components(separatedBy: ";")
                for i in fullNameArr
                {
                    if i == "1"{
                        one?.btn_ac.setImage(#imageLiteral(resourceName: "ac"), for: .normal)
                    }
                    else if i == "2"{
                        one?.btn_delivery.setImage(#imageLiteral(resourceName: "homedelivery"), for: .normal)
                    }
                    else if i == "3"{
                        
                        one?.btn_takeAway.setImage(#imageLiteral(resourceName: "takeaway"), for: .normal)
                        
                    }
                    else if i == "4"{
                        one?.btn_parking.setImage(#imageLiteral(resourceName: "parking"), for: .normal)
                        
                    }else{
                        
                    }
                    
                }
            }
            if dict["IsFollowed"].boolValue == true {
                one?.btn_follow.setImage(#imageLiteral(resourceName: "following"), for: .selected)
                one?.btn_follow.isSelected = true
            }
            else{
                one?.btn_follow.setImage(#imageLiteral(resourceName: "follow"), for: .normal)
                one?.btn_follow.isSelected = false
            }
            
            
            if dict["IsLiked"].boolValue == true
            {
                one?.btn_like.setImage(#imageLiteral(resourceName: "like_1"), for: .selected)
                one?.btn_like.isSelected = true
            }
            else
            {
                one?.btn_like.setImage(#imageLiteral(resourceName: "like"), for: .normal)
                one?.btn_like.isSelected = false
            }
            one?.lbl_food.text = dict["food"].stringValue
            one?.lbl_ambiance.text = dict["ambiance"].stringValue
            one?.lbl_service.text = dict["service"].stringValue
            one?.lbl_description.text = dict["Description"].stringValue
            
            if count.count > 0
            {
                
                one?.img_post.sd_setImage(with: URL.init(string: count[0].stringValue), placeholderImage: UIImage.init(named: "suggestMenuBg"), options: [.continueInBackground, .progressiveDownload])
            }
            return one!
        

    
        
}
    }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            let dict = feedArray[indexPath.row]
            let count = dict["ImageUrl"].arrayValue
            var height: CGFloat = 0.0
            if count.count == 2
            {
                let description = dict["Description"].stringValue
                let heightD = heightForDesription(description: description as NSString)
                height = 500.0 - 55.0 + 65 - 19 + heightD + 114.0 - 20.0
            }
            else if count.count == 3
            {
                let description = dict["Description"].stringValue
                let heightD = heightForDesription(description: description as NSString)
                third?.lbl_descriptionHeight.constant = heightD
                height = 625.0 - 19 + heightD + 120.0 - 20.0
            }
            else if count.count == 4 || count.count >= 4
            {
                let description = dict["Description"].stringValue
                let heightD = heightForDesription(description: description as NSString)
                cell?.lbl_descriptionHeight.constant = heightD
                height = 689 + heightD
            }
            else
            {
                let description = dict["Description"].stringValue
                let descHeight = heightForDesription(description: description as NSString)
                height = 490.0 + 65.0 - 19.0 + descHeight + 120.0 - 20.0 + 10.0
            }
            return height
        }
         func heightForDesription(description: NSString) -> CGFloat
         {
         var descriptionlabelWidth: CGFloat = 0.0
         if UI_USER_INTERFACE_IDIOM() == .phone {
         let result: CGSize = UIScreen.main.bounds.size
         if result.height == 568 {
         descriptionlabelWidth = 300.0
         }
         else if result.height == 667 {
         descriptionlabelWidth = 355.0
         }
         else if result.height == 736 {
         descriptionlabelWidth = 370.0
         }
         }
         else {
         descriptionlabelWidth = 745.0
         }
    
         let font = UIFont(name: "Basic-Regular", size: 14)
            let selectedTextAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.foregroundColor: VSCore().getColor("#E45641"),
            NSAttributedStringKey.font: font!
         ]
            let rect = description.boundingRect(with: CGSize.init(width: descriptionlabelWidth, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: selectedTextAttributes, context: nil)

         return rect.size.height
    
    
         }
    
        func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            spinner?.frame = CGRect(x: 0, y: 5, width: view.frame.size.width, height: 44)
            spinner?.hidesWhenStopped = true
            if feedArray.count >= 10 {
                feedTable.tableFooterView = spinner
            }
            else {
                feedTable.tableFooterView = spinner
            }
            return feedTable.tableFooterView
        }
    

    
  
}

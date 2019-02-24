//  MyFeedVC.swift
//  Test
//  Created by vaayoousa on 03/07/18.
//  Copyright © 2018 Ranjeet Raushan. All rights reserved.

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
class MyFeedVC: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    @IBOutlet weak var myFeedTable: UITableView!
    var myFeedArray = Array<JSON>()
    var one: one?
    var two: two?
    var threee: three?
    var four: four?
    override func viewDidLoad() {
        super.viewDidLoad()
        myFeedTable.delegate = self
        myFeedTable.dataSource = self
        myFeedTable.separatorStyle = .none
        hitService()
        myFeedTable.register(UINib(nibName: "one", bundle: nil), forCellReuseIdentifier: "on")
        myFeedTable.register(UINib(nibName: "two", bundle: nil), forCellReuseIdentifier: "tw")
        myFeedTable.register(UINib(nibName: "three", bundle: nil), forCellReuseIdentifier: "th")
        myFeedTable.register(UINib(nibName: "four", bundle: nil), forCellReuseIdentifier: "fo")
    }
    func hitService(){
        //call service
        let headers = [
            //"token": UserDefaults.standard.object(forKey: "token") as! String,
            //For MyFeed Section ,use below token only
            "token": "689CB3FC-2291-4CB4-94F7-9F8D1038D0FF",
            "Content-Type": "application/json"
        ]
        let endPoint = "http://tiptooservices.azurewebsites.net/api/v1/MyFeed?index=0&count=10"
        Alamofire.request(endPoint,headers: headers).responseJSON { response in
            self.myFeedArray.removeAll()
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
                                self.myFeedArray.append(object.1)//preparing data set by putting dict into array
                                self.myFeedTable.reloadData()
                            }
                        }
                    }
                }
                break
            case .failure(_):
                print("Failure : \(response.result.error!)")
                //  showAlert(msg: "Error ")
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFeedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dict = myFeedArray[indexPath.row]
        let count = dict["ImageUrl"].arrayValue
        if count.count == 2
        {
            //second
            
            two = myFeedTable.dequeueReusableCell(withIdentifier: "tw", for: indexPath) as? two
            
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
 
            
            two?.img_post.sd_setImage(with: URL.init(string: count[0].stringValue), placeholderImage: UIImage.init(named: "suggestMenuBg"), options: [.continueInBackground, .progressiveDownload])
            
            two?.img_post1.sd_setImage(with: URL.init(string: count[1].stringValue), placeholderImage: UIImage.init(named: "suggestMenuBg"), options: [.continueInBackground, .progressiveDownload])
        return two!
            
        }
        
        else if count.count == 3
        {
            //third
            
            threee = myFeedTable.dequeueReusableCell(withIdentifier: "th") as? three
            
            threee?.img_featured.sd_setImage(with: URL.init(string: dict["featured_image"].stringValue), placeholderImage: UIImage.init(named: "suggestMenuBg"), options: [.continueInBackground, .progressiveDownload])
            threee?.lbl_restaurantName.text = dict["name"].stringValue
            threee?.lbl_restaurantAddress.text = dict["address"].stringValue
            if dict["IsSaved"].boolValue == true {
                threee?.btn_heiglight.setImage(#imageLiteral(resourceName: "saved"), for: .selected)
                threee?.btn_heiglight.isSelected = true
            }
            else{
                threee?.btn_heiglight.setImage(#imageLiteral(resourceName: "save"), for: .normal)
                threee?.btn_heiglight.isSelected = false
            }
            if dict["IsLiked"].boolValue == true
            {
                threee?.btn_like.setImage(#imageLiteral(resourceName: "like_1"), for: .selected)
                threee?.btn_like.isSelected = true
            }
            else
            {
                threee?.btn_like.setImage(#imageLiteral(resourceName: "like"), for: .normal)
                threee?.btn_like.isSelected = false
            }
           
            threee?.lbl_food.text = dict["food"].stringValue
            threee?.lbl_ambiance.text = dict["ambiance"].stringValue
            threee?.lbl_service.text = dict["service"].stringValue
            threee?.lbl_description.text = dict["Description"].stringValue
            
            threee?.btn_ac.setImage(#imageLiteral(resourceName: "ac_grey"), for: .normal)
            threee?.btn_delivery.setImage(#imageLiteral(resourceName: "homedelivery_grey"), for: .normal)
            threee?.btn_takeAway.setImage(#imageLiteral(resourceName: "takeaway_grey"), for: .normal)
            threee?.btn_parking.setImage(#imageLiteral(resourceName: "parking_grey"), for: .normal)
            
            if dict["highlights"].stringValue.isEmpty == false
            {
                let fullNameArr = dict["highlights"].stringValue.components(separatedBy: ";")
                for i in fullNameArr
                {
                    if i == "1"{
                        threee?.btn_ac.setImage(#imageLiteral(resourceName: "ac"), for: .normal)
                    }
                    else if i == "2"{
                        threee?.btn_delivery.setImage(#imageLiteral(resourceName: "homedelivery"), for: .normal)
                    }
                    else if i == "3"{
                        
                        threee?.btn_takeAway.setImage(#imageLiteral(resourceName: "takeaway"), for: .normal)
                        
                    }
                    else if i == "4"{
                        threee?.btn_parking.setImage(#imageLiteral(resourceName: "parking"), for: .normal)
                        
                    }else{
                        
                    }
                    
                }
            }
           
 

            threee?.img_post.sd_setImage(with: URL.init(string: count[0].stringValue), placeholderImage: UIImage.init(named: "suggestMenuBg"), options: [.continueInBackground, .progressiveDownload])
            
            threee?.img_post1.sd_setImage(with: URL.init(string: count[1].stringValue), placeholderImage: UIImage.init(named: "suggestMenuBg"), options: [.continueInBackground, .progressiveDownload])
            
            threee?.img_post2.sd_setImage(with: URL.init(string: count[2].stringValue), placeholderImage: UIImage.init(named: "suggestMenuBg"), options: [.continueInBackground, .progressiveDownload])
            
            return threee!
            
        }
        
        else if count.count == 4 || count.count  >= 4
        {
            //fourth
            
            four = myFeedTable.dequeueReusableCell(withIdentifier: "fo") as? four
            
            four?.img_featured.sd_setImage(with: URL.init(string: dict["featured_image"].stringValue), placeholderImage: UIImage.init(named: "suggestMenuBg"), options: [.continueInBackground, .progressiveDownload])
            four?.lbl_restaurantName.text = dict["name"].stringValue
            four?.lbl_restaurantAddress.text = dict["address"].stringValue
            if dict["IsSaved"].boolValue == true {
                four?.btn_heiglight.setImage(#imageLiteral(resourceName: "saved"), for: .selected)
                four?.btn_heiglight.isSelected = true
            }
            else{
                four?.btn_heiglight.setImage(#imageLiteral(resourceName: "save"), for: .normal)
                four?.btn_heiglight.isSelected = false
            }
           
            if dict["IsLiked"].boolValue == true
            {
                four?.btn_like.setImage(#imageLiteral(resourceName: "like_1"), for: .selected)
                four?.btn_like.isSelected = true
            }
            else
            {
                four?.btn_like.setImage(#imageLiteral(resourceName: "like"), for: .normal)
                four?.btn_like.isSelected = false
            }
            
            four?.lbl_food.text = dict["food"].stringValue
            four?.lbl_ambiance.text = dict["ambiance"].stringValue
            four?.lbl_service.text = dict["service"].stringValue
            four?.lbl_description.text = dict["Description"].stringValue
            
            
            four?.btn_ac.setImage(#imageLiteral(resourceName: "ac_grey"), for: .normal)
            four?.btn_delivery.setImage(#imageLiteral(resourceName: "homedelivery_grey"), for: .normal)
            four?.btn_takeAway.setImage(#imageLiteral(resourceName: "takeaway_grey"), for: .normal)
            four?.btn_parking.setImage(#imageLiteral(resourceName: "parking_grey"), for: .normal)
            if dict["highlights"].stringValue.isEmpty == false
            {
                let fullNameArr = dict["highlights"].stringValue.components(separatedBy: ";")
                for i in fullNameArr
                {
                    if i == "1"{
                        four?.btn_ac.setImage(#imageLiteral(resourceName: "ac"), for: .normal)
                    }
                    else if i == "2"{
                        four?.btn_delivery.setImage(#imageLiteral(resourceName: "homedelivery"), for: .normal)
                    }
                    else if i == "3"{
                        
                        four?.btn_takeAway.setImage(#imageLiteral(resourceName: "takeaway"), for: .normal)
                        
                    }
                    else if i == "4"{
                        four?.btn_parking.setImage(#imageLiteral(resourceName: "parking"), for: .normal)
                        
                    }else{
                        
                    }
                    
                }
            }
 

            four?.img_post1.sd_setImage(with: URL.init(string: count[1].stringValue), placeholderImage: UIImage.init(named: "suggestMenuBg"), options: [.continueInBackground, .progressiveDownload])
            four?.img_post2.sd_setImage(with: URL.init(string: count[2].stringValue), placeholderImage: UIImage.init(named: "suggestMenuBg"), options: [.continueInBackground, .progressiveDownload])
            four?.img_post3.sd_setImage(with: URL.init(string: count[3].stringValue), placeholderImage: UIImage.init(named: "suggestMenuBg"), options: [.continueInBackground, .progressiveDownload])
           
            let count = dict["ImageUrl"].count - 4
            if count > 1 {
                four?.lbl_imgcount.text  = "+ \(String(describing: count))"
                four?.lbl_imgcount.isHidden = false
            }
            else
            {
                four?.lbl_imgcount.isHidden = true
            }
            
            return four!
        }
        else
        {
            one = myFeedTable.dequeueReusableCell(withIdentifier: "on") as? one
            
            one?.img_featured.sd_setImage(with: URL.init(string: dict["featured_image"].stringValue), placeholderImage: UIImage.init(named: "suggestMenuBg"), options: [.continueInBackground, .progressiveDownload])
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
  
}


//  FoodiesVC.swift
//  Test
//  Created by vaayoousa on 03/07/18.
//  Copyright © 2018 Ranjeet Raushan. All rights reserved.

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
class FoodiesVC: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    @IBOutlet weak var foodiesTable: UITableView!
    var foodiesArray = Array<JSON>()
    override func viewDidLoad() {
        super.viewDidLoad()
        foodiesTable.delegate = self
        foodiesTable.dataSource = self
        self.foodiesTable.addSubview(self.refresherControl) //concept regarding pull to refresh
        hitService()
    }
    func hitService(){
        //call service
        let headers = [
            //"token": UserDefaults.standard.object(forKey: "token") as! String,
            "token": "60fe1a9c-c752-4e07-8646-04da86c4897760fe1a9c-c752-4e07-8646-04da86c48977",
            "Content-Type": "application/json"
        ]
        let endPoint = "http://tiptooservices.azurewebsites.net/api/v1/Foodies/12.925007/77.593803/5/0/50"
        Alamofire.request(endPoint,headers: headers).responseJSON { response in
            self.foodiesArray.removeAll()
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    if  let value = response.result.value{
                        let json = JSON(value)
                        print("response : \(response.result.value!)")
                        // showAlert(msg: json["message"].stringValue)
                        if json["ControlsData"].isEmpty == false {
                            let ControlsData = (json["ControlsData"].dictionary!)
                            for object in ControlsData["lsv_foodies"]! {
                                self.foodiesArray.append(object.1)//preparing data set by putting dict into array
                                 self.foodiesTable.reloadData()
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
        return foodiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // find the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodiesCell") as! FoodiesCell
        
        // find each elements objects within cell
 
      
        let name_lbl = cell.lbl_name
        let reviews_lbl = cell.lbl_reviews
        let followers_lbl = cell.lbl_followers
       
        
        // read datasource(foodiesArray) and get dict within it and read each key/value
        //lsv_foodies
        
        let dict =  foodiesArray[indexPath.row]
        let nameUser = dict["UserName"].stringValue
        let reviiews = dict["Reviews"].stringValue
        let foollowers = dict["Followers"].stringValue
      
        // image binding
        
        cell.img.sd_setImage(with: URL.init(string: dict["ProfileUrl"].stringValue), placeholderImage: UIImage.init(named: "AvatarSmall"), options: [.continueInBackground, .progressiveDownload])
        
        //bind the data
        
        name_lbl?.text = nameUser
        reviews_lbl?.text = "\(reviiews) Reviews , "
        followers_lbl?.text = "\(foollowers) Followers"
        
        
        return cell
}
    // pull to refresh
    lazy  var refresherControl:UIRefreshControl = {
        let refrsControl = UIRefreshControl()
        refrsControl.addTarget(self , action: #selector(FoodiesVC.pullToRefresh(_:)) , for: .valueChanged)
        refrsControl.tintColor = UIColor.blue
        return refrsControl
    }()
    @objc func pullToRefresh(_ refrsControl: UIRefreshControl){
       
        let deadline = DispatchTime.now() + .milliseconds(20)//increase or decrease refreshing time from here
        DispatchQueue.main.asyncAfter(deadline: deadline){
            self.foodiesTable.reloadData()
            refrsControl.endRefreshing()
        }
    }
}

//  ViewController.swift
//  Test
//  Created by vaayoousa on 5/6/18.
//  Copyright © 2018 vaayoousa. All rights reserved.

import UIKit
import Alamofire 
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,FindLocation_Delegate {
    var latitude: String = ""
    var longitude: String = ""
    @IBAction func onPlaceClick(_ sender: UIBarButtonItem) {
        //Find NavigationController(NC)  and get ViewController(VC) from it as its child
        let navi = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navLocation") as! LocationNV
        let destinationV = navi.topViewController as! FindLocation
        //set delegate
        destinationV.Map_Delegate = self
        //set parameters of second screen
        destinationV.controllerName = "none"
        //handle nav bar of of map vc
        destinationV.hidesBottomBarWhenPushed = true
        self.navigationController?.navigationBar.isHidden = false
        // launch (push) map vc
        self.navigationController?.pushViewController(destinationV, animated: true)    }
    @IBOutlet weak var myCollectionView: UICollectionView!
    var restaurantList = Array<JSON>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
       
    }
    func hitService(){
    //call service
    let headers = [
        //"token": UserDefaults.standard.object(forKey: "token") as! String,
        "token": "A22614C0-7DF8-4A43-8C0D-64FD4B7743C5",
        "Content-Type": "application/json"
    ]
    
//    let endPoint = "http://tiptooservices.azurewebsites.net/api/v1/LandingResturantList/12.933058/77.584239/5/0/1/20"
        let endPoint = "http://tiptooservices.azurewebsites.net/api/v1/LandingResturantList/\(latitude)/\(longitude)/5/0/1/20"
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray) // Create the activity indicator
        view.addSubview(activityIndicator) // add it as a  subview
        activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.5) // put in the middle
        activityIndicator.startAnimating() // Start animating
        activityIndicator.color = UIColor.red
    
        
    

        Alamofire.request(endPoint,headers: headers).responseJSON { response in
        
            activityIndicator.stopAnimating() // On response stop animating
            activityIndicator.removeFromSuperview() // remove the view

            
            self.restaurantList.removeAll()
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
                            self.restaurantList.append(object.1)//preparing data set by putting dict into array
                            self.myCollectionView.reloadData()//calling noOfItemsInSection and cellForRowAt method
                            
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //First find the cell
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionItem", for: indexPath) as! CollectionCell
        // find each elements objects within cell
        let imageview = cell.imgView
        let restName = cell.name
        let address =  cell.add_lbl
        let amount = cell.amount_lbl
        let distance = cell.distance_lbl
        let point = cell.points_lbl
        let food = cell.food_lbl
        let ambiance = cell.ambiance_lbl
        let service = cell.service_lbl
        
        // read datasource(restaurantList) and get dict within it and read each key/value
        let dict =  restaurantList[indexPath.row]
        let imageUrl = dict["featured_image"].stringValue
        let name = dict["name"].stringValue
        let addresss =  dict["address"].stringValue
        let price = dict["average_cost"].stringValue
        let distances = dict["distance"].stringValue
        let review = dict["Reviews"].stringValue
        let foodd = dict["food"].stringValue
        let ambiancee = dict["ambiance"].stringValue
        let servicee = dict["service"].stringValue
        
        // Now bind data to its crossponding ui object
        // download and bind image to imageview
        
//        imageView?.sd_setImage(with: URL.init(string: dict["ResturantImage"].stringValue),placeholderImage:#imageLiteral(resourceName: "Asset 134"), options: [.continueInBackground, .progressiveDownload])
        
        
        imageview?.sd_setImage(with: URL.init(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "homeBg"), options: [.continueInBackground,.progressiveDownload], completed: nil)
        
        // bind rest of the text data direclty
        restName?.text = name
        address?.text = addresss
        amount?.text = price
        distance?.text = distances
        point?.text = review
        food?.text = foodd
        ambiance?.text = ambiancee
        service?.text = servicee
        
         //cell.name = dict["name"].stringValue
        
        return cell 
        
    }
    //UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //finding target vc
    let restDetailView =     self.storyboard?.instantiateViewController(withIdentifier: "RestDetailView") as! RestDetailView
        //passing data to target vc by setting values to its global variable
       let dict =  restaurantList[indexPath.row]
        restDetailView.ResturantID = dict["ResturantID"].stringValue
        restDetailView.latitude = dict["latitude"].stringValue
        restDetailView.longitude = dict["longitude"].stringValue
        //launching target vc through present method(second way is push method)
        present(restDetailView, animated: true, completion: nil)
        
    }
    //delegate method
    func getJioPoints(Latitude: String, Longitude: String, text: String) {
        latitude = Latitude
        longitude = Longitude
        //locationTF.text = text
         hitService()
    }
    
}

//  RestDetailView.swift
//  Test
//  Created by vaayoousa on 5/6/18.
//  Copyright © 2018 vaayoousa. All rights reserved.
import Foundation
import UIKit
import SDWebImage
import SwiftyJSON
import Alamofire

 class RestDetailView: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource {
    var  ResturantID = ""
    var latitude = ""
    var longitude = ""
    @IBOutlet weak var restCollectionView: UICollectionView!
    @IBOutlet weak var menucollectionView: UICollectionView!
 
    var restaurantList = Array<JSON>() // Global Variable
    var restaurantList2 = Array<JSON>() // Global Variable
    
    @IBOutlet weak var mainScroll: UIScrollView!
    @IBOutlet weak var subScrollVw: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var name_lbl: UILabel!
    @IBOutlet weak var addres_lbl: UILabel!
    @IBOutlet weak var cost_lbl: UILabel!
    @IBOutlet weak var locat_bttn: UIButton!
    @IBOutlet weak var recom_bttn: UIButton!
    @IBOutlet weak var lbl_km: UILabel!
    @IBOutlet weak var lbl_rate: UILabel!
    @IBOutlet weak var subView1: UIView!
    @IBOutlet weak var call_bttn: UIButton!
    @IBOutlet weak var rev_bttn: UIButton!
    @IBOutlet weak var cemara_bttn: UIButton!
    @IBOutlet weak var filter_bttn: UIButton!
    @IBOutlet weak var share_bttn: UIButton!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuImg: UIImageView!
    @IBOutlet weak var menu_lbl: UILabel!
    @IBOutlet weak var lbl_suggestCount: UILabel!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var overVw_lbl: UILabel!
    @IBOutlet weak var overVw_bttn: UIButton!
    @IBOutlet weak var overVw_detail: UILabel!
    @IBOutlet weak var foodView: UIView!
    @IBOutlet weak var food_lbl: UILabel!
    @IBOutlet weak var ambnce_lbl: UILabel!
    @IBOutlet weak var service_lbl: UILabel!
    @IBOutlet weak var food_rate: UILabel!
    @IBOutlet weak var ambnce_rate: UILabel!
    @IBOutlet weak var service_rate: UILabel!
    @IBOutlet weak var review_bttn: UIButton!
    @IBOutlet weak var suggest_btn: UIButton!
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var photo_lbl: UILabel!
    @IBOutlet weak var img_photo1: UIImageView!
    @IBOutlet weak var img_photo2: UIImageView!
    @IBOutlet weak var img_photo3: UIImageView!
    @IBOutlet weak var lbl_imagesCount: UILabel!
    @IBOutlet weak var hightlightView: UIView!
    @IBOutlet weak var hight_lbl: UILabel!
    @IBOutlet weak var homeDev_Btn: UIButton!
    @IBOutlet weak var takeaway_bttn: UIButton!
    @IBOutlet weak var carpark_bttn: UIButton!
    @IBOutlet weak var ac_bttn: UIButton!
    @IBOutlet weak var lbl_ac: UILabel!
    @IBOutlet weak var lbl_homeDelivery: UILabel!
    @IBOutlet weak var lbl_takeAway: UILabel!
    @IBOutlet weak var lbl_carParking: UILabel!
    @IBOutlet weak var userreviewView: UIView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userName_lbl: UILabel!
    @IBOutlet weak var userreview_lbl: UILabel!
    @IBOutlet weak var userfollow_lbl: UILabel!
    @IBOutlet weak var userfood_lbl: UILabel!
    @IBOutlet weak var userambiance_lbl: UILabel!
    @IBOutlet weak var userservice_lbl: UILabel!
    @IBOutlet weak var UfoodRate_lbl: UILabel!
    @IBOutlet weak var UserviceRate_lbl: UILabel!
    @IBOutlet weak var userDetail_lbl: UILabel!
    @IBOutlet weak var recomnended_lbl: UILabel!
    @IBOutlet weak var like_lbl: UILabel!
    @IBOutlet weak var viewAll_lbl: UILabel!
    @IBOutlet weak var comment_lbl: UILabel!
    @IBOutlet weak var UambianceRate_lbl: UILabel!
    @IBOutlet weak var similar_view: UIView!
    @IBOutlet weak var similartitle_lbl: UILabel!
    
  
    override func viewDidLoad() {
    super.viewDidLoad()
      
        restCollectionView.delegate = self
        restCollectionView.dataSource = self
        menucollectionView.delegate = self
        menucollectionView.dataSource = self
        
        hitService()
    
    }
func hitService(){
    let headers = [
         "token": "A22614C0-7DF8-4A43-8C0D-64FD4B7743C5" ,"Content-Type": "application/json"
    ]
    
   //let endPoint =  http://tiptooservices.azurewebsites.net/api/v1/ResturantDetails/\(latitude!)/\(longitude!)/\(resturantId!)
   // let endPoint = "http://tiptooservices.azurewebsites.net/api/v1/ResturantDetails/12.971989/77.596103/04122a3f-6356-4f22-8a48-85592a803d3b"
    
    let endPoint = "http://tiptooservices.azurewebsites.net/api/v1/ResturantDetails/\(latitude)/\(longitude)/\(ResturantID)"
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray) // Create the activity indicator
    view.addSubview(activityIndicator) // add it as a  subview
    activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.5) // put in the middle
    activityIndicator.startAnimating() // Start animating
    activityIndicator.color = UIColor.red
   
    Alamofire.request(endPoint,headers: headers).responseJSON { response in
        activityIndicator.stopAnimating() // On response stop animating
        activityIndicator.removeFromSuperview() // remove the view
        switch(response.result) {
        case .success(_):
            if response.result.value != nil{
                if  let value = response.result.value{
                    _ = Array<JSON>()
                    self.restaurantList2 = Array<JSON>()
                    
                    let json = JSON(value)
                    print("response : \(response.result.value!)")
                    if json["ControlsData"].isEmpty == false {
                        let ControlsData = (json["ControlsData"].dictionaryValue)

                        
                        for object in (ControlsData["lsv_resturantinfo"]?.arrayValue)! {
                            
                            //Arrange form/control Data by parsing
                            let featured_image_url = object["featured_image"].stringValue
                            let id = object["ResturantID"].stringValue
                            let name = object["ResturantName"].stringValue
                            let addresss =  object["Address"].stringValue
                            let price = object["Average_cost"].stringValue
                            let distances = object["distance"].intValue
                            let review = object["Reviews"].intValue
                            let foodd = object["DetailsFood"].intValue
                            let ambiancee = object["DetailsAmbiance"].intValue
                            let servicee = object["DetailsService"].intValue
                            let followers = object["UserFollowers"].intValue
                            let countreview = object["ReviewCount"].intValue
                            
                            //now bind data to controls
                            self.name_lbl.text = name  //label binding
                            self.addres_lbl.text = addresss
                            self.cost_lbl.text = price
                            self.review_bttn.setTitle("review: \(review)", for: .normal)//button binding
                            
                           self.imgView?.sd_setImage(with: URL.init(string: featured_image_url), placeholderImage: #imageLiteral(resourceName: "homeBg"), options: [.continueInBackground,.progressiveDownload], completed: nil)//image binding
                            
                          
                        }
                        
                        
                        for object in ControlsData["lsv_suggestmenu"]!//change kry
                        {
                            
                            self.restaurantList2.append(object.1)
                        }
                        
                        self.menucollectionView.reloadData()
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
    //UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //cond
        //how many items(cell) to be displayed in collection view
            return restaurantList2.count
        }
        
        
    
    //UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // how to display the data in the cell(find ui elements, parsing data , binding data to UI elements
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "menucell", for: indexPath) as! MenuCollectionCell
            // find each elements objects within cell
            
            let labeltitle = cell1.label_title
            let labeldescrpton = cell1.label_descrpton
            let imgeview = cell1.imge_view
            let  labelcount = cell1.label_count
    
        // read datasource(restaurantList) and get dict within it and read each key/value
        //lsv_suggestmenu
        let dict1 =  restaurantList2[indexPath.row]
       // let currencycodee = dict1["CurrencyCode"].stringValue
        let descrpton = dict1["Description"].stringValue
        let dishImagesCount = dict1["DishImagesCount"].intValue
        let dishhname = dict1["DishName"].stringValue
        //let pricee = dict1["Price"].stringValue
        //let cusinee = dict1["cusine"].stringValue
        let dishimageurl = dict1["DishImages"].arrayValue
        var imgStringArr:[String] = dict1["DishImages"].arrayValue.map { $0.stringValue}
        if imgStringArr.count > 0 {
        
            let firstImgUrl = imgStringArr[0]
        imgeview?.sd_setImage(with: URL.init(string: firstImgUrl), placeholderImage: #imageLiteral(resourceName: "homeBg"), options: [.continueInBackground,.progressiveDownload], completed: nil)//image binding
        }
        
        labeltitle?.text = dishhname
        labeldescrpton?.text = descrpton
        labelcount?.text = "dishImagesCount:\(dishImagesCount)"
        
         return cell1
    }
   
    @IBAction func onBackClick(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)//present
    }
    
}
/* to bind array and image
 1.) var imgStringArr:[String] = object["ImageUrl"].arrayValue.map { $0.stringValue}
     if imgStringArr.count > 0 {
     self.ImgCountLbl.text = "  1 out of \(imgStringArr.count)  "
     let firstImgUrl = imgStringArr[0]
 2.) self.propertyIV?.sd_setImage(with: URL.init(string: firstImgUrl),placeholderImage: #imageLiteral(resourceName: "noimage"), options: [.continueInBackground, .progressiveDownload])
 }
 */

//  GetTogetherVC.swift
//  Test
//  Created by vaayoousa on 09/07/18.
//  Copyright © 2018 Ranjeet Raushan. All rights reserved.

import UIKit
import SDWebImage

class GetTogetherVC: UIViewController, FindLocation_Delegate {
    func getJioPoints(Latitude: String, Longitude: String, text: String) {
 }
enum TabIndex : Int {
        case feeeddChildTab = 0
        case myfeeedChildTab = 1
        case fooodiesChildTab = 2
    }
    @IBOutlet weak var segmentedControl: SegmentControl!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var btn_search: UIButton!
    @IBOutlet weak var btn_dropDown: UIButton!
    
    let app = UIApplication.shared.delegate as! AppDelegate
    var index: Int = 0
    
    var currentViewController: UIViewController?
    lazy var feeeddChildTabVC: UIViewController? = {
        let feeeddChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "feeedd")
        return feeeddChildTabVC
    }()
    lazy var myfeeedChildTabVC : UIViewController? = {
        let myfeeedChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "myfeeed")
        return myfeeedChildTabVC
    }()
    lazy var fooodiesChildTabVC : UIViewController? = {
        let fooodiesChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "fooodies")
        return fooodiesChildTabVC
    }()
  // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.initUI()
        segmentedControl.selectedSegmentIndex = TabIndex.feeeddChildTab.rawValue
        displayCurrentTab(TabIndex.feeeddChildTab.rawValue)
        self.navigationController?.navigationBar.isTranslucent = false
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let currentViewController = currentViewController {
            currentViewController.viewWillDisappear(animated)
        }
    }

    // MARK: - Switching Tabs Functions
    @IBAction func switchTabs(_ sender: UISegmentedControl) {
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParentViewController()
        displayCurrentTab(sender.selectedSegmentIndex)
    }
    
    func displayCurrentTab(_ tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            if tabIndex == 1
            {
                btn_search.isHidden = true
                btn_dropDown.isEnabled = false
            }
            else{
                
                btn_search.isHidden = false
                btn_dropDown.isEnabled = true
                
            }
            if tabIndex == 0
            {
                btn_search.isHidden = true
            }
            index = tabIndex
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            vc.view.frame = self.contentView.bounds
            self.contentView.addSubview(vc.view)
            self.currentViewController = vc
        }
    }
    func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case TabIndex.feeeddChildTab.rawValue :
            vc = feeeddChildTabVC
        case TabIndex.myfeeedChildTab.rawValue :
            vc = myfeeedChildTabVC
        case TabIndex.fooodiesChildTab.rawValue :
            vc = fooodiesChildTabVC
        default:
            return nil
        }
        return vc
 }
    @IBAction func btnDropDown(_ sender: Any) {
        let navi = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navLocation") as! LocationNV
        
        let destinationV = navi.topViewController as! FindLocation
        destinationV.Map_Delegate = self
        destinationV.controllerName = "segment"
        destinationV.hidesBottomBarWhenPushed = true
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.pushViewController(destinationV, animated: true)
    }
    func MapviewWithresults(Latitude: String, Longitude: String, text: String)
    {
        SDWebImageManager.shared().imageCache.clearDisk()
        SDWebImageManager.shared().imageCache.clearMemory()
        NotificationCenter.default.post(name: Notification.Name("feedVC"), object: nil)
        NotificationCenter.default.post(name: Notification.Name("foodiesVC"), object: nil)
        
    }
}


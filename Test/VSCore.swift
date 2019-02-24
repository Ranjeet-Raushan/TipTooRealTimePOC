//  VSCore.swift
//  Test
//  Created by vaayoo on 24/07/18.
//  Copyright © 2018 Ranjeet Raushan. All rights reserved.

import UIKit

class VSCore: NSObject {
    
    func getColor(_ hexString: String, alpha:CGFloat? = 1.0) -> UIColor
    {
        
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func ColorNormal() -> UIColor {
        return VSCore().getColor("#e45641")
    }
    func intFromHexString(_ hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
    func getImagesFolder() -> NSString
    {
        let documentFolderPath = NSHomeDirectory() + "Documents" as NSString
        let fileManager = FileManager.default
        let imagesFolderPath = documentFolderPath.appendingPathComponent("Images") as NSString
        
        //Check if the images folder is already exist?  if not create it!
        var isDir: ObjCBool = false
        
        //if (fileManager.fileExists(atPath: imagesFolderPath as String, isDirectory: &isDir) && isDir) == false
        if fileManager.fileExists(atPath: imagesFolderPath as String, isDirectory:&isDir)
        {
            if !isDir.boolValue
            {
                do
                {
                    try FileManager.default.createDirectory(atPath: imagesFolderPath as String, withIntermediateDirectories: true, attributes: nil)
                }
                catch
                {
                    let fetchError = error as NSError
                    print(fetchError)
                }
            }
            
        }
        return imagesFolderPath
    }
    func getUniqueFileName() -> NSString
    {
        let time = Date()
        let df = DateFormatter.init()
        df.dateFormat = "MMddyyyyhhmmssSSS"
        let timeString = df.string(from: time)
        let fileName = NSString.localizedStringWithFormat(timeString as NSString, no_argument)
        return fileName
    }
    
    func loadingView() ->UIAlertController  {
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating()
        //loadingIndicator.color = UIColor.init(hex: "E45641")
        alert.view.addSubview(loadingIndicator)
        return alert
    }
    
}

//
//  ExtensionFunc.swift
//  HiTaxi
//
//  Created by Nong Than on 2/14/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import Foundation
import UIKit

extension UserDefaults {
    // check for is first launch - only true on first invocation after app install, false on all further invocations
    // Note: Store this value in AppDelegate if you have multiple places where you are checking for this flag
    static func isFirstLaunch() -> Bool {
        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
}


extension UIImageView {
    func LoadImageUrlString(urlString:String) {

        URLSession.shared.dataTask(with: URL(string: urlString)!) { (d, r, e) in
            if e != nil {
                print("Loi load anh!", e!)
            }
            
            DispatchQueue.main.sync(execute: { () -> Void in
                let imageLoad = UIImage(data: d!)
                self.image = imageLoad
            })
            
         }.resume()
    }
}

extension NSNumber {
    
    func dinhDangTien(soTien:NSNumber) -> String {
        //Dinh Dang Tien
        let numberFormartter = NumberFormatter()
            numberFormartter.numberStyle = .decimal
        return "\(numberFormartter.string(from: soTien)!) đ"
    }
}

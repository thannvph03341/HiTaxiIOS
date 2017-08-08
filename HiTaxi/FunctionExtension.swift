//
//  FunctionExtension.swift
//  HiTaxi
//
//  Created by Nong Than on 2/3/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import UIKit

extension UIView{
    func addConstraintsArray(format:String, viewAdd:UIView...){
        var arrView = [String : UIView]()
        
        for(index, view) in viewAdd.enumerated()
        {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            arrView[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: arrView))
    }
}

extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

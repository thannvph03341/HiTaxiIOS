//
//  NavigationCellUser.swift
//  HiTaxi
//
//  Created by Nong Than on 2/19/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Google
import GoogleSignIn

class NavigationCellUser:UICollectionViewCell {

    
   static var imageUser:UIImageView = {
        let img = UIImageView(frame: .zero)
        img.image = UIImage(named: "noimage")
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        return img
    }()
    
    static var txtTen:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.text = ""
        lb.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/25)
        lb.textColor = UIColor.white
        return lb
    }()
    
    
   override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
//    public func setUpLogin(user: GIDGoogleUser){
//        if FBSDKAccessToken.current() != nil{
//            // print(token.userID)
//            
//            let parammeters = ["fields": "email,link,id,first_name,last_name, name,locale,gender,picture.type(large)"]
//            FBSDKGraphRequest(graphPath: "me",parameters: parammeters).start { (connection, result, error) in
//                if error != nil{
//                    
//                    print(error!)
//                    
//                    return
//                    
//                }
//                
//                let data:[String:AnyObject] = result as! [String : AnyObject]
//                
//                self.imageUser.LoadImageUrlString(urlString: AnhFacebook(idNguoiDung: data["id"] as? String != nil ?  data["id"] as! String:""))
//                self.txtTen.text = data["name"] as? String != nil ? data["name"] as! String:""
//                // self.viewTaiKhoan.setData(imgUser: AnhFacebook(idNguoiDung: data["id"] as? String != nil ?  data["id"] as! String:""), txtHoTen: data["name"] as? String != nil ? data["name"] as! String:"", txtSDT: "", txtDiaChi: "", txtEmail: "")
//                
//            }
//            
//        } else if user.userID != nil {
//            self.imageUser.LoadImageUrlString(urlString: user.profile.imageURL(withDimension: 0).absoluteString)
//            self.txtTen.text = user.profile.name
//        }
//    }
//    
    
    func setupView(){
    
        addSubview(NavigationCellUser.imageUser)
        addSubview(NavigationCellUser.txtTen)
        addConstraintsArray(format: "H:|-30-[v0]", viewAdd: NavigationCellUser.imageUser)
        addConstraintsArray(format: "V:[v0]", viewAdd: NavigationCellUser.imageUser)
        
        addConstraintsArray(format: "H:[v0]", viewAdd: NavigationCellUser.txtTen)
        addConstraintsArray(format: "V:[v0]", viewAdd: NavigationCellUser.txtTen)
        
        addConstraint(NSLayoutConstraint(item: NavigationCellUser.imageUser, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.5, constant: 0))
        addConstraint(NSLayoutConstraint(item: NavigationCellUser.imageUser, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.5, constant: 0))
        addConstraint(NSLayoutConstraint(item: NavigationCellUser.imageUser, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: NavigationCellUser.txtTen, attribute: .top, relatedBy: .equal, toItem: NavigationCellUser.imageUser, attribute: .bottom, multiplier: 1, constant: 5))
        addConstraint(NSLayoutConstraint(item: NavigationCellUser.txtTen, attribute: .centerX, relatedBy: .equal, toItem: NavigationCellUser.imageUser, attribute: .centerX, multiplier: 1, constant: 0))
        
        
       NavigationCellUser.imageUser.layer.cornerRadius = frame.height/4
        NavigationCellUser.imageUser.layer.masksToBounds = true
       
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

//
//  NavigationMenu.swift
//  HiTaxi
//
//  Created by Nong Than on 2/3/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import UIKit
import GoogleSignIn
import Google

class NavigationMenu:NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var classTrangChu:TrangChu?
    var user:GIDGoogleUser?
    
    let listMenu = [1:[NSLocalizedString("TrangChu", comment:""), "home"],
                    2:[NSLocalizedString("DanhSachTaxi", comment: ""), "menuList"],
                    3:[NSLocalizedString("ThongBao", comment: ""), "notifications"],
                    4:[NSLocalizedString("TaxiYeuThich", comment: ""), "favourite_green"],
                    5:[NSLocalizedString("UocTinhChiPhi", comment: ""), "moneyIcon"],
                    6:[NSLocalizedString("TaiKhoan", comment: ""), "iconAccount"],
                    7:[NSLocalizedString("CaiDat", comment: ""), "iconSetup"],
                    8:[NSLocalizedString("GioiThieu", comment: ""), "iconInfo"],
                    9:[NSLocalizedString("LienHe", comment: ""), "iconCall1"]]
    
    let InfoUser = ["userIcon", "Nông Văn Thân", "thannvph03341@gmail.com"]
    
    let viewManager = UIView()
    let idCellInfoUser:String = "idCellInfoUser"
    let idCellListLableMenu:String = "idCellListLableMenu"
    
    
    
    
    lazy var viewControler:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.showsVerticalScrollIndicator = false
        vc.showsHorizontalScrollIndicator = false
        vc.dataSource = self
        vc.delegate = self
        vc.backgroundColor = UIColor.white
        return vc
    }()
    
    
    func setupMenu(){
      if let windown = UIApplication.shared.keyWindow {
            viewManager.frame = CGRect(x: 0, y: 0, width: windown.frame.width, height: windown.frame.height)
       
            viewManager.backgroundColor = UIColor(white: 0, alpha: 0.5)
          //  viewManager.addSubview(viewControler)
        
            windown.addSubview(viewManager)
            windown.addSubview(viewControler)
            viewControler.register(NavigationCellUser.self, forCellWithReuseIdentifier: idCellInfoUser)
            viewControler.register(NavigationCellMenu.self, forCellWithReuseIdentifier: idCellListLableMenu)
            windown.addConstraintsArray(format: "H:|[v0(\(windown.frame.width - 50))]", viewAdd: viewControler)
            windown.addConstraintsArray(format: "V:|[v0]|", viewAdd: viewControler)
            viewManager.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                self.viewManager.alpha = 1
                self.viewControler.alpha = 1
            }, completion: nil)
            viewManager.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HanderMenu)))
        }
    }
    
    func HanderMenu(){
        UIView.animate(withDuration: 0.5) { 
            self.viewManager.alpha = 0
            self.viewControler.alpha = 0
        }
    }
    
    override init() {
        
        super.init()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listMenu.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCellInfoUser, for: indexPath) as! NavigationCellUser
            cell.backgroundColor = UIColor.rgb(red: 107, green: 182, blue: 88)
            if self.user != nil {
               // cell.setUpLogin(user: self.user!)
            }
            return cell
            
        default:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCellListLableMenu, for: indexPath) as! NavigationCellMenu
                cell.layer.borderColor = UIColor.black.cgColor
                cell.layer.borderWidth = 0.5
                cell.layer.masksToBounds = true
                cell.clipsToBounds = true
                cell.backgroundColor = UIColor.white
                cell.listMenu = listMenu[indexPath.row]
           
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        classTrangChu?.textTitle.text = listMenu[indexPath.item]?[0]
        classTrangChu?.setViewOnclickMenu(index: indexPath.item)
        self.viewManager.alpha = 0
        self.viewControler.alpha = 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
        case 0:
            return CGSize(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.width/2.5)
        case 1:
            return CGSize(width: 0, height: 0)
        default:
            return CGSize(width: UIScreen.main.bounds.width - 50, height: 50)
        }
        
    }
    
}

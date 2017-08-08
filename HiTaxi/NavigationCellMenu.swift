//
//  NavigationCellMenu.swift
//  HiTaxi
//
//  Created by Nong Than on 2/6/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import UIKit

class NavigationCellMenu:UICollectionViewCell {
    
    var listMenu:[String]? {
        didSet{
            if let nameImg = listMenu?[1] {
                imageIconMenu.image = UIImage(named: nameImg)?.withRenderingMode(.alwaysTemplate)
                imageIconMenu.tintColor = UIColor.rgb(red: 110, green: 110, blue: 110)
            }
            if let txt = listMenu?[0] {
                txtMenu.text = txt
            }
        }
    }
   
    
    
    let imageIconMenu:UIImageView = {
        let img = UIImageView(frame: .zero)
        img.image = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
        img.contentMode = .scaleToFill
        img.clipsToBounds = true
        return img
    }()
    
    let txtMenu:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.text = "menu"
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.textColor = UIColor.rgb(red: 110, green: 110, blue: 110)
        return lb
    }()
    

    override var isSelected: Bool{
        didSet{
            txtMenu.textColor = isSelected ? UIColor.blue: UIColor.black
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupview()
        
        
    }
    
    func setupview(){
        addSubview(imageIconMenu)
        addSubview(txtMenu)
        addConstraintsArray(format: "H:|-5-[v0(40)]-25-[v1]", viewAdd: imageIconMenu, txtMenu)
        addConstraintsArray(format: "V:|-5-[v0]-5-|", viewAdd: imageIconMenu)
        addConstraintsArray(format: "V:|[v0]|", viewAdd: txtMenu)
  
       
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

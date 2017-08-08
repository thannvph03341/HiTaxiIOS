//
//  UiCellThongBao.swift
//  HiTaxi
//
//  Created by Nong Than on 4/5/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import UIKit

class UICellThongBao:UICollectionViewCell{


    
    let txtLb1:UITextView = {
        let t = UITextView(frame: .zero)
        t.text = NSLocalizedString("4cho", comment: "")
        t.textColor = UIColor.black
       // t.backgroundColor = UIColor.blue
        t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/25)
        return t
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    

    func setView(){
        addSubview(txtLb1)
        addConstraintsArray(format: "H:|[v0]|", viewAdd: txtLb1)
        addConstraintsArray(format: "V:|[v0]|", viewAdd: txtLb1)
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let top = CALayer()
            top.backgroundColor = UIColor.init(red: 79/255, green: 184/255, blue: 72/255, alpha: 1).cgColor
            top.frame = CGRect(x: 0, y: 0, width: txtLb1.frame.width, height: 1)
        
        let left = CALayer()
        left.backgroundColor = UIColor.init(red: 79/255, green: 184/255, blue: 72/255, alpha: 1).cgColor
        left.frame = CGRect(x: 0, y: 0, width: 1, height: txtLb1.frame.height)
        
        let right = CALayer()
        right.backgroundColor = UIColor.init(red: 79/255, green: 184/255, blue: 72/255, alpha: 1).cgColor
        right.frame = CGRect(x: txtLb1.frame.width - 1, y: 0, width: 1, height: txtLb1.frame.height)
//        
//        txtLb1.layer.addSublayer(top)
        txtLb1.layer.addSublayer(left)
        //txtLb1.layer.addSublayer(right)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

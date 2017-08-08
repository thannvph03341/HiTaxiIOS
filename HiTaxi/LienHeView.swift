//
//  LienHeView.swift
//  HiTaxi
//
//  Created by Nong Than on 2/8/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import UIKit

class LienHeView:UIView{
    
    lazy var collectionViewConfigThongBao:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //        cv.dataSource = self
        //        cv.delegate = self
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.isScrollEnabled = true
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    let textThongBao:UITextView = {
        let t = UITextView(frame: .zero)
        t.text = ""
        t.isSelectable = false
        t.isEditable = false
        t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        t.textAlignment = .justified
        return t
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setupView()
        ModelNguoiDung.NoiDung(idNoiDung: "idLienHe") { (data) in
            self.textThongBao.text = data
        }
    }
    
    func setupView() {
        
        addSubview(textThongBao)
        addConstraintsArray(format: "H:|-5-[v0]-5-|", viewAdd: textThongBao)
        addConstraintsArray(format: "V:|-10-[v0]-10-|", viewAdd: textThongBao)
        
        //        addSubview(collectionViewConfigThongBao)
        //        addConstraintsArray(format: "H:|[v0]|", viewAdd: collectionViewConfigThongBao)
        //        addConstraintsArray(format: "V:|[v0]|", viewAdd: collectionViewConfigThongBao)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

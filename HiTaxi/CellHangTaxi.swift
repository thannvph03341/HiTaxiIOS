//
//  CellHangTaxi.swift
//  HiTaxi
//
//  Created by Nong Than on 2/7/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import UIKit

class CellHangTaxi:UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var danhSachTaxi:[HangTaxiModel]?{
        didSet{
            collectionViewConfig.reloadData()
        }
    }
    
    lazy var collectionViewConfig:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.isScrollEnabled = false
        cv.backgroundColor = UIColor.clear
        return cv
    }()
    
    let txtRanhHang:UILabel = {
        let txt = UILabel(frame: .zero)
        txt.text = "Ranh Hang Taxi"
        txt.backgroundColor = UIColor.clear
        txt.font = UIFont.systemFont(ofSize: 18)
        return txt
    }()
    
    let idCell:String = "idCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
         collectionViewConfig.register(ItemCellHangTaxi.self, forCellWithReuseIdentifier: idCell)
        
        setupview()
        
        
        
    }
    
    func setupview(){
        addSubview(txtRanhHang)
        addSubview(collectionViewConfig)
        addConstraintsArray(format: "H:|[v0]|", viewAdd: collectionViewConfig)
         addConstraintsArray(format: "H:|[v0]|", viewAdd: txtRanhHang)
        addConstraintsArray(format: "V:|[v0]", viewAdd: txtRanhHang)
        addConstraintsArray(format: "V:[v0]|", viewAdd: collectionViewConfig)
        
        addConstraint(NSLayoutConstraint(item: collectionViewConfig, attribute: .top, relatedBy: .equal, toItem: txtRanhHang, attribute: .bottom, multiplier: 1, constant: 5))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: frame.width, height: (frame.height/3.4))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCell, for: indexPath) as! ItemCellHangTaxi
            cell.backgroundColor = UIColor.white
            cell.hangTaxi = danhSachTaxi?[indexPath.row]
//            cell.layer.borderColor = UIColor.black.cgColor
//            cell.layer.borderWidth = 0.5
//            cell.clipsToBounds = true
//            cell.layer.masksToBounds = true
            return cell
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

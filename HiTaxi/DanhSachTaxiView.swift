//
//  DanhSachTaxiView.swift
//  HiTaxi
//
//  Created by Nong Than on 2/7/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import UIKit

class DanhSachTaxiView:UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, LocHangTaxiTheoTinhThanh {
    
    
    var danhSachHangTaxi:[HangTaxiModel]?{
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
        cv.isScrollEnabled = true
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    let idCell:String = "idCell"
    
    let btnDanhSachTaxiTot:UIButton = {
        let btn = UIButton(frame: .zero)
            btn.setTitle("◻︎ \(NSLocalizedString("TaxiTot", comment: ""))", for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/18)
            return btn
    }()
    
    let btnDanhSachTaxiRe:UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setTitle("◻︎ \(NSLocalizedString("TaxiRe", comment: ""))", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/18)
        return btn
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        TrangChu.handerLochangTaxi = self
        collectionViewConfig.register(ItemCellHangTaxi.self, forCellWithReuseIdentifier: idCell)
        btnDanhSachTaxiTot.addTarget(self, action: #selector(LayTaxiTot), for: .touchUpInside)
        btnDanhSachTaxiRe.addTarget(self, action: #selector(LayTaxiRe), for: .touchUpInside)
        
        setupView()
        
        HangTaxiModel.LayDanhSachHangTaxi { (danhSachHangTaxi) in
            self.danhSachHangTaxi = danhSachHangTaxi
           // self.danhSachHangTaxi = SQLiteConfig().layDanhSachHangTaxiTheoTinhThanh(maTinhThanh: TrangChu.tinhThanhSelect!)
        }
    }
    
    
    func LayTaxiTot(){
        btnDanhSachTaxiRe.setTitle("◻︎ \(NSLocalizedString("TaxiRe", comment: ""))", for: .normal)
        btnDanhSachTaxiTot.setTitle("☑︎ \(NSLocalizedString("TaxiTot", comment: ""))", for: .normal)
        btnDanhSachTaxiRe.setTitleColor(UIColor.black, for: .normal)
        btnDanhSachTaxiTot.setTitleColor(UIColor.rgb(red: 110, green: 184, blue: 87), for: .normal)
        
        if btnDanhSachTaxiTot.tag == 0 {
            self.danhSachHangTaxi = SQLiteConfig().layDanhSachHangTaxiDanhGiaTotNhat(idTinhThanh: TrangChu.tinhThanhSelect != nil ? TrangChu.tinhThanhSelect!:"")
            btnDanhSachTaxiTot.tag = 1
            btnDanhSachTaxiRe.tag = 0
        } else {
            self.danhSachHangTaxi = SQLiteConfig().layDanhSachHangTaxiTheoTinhThanh(maTinhThanh: TrangChu.tinhThanhSelect != nil ? TrangChu.tinhThanhSelect!:"")
             btnDanhSachTaxiTot.tag = 0
             btnDanhSachTaxiRe.tag = 0
            btnDanhSachTaxiTot.setTitle("◻︎ \(NSLocalizedString("TaxiTot", comment: ""))", for: .normal)
            btnDanhSachTaxiTot.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    func LayTaxiRe(){
        btnDanhSachTaxiTot.setTitle("◻︎ \(NSLocalizedString("TaxiTot", comment: ""))", for: .normal)
        btnDanhSachTaxiRe.setTitle("☑︎ \(NSLocalizedString("TaxiRe", comment: ""))", for: .normal)
        btnDanhSachTaxiRe.setTitleColor(UIColor.rgb(red: 110, green: 184, blue: 87), for: .normal)
        btnDanhSachTaxiTot.setTitleColor(UIColor.black, for: .normal)
        if btnDanhSachTaxiRe.tag == 0 {
            self.danhSachHangTaxi = SQLiteConfig().layDanhSachHangTaxiGiaRe(idTinhThanh: TrangChu.tinhThanhSelect != nil ? TrangChu.tinhThanhSelect!:"")
            btnDanhSachTaxiRe.tag = 1
            btnDanhSachTaxiTot.tag = 0
        } else {
            self.danhSachHangTaxi = SQLiteConfig().layDanhSachHangTaxiTheoTinhThanh(maTinhThanh: TrangChu.tinhThanhSelect != nil ? TrangChu.tinhThanhSelect!:"")
            btnDanhSachTaxiRe.tag = 0
            btnDanhSachTaxiTot.tag = 0
            btnDanhSachTaxiRe.setTitle("◻︎ \(NSLocalizedString("TaxiRe", comment: ""))", for: .normal)
            btnDanhSachTaxiRe.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    func setupView(){
        addSubview(btnDanhSachTaxiTot)
        addSubview(btnDanhSachTaxiRe)
        addSubview(collectionViewConfig)
        
        
        addConstraintsArray(format: "H:|[v0(\(UIScreen.main.bounds.width/2.2))]", viewAdd: btnDanhSachTaxiTot)
        addConstraintsArray(format: "V:|-5-[v0]", viewAdd: btnDanhSachTaxiTot)
        
        addConstraintsArray(format: "H:[v0(\(UIScreen.main.bounds.width/2.2))]|", viewAdd: btnDanhSachTaxiRe)
        addConstraintsArray(format: "V:|-5-[v0]", viewAdd: btnDanhSachTaxiRe)
        
        addConstraintsArray(format: "H:|[v0]|", viewAdd: collectionViewConfig)
        addConstraintsArray(format: "V:[v0]|", viewAdd: collectionViewConfig)
        
        addConstraint(NSLayoutConstraint(item: collectionViewConfig, attribute: .top, relatedBy: .equal, toItem: btnDanhSachTaxiTot, attribute: .bottom, multiplier: 1, constant: 5))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let number = danhSachHangTaxi?.count {
            return number
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCell, for: indexPath) as! ItemCellHangTaxi
        cell.hangTaxi = danhSachHangTaxi?[indexPath.row]
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: (frame.width/1.2)/3.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func LocHangTaxiTheoTinhDelegate(modelTinhThanh: TinhThanhModel) {
        HangTaxiModel.LayDanhSachHangTaxiTheoTinhThanh(idTinhThanh: modelTinhThanh.maTinhThanh!) { (HangTaxi) in
            self.danhSachHangTaxi = HangTaxi
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

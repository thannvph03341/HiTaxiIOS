//
//  TaxiYeuThichView.swift
//  HiTaxi
//
//  Created by Nong Than on 2/8/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class TaxiYeuThichView: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, LocHangYeuThichDelegate {
    
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
    
    var danhSachTaxiYeuThich:[HangTaxiModel]?{
        didSet{
            collectionViewConfig.reloadData()
        }
    }
    
    let idCell:String = "idCell"
    
    public func setUpData(){
    
        if FBSDKAccessToken.current() != nil {
            //
            let parammeters = ["fields": "email,link,id,first_name,last_name, name,locale,gender,picture.type(large)"]
            FBSDKGraphRequest(graphPath: "me",parameters: parammeters).start { (connection, result, error) in
                if error != nil{
                    
                    print(error!)
                    
                    return
                    
                }
                
                let data:[String:AnyObject] = result as! [String : AnyObject]
                
                HangTaxiModel.LayDanhSachHangTaxiYeuThich(idNguoiDung: data["id"] as? String != nil ?  data["id"] as! String:"", { (danhSach) in
                    self.danhSachTaxiYeuThich = danhSach
                    for items in danhSach {
                        SQLiteConfig().themHangTaxiYeuThich(modelHangTaxi: items)
                    }
                    
                })
                
                //HangTaxiModel.DanhGiaTaxi(modelHangDanhGia: ["Manguoidung": data["id"] as? String != nil ?  data["id"] as! String:"", "Mahangtaxi": (self.hangTaxi?.Mahangtaxi)!, "Rate": rating])
                // self.viewTaiKhoan.setData(imgUser: AnhFacebook(idNguoiDung: data["id"] as? String != nil ?  data["id"] as! String:""), txtHoTen: data["name"] as? String != nil ? data["name"] as! String:"", txtSDT: "", txtDiaChi: "", txtEmail: "")
                
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        TrangChu.handerYeuThich = self
        backgroundColor = UIColor.white
        collectionViewConfig.register(ItemCellHangTaxi.self, forCellWithReuseIdentifier: idCell)
        setupView()
    }
    
    func setupView(){
        addSubview(collectionViewConfig)
        addConstraintsArray(format: "H:|[v0]|", viewAdd: collectionViewConfig)
        addConstraintsArray(format: "V:|[v0]|", viewAdd: collectionViewConfig)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let number = danhSachTaxiYeuThich?.count {
            return number
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCell, for: indexPath) as! ItemCellHangTaxi
        cell.backgroundColor = UIColor.clear
        cell.hangTaxi = danhSachTaxiYeuThich?[indexPath.row]
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
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func LocHangTaxiTheoTinhYeuThichDelegate(modelTinhThanh: TinhThanhModel) {
        self.danhSachTaxiYeuThich = SQLiteConfig().layDanhSachHangTaxiYeuThichTheoTinhThanh(maTinhThanh: modelTinhThanh.maTinhThanh!)
        collectionViewConfig.reloadData()
    }
    
}

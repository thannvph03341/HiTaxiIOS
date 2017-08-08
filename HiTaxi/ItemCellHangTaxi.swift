//
//  ItemCellHangTaxi.swift
//  HiTaxi
//
//  Created by Nong Than on 2/7/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import UIKit
import FloatRatingView
import FBSDKLoginKit

class ItemCellHangTaxi: UICollectionViewCell, FloatRatingViewDelegate{
    
    
    var hangTaxi:HangTaxiModel? {
        didSet{
            //Dinh Dang Tien
            let numberFormartter = NumberFormatter()
            numberFormartter.numberStyle = .decimal
       
            if let tenHang = hangTaxi?.Tenhangtaxi {
                txtTenHangTaxi.text = tenHang
            }
            
            if let soTienKmSau = hangTaxi?.Giakmsau {
                txtSoTienKmDauTaxi.text = "\(numberFormartter.string(from: soTienKmSau)!) đ/km"
            }
            
            if let rate = hangTaxi?.Rate {
                ratingTaxi.rating = Float(rate)
            }
            
            if let sdt1 = hangTaxi?.Sodienthoai {
                soDienThoai1 = sdt1
            }
            
            if let sdt2 = hangTaxi?.Sodienthoai2{
                soDienThoai2 = sdt2
            }
            
            if let Giamocua = hangTaxi?.Giamocua, let Giakmdau = hangTaxi?.Giakmdau, let Giakmsau = hangTaxi?.Giakmsau {
                chiTietGia = "Giá mở cửa: \(numberFormartter.string(from: Giamocua)!) đ/km\nGiá 25 đ/km đầu: \(numberFormartter.string(from: Giakmdau)!) đ/km\n Giá sau 25 Km: \(numberFormartter.string(from: Giakmsau)!) đ/km"
            }
        }
    }

   static var classTrangChu:TrangChu?
    
    var soDienThoai1:String = ""
    var soDienThoai2:String = ""
    var chiTietGia:String = ""
    
    
    
    
    let imgHangTaxi:UIImageView = {
        let img = UIImageView(frame: .zero)
        img.image = UIImage(named:"logoTaxi")
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        return img
    }()
    
    let imgLike:UIImageView = {
        let img = UIImageView(frame: .zero)
        img.image = UIImage(named:"favourite_green")
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.isUserInteractionEnabled = true
        return img
    }()
    
    
    let txtTenHangTaxi:UILabel = {
        let txt = UILabel(frame: .zero)
        txt.text = ""
        txt.backgroundColor = UIColor.clear
        txt.font = UIFont.systemFont(ofSize: 13)
        txt.numberOfLines = 2
//        txt.isScrollEnabled = false
//        txt.isEditable = false
//        txt.isSelectable = false
//        txt.showsVerticalScrollIndicator = false
//        txt.showsHorizontalScrollIndicator = false
//        txt.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        return txt
    }()
    
    let txtSoTienKmDauTaxi:UILabel = {
        let txt = UILabel(frame: .zero)
        txt.text = "0 đ/km"
        txt.backgroundColor = UIColor.clear
        txt.font = UIFont.systemFont(ofSize: 12)
        return txt
    }()
    
    let btnChiTietGia:UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setTitle(NSLocalizedString("Pricedetails", comment: ""), for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 8)
        btn.layer.borderColor = UIColor.rgb(red: 95, green: 193, blue: 81).cgColor
        btn.clipsToBounds = true
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 2
        btn.layer.masksToBounds = true
        btn.contentEdgeInsets =  UIEdgeInsetsMake(5, 5, 5, 5)
       // btn.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        return btn
    }()
    
    let btnGoiTaxi:UIButton = {
        let btn = UIButton(frame: .zero)
       // btn.setTitle("☏", for: .normal)
        
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setBackgroundImage(UIImage(named: "iconCall"), for: .normal)
        btn.clipsToBounds = true
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 3
        return btn
    }()
    
    lazy var ratingTaxi:FloatRatingView = {
        let v = FloatRatingView(frame: .zero)
        v.backgroundColor = UIColor.clear
        v.emptyImage = UIImage(named: "StarEmpty")
        v.fullImage = UIImage(named: "StarFull")
        v.maxRating = 5
        v.minRating = 0
        v.contentMode = .scaleToFill
        v.editable = true
        v.halfRatings = true
        v.floatRatings = true
        v.delegate = self
        return v
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupview()
        
        btnGoiTaxi.addTarget(self, action: #selector(GoiTaxi), for: .touchUpInside)
        btnChiTietGia.addTarget(self, action: #selector(XemChiTietGia), for: .touchUpInside)
        
        imgLike.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ThemHangVaoDanhSachYeuThich)))
        
        
    }
    
    func setupview(){
        addSubview(imgHangTaxi)
        addSubview(txtTenHangTaxi)
        addSubview(ratingTaxi)
        addSubview(txtSoTienKmDauTaxi)
        addSubview(btnChiTietGia)
        addSubview(btnGoiTaxi)
        addSubview(imgLike)
        addConstraintsArray(format: "H:|-5-[v0(\(frame.height/1.2))]-5-[v1]-5-[v2]-5-[v3]-5-|", viewAdd: imgHangTaxi, txtTenHangTaxi, ratingTaxi, btnGoiTaxi)
        addConstraintsArray(format: "V:[v0(\(frame.height/3))]", viewAdd: ratingTaxi)
        addConstraintsArray(format: "V:[v0(\(frame.height/1.2))]", viewAdd: imgHangTaxi)
        addConstraintsArray(format: "H:[v0]", viewAdd: txtSoTienKmDauTaxi)
        addConstraintsArray(format: "V:[v0]", viewAdd: txtSoTienKmDauTaxi)
        addConstraintsArray(format: "H:[v0]", viewAdd: btnChiTietGia)
        addConstraintsArray(format: "V:[v0]-6-|", viewAdd: btnChiTietGia)
        addConstraintsArray(format: "H:[v0(\(frame.height/3))]", viewAdd: imgLike)
        addConstraintsArray(format: "V:[v0(\(frame.height/3))]|", viewAdd: imgLike)
        
       addConstraint(NSLayoutConstraint(item: btnGoiTaxi, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.1, constant: 1))
        
        addConstraint(NSLayoutConstraint(item: imgHangTaxi, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: ratingTaxi, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.15, constant: 1))
        
        addConstraint(NSLayoutConstraint(item: btnGoiTaxi, attribute: .height, relatedBy: .equal, toItem: txtTenHangTaxi, attribute: .height, multiplier: 0.8, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: txtTenHangTaxi, attribute: .height, relatedBy: .equal, toItem: imgHangTaxi, attribute: .height, multiplier: 0.6, constant: 0))
        
         addConstraint(NSLayoutConstraint(item: txtSoTienKmDauTaxi, attribute: .top, relatedBy: .equal, toItem: txtTenHangTaxi, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: txtSoTienKmDauTaxi, attribute: .left, relatedBy: .equal, toItem: imgHangTaxi, attribute: .right, multiplier: 1, constant: 5))
        addConstraint(NSLayoutConstraint(item: txtSoTienKmDauTaxi, attribute: .right, relatedBy: .equal, toItem: ratingTaxi, attribute: .left, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: ratingTaxi, attribute: .centerY, relatedBy: .equal, toItem: btnGoiTaxi, attribute: .centerY, multiplier: 1, constant: 0))
         addConstraint(NSLayoutConstraint(item: btnChiTietGia, attribute: .centerX, relatedBy: .equal, toItem: ratingTaxi, attribute: .centerX, multiplier: 1, constant: -10))
        
        addConstraint(NSLayoutConstraint(item: btnChiTietGia, attribute: .height, relatedBy: .equal, toItem: btnGoiTaxi, attribute: .height, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: imgLike, attribute: .top, relatedBy: .equal, toItem: btnGoiTaxi, attribute: .bottom, multiplier: 1, constant: 3))
        addConstraint(NSLayoutConstraint(item: imgLike, attribute: .centerX, relatedBy: .equal, toItem: btnGoiTaxi, attribute: .centerX, multiplier: 1, constant: 0))
        
        imgHangTaxi.layer.cornerRadius = (frame.height/1.2)/2
        imgHangTaxi.layer.masksToBounds = true
        imgHangTaxi.clipsToBounds = true

        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        let lc = CALayer()
            lc.frame = CGRect(x: frame.height - 1, y: 0, width: frame.width, height: 1)
            lc.backgroundColor = UIColor.rgb(red: 95, green: 193, blue: 81).cgColor
        layer.addSublayer(lc)
    }
    
    func XemChiTietGia(){
        ItemCellHangTaxi.classTrangChu?.HienThiChiTietGia(hanTaxi: self.hangTaxi!)
    }
   
    func GoiTaxi(){
        ItemCellHangTaxi.classTrangChu?.goiHangTaxi(soDienThoai1: soDienThoai1, soDienThoai2: soDienThoai2)
    }
    
    /**
     Returns the rating value when touch events end
     */
    public func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Float) {
        let model = SQLiteConfig().thongTinNguoiDung()
        if model.Manguoidung != nil {
            HangTaxiModel.DanhGiaTaxi(modelHangDanhGia: ["Manguoidung": model.Manguoidung!, "Mahangtaxi": (self.hangTaxi?.Mahangtaxi)!, "Rate": rating])
        } else {
            ItemCellHangTaxi.classTrangChu?.ThongBao(noiDung: "Bạn cần đăng nhập để sử dụng chức năng này!")
        }

    }
    
    
    func ThemHangVaoDanhSachYeuThich(){
        
        let modelNguoiDung = SQLiteConfig().thongTinNguoiDung()
        
        if modelNguoiDung.Manguoidung != nil {
            HangTaxiModel.ThemTaxiYeuThich(modelHangYeuThic: ["Manguoidung": modelNguoiDung.Manguoidung!, "Mahangtaxi":(self.hangTaxi?.Mahangtaxi)!])
        } else {
            ItemCellHangTaxi.classTrangChu?.ThongBao(noiDung: "Bạn cần đăng nhập để sử dụng chức năng này!")
        }
      
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

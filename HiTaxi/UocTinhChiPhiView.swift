//
//  UocTinhChiPhiView.swift
//  HiTaxi
//
//  Created by Nong Than on 2/8/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import UIKit
import GooglePlaces
import DropDown

class UocTinhChiPhiView: UIViewController  {
 
    var placesClient: GMSPlacesClient!
    let locationManager = CLLocationManager()
   static var nguoiDungGoiTaxiAlo:HanderNgoiDungGoiTaxi?
    let listHangTaxi = DropDown()
    let listTinhThanh = DropDown()
    var dataFullLocationDiemDI: GMSPlace?
     var dataFullLocationDiemDen: GMSPlace?
  
    var diemDen:String = "_"
    var diemDi:String = "_"
    var indexTinhTien:Int = 0
    var khoangCach:Float = 0
    let numberFormart = NumberFormatter()
  
    var danhSachHangTaxi:[HangTaxiModel]?{
        didSet{
            
            listHangTaxi.dataSource.removeAll()
            if (danhSachHangTaxi?.count)! > 0{
                
                self.btnHangTaxi.setTitle(danhSachHangTaxi?[0].Tenhangtaxi, for: .normal)
                for items in (danhSachHangTaxi)!{
                    listHangTaxi.dataSource.append(items.Tenhangtaxi!)
                }
            } else {
                self.btnHangTaxi.setTitle("", for: .normal)
            }
            
        }
    }
    
    
    var danhTinhThanh:[TinhThanhModel]?{
        didSet{
            if self.danhTinhThanh?.count != 0 {
                self.btnTinhThanh.setTitle(danhTinhThanh?[0].tenTinhThanh, for: .normal)
                for items in (danhTinhThanh)!{
                    listTinhThanh.dataSource.append(items.tenTinhThanh!)
                }
            }
            
        }
    }
    
    let caiDatTimKiem:ViewPlaceAutocompile = {
        let v = ViewPlaceAutocompile(frame: .zero)
            v.backgroundColor = UIColor.white
        return v
    }()
    
    let txtLbDiemDi:UILabel = {
        let t = UILabel(frame: .zero)
        t.text = "Điểm đi: "
        t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        t.textColor = UIColor.black
        
        return t
    }()
    
    let txtLbDiemDen:UILabel = {
        let t = UILabel(frame: .zero)
        t.text = "Điểm đến: "
        t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        t.textColor = UIColor.black
        return t
    }()
    
    
    let btnDiemDi:UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setTitle("", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
        btn.clipsToBounds = true
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 3
        btn.titleLabel?.numberOfLines = 0
        btn.titleLabel?.lineBreakMode = .byTruncatingTail
        return btn
    }()
    
    let btnDiemDen:UIButton = {
        let btn = UIButton(frame: .zero)
            btn.setTitle("", for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
            btn.layer.borderColor = UIColor.black.cgColor
            btn.layer.borderWidth = 1
            btn.clipsToBounds = true
            btn.layer.masksToBounds = true
            btn.layer.cornerRadius = 3
            btn.titleLabel?.numberOfLines = 0
            btn.titleLabel?.lineBreakMode = .byTruncatingTail
        return btn
    }()
    
    let txtLbTinhThanh:UILabel = {
        let t = UILabel(frame: .zero)
        t.text = "Tỉnh Thành: "
        t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        t.textColor = UIColor.black
        return t
    }()
    
    let btnTinhThanh:UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setTitle("1", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
        btn.clipsToBounds = true
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 3
        btn.titleLabel?.numberOfLines = 0
        btn.titleLabel?.lineBreakMode = .byTruncatingTail
        return btn
    }()

    
    
    let txtLbHangTaxi:UILabel = {
        let t = UILabel(frame: .zero)
        t.text = "Hãng: "
        t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        t.textColor = UIColor.black
        return t
    }()
    
    let btnHangTaxi:UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setTitle("1", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
        btn.clipsToBounds = true
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 3
        btn.titleLabel?.numberOfLines = 0
        btn.titleLabel?.lineBreakMode = .byTruncatingTail
        return btn
    }()
    
    let duongKe:UIView = {
        let dk = UIView(frame: .zero)
        dk.backgroundColor = UIColor.rgb(red: 100, green: 196, blue: 80)
        return dk
    }()
    
    
    let txtLbUocTinh:UILabel = {
        let t = UILabel(frame: .zero)
        t.text = "Ước tính chi phí"
        t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/16)
        t.textColor = UIColor.black
        t.textAlignment = .center
        return t
    }()
    
    let txtlbKhoangCach:UILabel = {
        let t = UILabel(frame: .zero)
        t.text = "Khoảng Cách: "
        t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        t.textColor = UIColor.black
        t.textAlignment = .center
        return t
    }()
    
    let txtKhoangCach:UILabel = {
        let t = UILabel(frame: .zero)
        t.text = "0 km"
        t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        t.textColor = UIColor.black
        t.textAlignment = .right
        return t
    }()
    
    
    let txtlbThoiGian:UILabel = {
        let t = UILabel(frame: .zero)
        t.text = "Thời Gian: "
        t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        t.textColor = UIColor.black
        t.textAlignment = .center
        return t
    }()
    
    let txtThoiGian:UILabel = {
        let t = UILabel(frame: .zero)
        t.text = "0 phút"
        t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        t.textColor = UIColor.black
        t.textAlignment = .right
        return t
    }()
    
    let txtlbChiPhi:UILabel = {
        let t = UILabel(frame: .zero)
        t.text = "Khoảng Chi Phi: "
        t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        t.textColor = UIColor.black
        t.textAlignment = .center
        return t
    }()
    
    let txtChiPhi:UILabel = {
        let t = UILabel(frame: .zero)
        t.text = "0 đ"
        t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        t.textColor = UIColor.black
        t.textAlignment = .right
        return t
    }()
    
    
    let btnGoiTaxi:UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setTitle("CALL Taxi!", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        btn.layer.borderColor = UIColor.rgb(red: 110, green: 184, blue: 87).cgColor
        btn.layer.borderWidth = 1
        btn.clipsToBounds = true
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 3
        btn.titleLabel?.numberOfLines = 0
        btn.backgroundColor = UIColor.rgb(red: 110, green: 184, blue: 87)
        btn.titleLabel?.lineBreakMode = .byTruncatingTail
        return btn
    }()
    
    let btnSendAddressInMap:UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setTitle(NSLocalizedString("btnSendDataMap", comment: ""), for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        btn.layer.borderColor = UIColor.rgb(red: 110, green: 184, blue: 87).cgColor
        btn.layer.borderWidth = 1
        btn.clipsToBounds = true
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 3
        btn.titleLabel?.numberOfLines = 0
        btn.backgroundColor = UIColor.rgb(red: 110, green: 184, blue: 87)
        btn.titleLabel?.lineBreakMode = .byTruncatingTail
        return btn
    }()
    
    override func viewDidLoad() {
       super.viewDidLoad()
          numberFormart.numberStyle = .decimal
        locationManager.requestWhenInUseAuthorization()
        // For getting the user permission to use location service always
        locationManager.requestAlwaysAuthorization()
        placesClient = GMSPlacesClient.shared()
        view.backgroundColor = UIColor.white
        
       
        btnHangTaxi.addTarget(self, action: #selector(HienThiDanhSachTaxi), for: .touchUpInside)
        btnTinhThanh.addTarget(self, action: #selector(HienThingTinTinhThanh), for: .touchUpInside)
        btnSendAddressInMap.addTarget(self, action: #selector(GuiDiaChiDenMap), for: .touchUpInside)
        
        setupView()
        
        //Lay tao do nguoi dung
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            if let placeLikelihoodList = placeLikelihoodList {
                for likelihood in placeLikelihoodList.likelihoods {
                    let place = likelihood.place
                        self.btnDiemDi.setTitle(place.formattedAddress?.components(separatedBy: ",")[0], for: .normal)
                     self.diemDi = (place.formattedAddress?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!
//                    print("Current Place name \(place.name) at likelihood \(likelihood.likelihood)")
//                    print("Current Place address \()")
//                    print("Current Place attributions \(place.attributions)")
//                    print("Current PlaceID \(place.placeID)")
                }
            }
        })
        
        TinhThanhModel.LayCacTinhThanh { (tinhThanh) in
            self.danhTinhThanh = tinhThanh
        }
        
        //setDataShow list taxi
        HangTaxiModel.LayDanhSachHangTaxi { (danhSachTaxi) in
           self.danhSachHangTaxi = danhSachTaxi
        }
        
        listTinhThanh.anchorView = btnTinhThanh
        listHangTaxi.anchorView = btnHangTaxi
        
        
        listTinhThanh.selectionAction = {{(index:Int, items:String)in
            
                self.btnTinhThanh.setTitle(items, for: .normal)
            HangTaxiModel.LayDanhSachHangTaxiTheoTinhThanh(idTinhThanh: self.danhTinhThanh?[index].maTinhThanh != nil ? (self.danhTinhThanh?[index].maTinhThanh)!:"_", { (hangTaxi) in
                    self.danhSachHangTaxi = hangTaxi
                })
            }}()
        
        
        listHangTaxi.selectionAction = {{(index: Int, item: String) in
                self.btnHangTaxi.setTitle(item, for: .normal)
               // print("Selected item: \(self.danhSachHangTaxi?[index].Tenhangtaxi) at index: \(index)")
            self.indexTinhTien = index
            
            self.txtChiPhi.text = "\(self.danhSachHangTaxi?[index].Giakmsau != nil ? self.numberFormart.string(from: Float((self.danhSachHangTaxi?[index].Giakmsau)!) * self.khoangCach as NSNumber)!:"0") đ"
            }
        }()
        
        /// an ban phim
        self.hideKeyboardWhenTappedAround()
    }

    
    
    func setupView(){
        
   
    
        btnDiemDi.addTarget(self, action: #selector(CaiDiemDi), for: .touchUpInside)
        btnDiemDen.addTarget(self, action: #selector(CaiDiemDen), for: .touchUpInside)
        btnGoiTaxi.addTarget(self, action: #selector(GoiTaxi), for: .touchUpInside)
        
        view.addSubview(txtLbDiemDi)
        view.addSubview(btnDiemDi)
        view.addSubview(txtLbDiemDen)
        view.addSubview(btnDiemDen)
        view.addSubview(txtLbHangTaxi)
        
        view.addSubview(txtLbTinhThanh)
        view.addSubview(btnTinhThanh)
        
        view.addSubview(btnHangTaxi)
        view.addSubview(duongKe)
        view.addSubview(txtLbUocTinh)
        view.addSubview(txtlbKhoangCach)
        view.addSubview(txtKhoangCach)
        view.addSubview(txtlbThoiGian)
        view.addSubview(txtThoiGian)
        
        view.addSubview(txtlbChiPhi)
        view.addSubview(txtChiPhi)
        view.addSubview(btnGoiTaxi)
        view.addSubview(btnSendAddressInMap)
        
        view.addConstraintsArray(format: "H:|-5-[v0]", viewAdd: txtLbDiemDi)
        view.addConstraintsArray(format: "V:[v0]", viewAdd: txtLbDiemDi)
        
        view.addConstraintsArray(format: "H:|-5-[v0]", viewAdd: txtLbDiemDen)
        view.addConstraintsArray(format: "V:[v0]", viewAdd: txtLbDiemDen)
        
        view.addConstraintsArray(format: "H:[v0]-5-|", viewAdd: btnDiemDi)
        view.addConstraintsArray(format: "V:|-5-[v0]", viewAdd: btnDiemDi)
        
        view.addConstraintsArray(format: "H:[v0]", viewAdd: btnDiemDen)
        view.addConstraintsArray(format: "V:[v0]", viewAdd: btnDiemDen)
        
        view.addConstraintsArray(format: "H:|-5-[v0]", viewAdd: txtLbTinhThanh)
        view.addConstraintsArray(format: "V:[v0]", viewAdd: txtLbTinhThanh)
        view.addConstraintsArray(format: "H:[v0]-5-|", viewAdd: btnTinhThanh)
        view.addConstraintsArray(format: "V:[v0]", viewAdd: btnTinhThanh)
        
        
        view.addConstraintsArray(format: "H:|-5-[v0]", viewAdd: txtLbHangTaxi)
        view.addConstraintsArray(format: "V:[v0]", viewAdd: txtLbHangTaxi)
        
        view.addConstraintsArray(format: "H:[v0]-5-|", viewAdd: btnHangTaxi)
        view.addConstraintsArray(format: "V:[v0]", viewAdd: btnHangTaxi)
        
        view.addConstraintsArray(format: "H:|[v0]|", viewAdd: duongKe)
        view.addConstraintsArray(format: "V:[v0(1)]", viewAdd: duongKe)
        
        view.addConstraintsArray(format: "H:|[v0]|", viewAdd: txtLbUocTinh)
        view.addConstraintsArray(format: "V:[v0]", viewAdd: txtLbUocTinh)
        
        view.addConstraintsArray(format: "H:|[v0]", viewAdd: txtlbKhoangCach)
        view.addConstraintsArray(format: "V:[v0]", viewAdd: txtlbKhoangCach)
        
        view.addConstraintsArray(format: "H:[v0]", viewAdd: txtKhoangCach)
        view.addConstraintsArray(format: "V:[v0]", viewAdd: txtKhoangCach)
        
        view.addConstraintsArray(format: "H:|[v0]", viewAdd: txtlbThoiGian)
        view.addConstraintsArray(format: "V:[v0]", viewAdd: txtlbThoiGian)
        
        view.addConstraintsArray(format: "H:[v0]", viewAdd: txtThoiGian)
        view.addConstraintsArray(format: "V:[v0]", viewAdd: txtThoiGian)
        
        view.addConstraintsArray(format: "H:|[v0]", viewAdd: txtlbChiPhi)
        view.addConstraintsArray(format: "V:[v0]", viewAdd: txtlbChiPhi)
        
        view.addConstraintsArray(format: "H:[v0]", viewAdd: txtChiPhi)
        view.addConstraintsArray(format: "V:[v0]", viewAdd: txtChiPhi)
        
        view.addConstraintsArray(format: "H:|-5-[v0]-5-|", viewAdd: btnGoiTaxi)
        view.addConstraintsArray(format: "V:[v0]-6-[v1]", viewAdd: btnGoiTaxi, btnSendAddressInMap)
        view.addConstraintsArray(format: "H:|-5-[v0]-5-|", viewAdd: btnSendAddressInMap)
        
        
        //txtLbDiemDi
        view.addConstraint(NSLayoutConstraint(item: txtLbDiemDi, attribute: .centerY, relatedBy: .equal, toItem: btnDiemDi, attribute: .centerY, multiplier: 1, constant: 0))
        //txtLbDiemDen
        view.addConstraint(NSLayoutConstraint(item: txtLbDiemDen, attribute: .centerY, relatedBy: .equal, toItem: btnDiemDen, attribute: .centerY, multiplier: 1, constant: 0))
        
        //btnDiemDi
        view.addConstraint(NSLayoutConstraint(item: btnDiemDi, attribute: .left, relatedBy: .equal, toItem: txtLbDiemDi, attribute: .right, multiplier: 1, constant: 5))
        
        //btnDiemDen
        view.addConstraint(NSLayoutConstraint(item: btnDiemDen, attribute: .left, relatedBy: .equal, toItem: txtLbDiemDen, attribute: .right, multiplier: 1, constant: 5))
        view.addConstraint(NSLayoutConstraint(item: btnDiemDen, attribute: .right, relatedBy: .equal, toItem: btnDiemDi, attribute: .right, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: btnDiemDen, attribute: .top, relatedBy: .equal, toItem: btnDiemDi, attribute: .bottom, multiplier: 1, constant: 5))
        
        view.addConstraint(NSLayoutConstraint(item: btnDiemDi, attribute: .width, relatedBy: .equal, toItem: btnDiemDen, attribute: .width, multiplier: 1, constant: 0))
        
        //Lb TinhThanh
        view.addConstraint(NSLayoutConstraint(item: txtLbTinhThanh, attribute: .centerY, relatedBy: .equal, toItem: btnTinhThanh, attribute: .centerY, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: txtLbTinhThanh, attribute: .width, relatedBy: .equal, toItem: txtLbDiemDen, attribute: .width, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: btnTinhThanh, attribute: .top, relatedBy: .equal, toItem: btnDiemDen, attribute: .bottom, multiplier: 1, constant: 5))
        view.addConstraint(NSLayoutConstraint(item: btnTinhThanh, attribute: .left, relatedBy: .equal, toItem: txtLbTinhThanh, attribute: .right, multiplier: 1, constant: 5))
        
        //Lb hang taxi
        view.addConstraint(NSLayoutConstraint(item: txtLbHangTaxi, attribute: .centerY, relatedBy: .equal, toItem: btnHangTaxi, attribute: .centerY, multiplier: 1, constant: 0))
       view.addConstraint(NSLayoutConstraint(item: txtLbHangTaxi, attribute: .width, relatedBy: .equal, toItem: txtLbDiemDen, attribute: .width, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: btnHangTaxi, attribute: .top, relatedBy: .equal, toItem: btnTinhThanh, attribute: .bottom, multiplier: 1, constant: 5))
        view.addConstraint(NSLayoutConstraint(item: btnHangTaxi, attribute: .left, relatedBy: .equal, toItem: txtLbHangTaxi, attribute: .right, multiplier: 1, constant: 5))
        
        view.addConstraint(NSLayoutConstraint(item: duongKe, attribute: .top, relatedBy: .equal, toItem: btnHangTaxi, attribute: .bottom, multiplier: 1, constant: 5))
        
        view.addConstraint(NSLayoutConstraint(item: txtLbUocTinh, attribute: .top, relatedBy: .equal, toItem: duongKe, attribute: .top, multiplier: 1, constant: 10))
        
        ///
        view.addConstraint(NSLayoutConstraint(item: txtlbKhoangCach, attribute: .top, relatedBy: .equal, toItem: txtLbUocTinh, attribute: .bottom, multiplier: 1, constant: 0))
        //
        view.addConstraint(NSLayoutConstraint(item: txtKhoangCach, attribute: .top, relatedBy: .equal, toItem: txtLbUocTinh, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: txtKhoangCach, attribute: .left, relatedBy: .equal, toItem: txtlbKhoangCach, attribute: .right, multiplier: 1, constant: 0))
        //
        
        view.addConstraint(NSLayoutConstraint(item: txtlbThoiGian, attribute: .top, relatedBy: .equal, toItem: txtlbKhoangCach, attribute: .bottom, multiplier: 1, constant: 0))
        //
         view.addConstraint(NSLayoutConstraint(item: txtThoiGian, attribute: .left, relatedBy: .equal, toItem: txtlbKhoangCach, attribute: .right, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: txtThoiGian, attribute: .top, relatedBy: .equal, toItem: txtKhoangCach, attribute: .bottom, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: txtlbChiPhi, attribute: .top, relatedBy: .equal, toItem: txtlbThoiGian, attribute: .bottom, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: txtChiPhi, attribute: .top, relatedBy: .equal, toItem: txtThoiGian, attribute: .bottom, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: txtChiPhi, attribute: .left, relatedBy: .equal, toItem: txtlbChiPhi, attribute: .right, multiplier: 1, constant: 0))
        
          view.addConstraint(NSLayoutConstraint(item: btnGoiTaxi, attribute: .top, relatedBy: .equal, toItem: txtChiPhi, attribute: .bottom, multiplier: 1, constant: 10))
        
    }
    
    func HienThingTinTinhThanh(){
        listTinhThanh.show()
    }
    
    func HienThiDanhSachTaxi(){
        listHangTaxi.show()
    }
    
    func GuiDiaChiDenMap(){
        
        if dataFullLocationDiemDI != nil && dataFullLocationDiemDen != nil {
            let url = "http://maps.apple.com/maps?saddr=\((dataFullLocationDiemDI?.coordinate.latitude)!),\((dataFullLocationDiemDI?.coordinate.longitude)!)&daddr=\((dataFullLocationDiemDen?.coordinate.latitude)!),\((dataFullLocationDiemDen?.coordinate.longitude)!)"
            UIApplication.shared.openURL(URL(string:url)!)
        }
        
        
        
        
        
        //comgooglemaps://?saddr=Google+Inc,+8th+Avenue,+New+York,+NY&daddr=John+F.+Kennedy+International+Airport,+Van+Wyck+Expressway,+Jamaica,+New+York&directionsmode=transit

       // UIApplication.shared.openURL(URL(string:"https://www.google.com/maps/@42.585444,13.007813,6z")!)
//        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
//            UIApplication.shared.openURL(URL(string:
//                "comgooglemaps://?q=Google+Japan,+Minato,+Tokyo,+Japan&center=35.660888,139.73073&zoom=15&views=transit")!)
//        } else {
//            print("Can't use comgooglemaps://");
//        }
    }
    
    
    
    func CaiDiemDi(){
        
         HienThiTimKiem()
        
        UIButton.animate(withDuration: 0.1, animations: {
            self.btnDiemDi.backgroundColor = UIColor.green
            self.btnDiemDi.setTitleColor(UIColor.white, for: .normal)
        }) { (Bool) in
             self.btnDiemDi.backgroundColor = UIColor.clear
            self.btnDiemDi.setTitleColor(UIColor.black, for: .normal)
        }
        ViewPlaceAutocompile.indexTimKiem = 0
       caiDatTimKiem.alpha = 1
    }
    
    func CaiDiemDen(){
        
         HienThiTimKiem()
        
        UIButton.animate(withDuration: 0.1, animations: {
            self.btnDiemDen.backgroundColor = UIColor.green
            self.btnDiemDen.setTitleColor(UIColor.white, for: .normal)
        }) { (Bool) in
            self.btnDiemDen.backgroundColor = UIColor.clear
            self.btnDiemDen.setTitleColor(UIColor.black, for: .normal)
        }
        ViewPlaceAutocompile.indexTimKiem = 1
       caiDatTimKiem.alpha = 1
    }
    
    func HienThiTimKiem(){
          caiDatTimKiem.alpha = 0
        
        if let window = UIApplication.shared.keyWindow {
            window.backgroundColor = UIColor.white
            window.addSubview(caiDatTimKiem)
            window.addConstraintsArray(format: "H:|[v0]|", viewAdd: caiDatTimKiem)
            window.addConstraintsArray(format: "V:|[v0]|", viewAdd: caiDatTimKiem)
            ViewPlaceAutocompile.classUocTinhChiPhi = self
        }
        
    }
  
    func showData(indexTimKiem:Int, diaChi:String, dataFull: GMSPlace)  {
 
        
        
        let name = diaChi.components(separatedBy: ",")
        switch indexTimKiem {
        case 0:
            self.dataFullLocationDiemDI = dataFull
            self.btnDiemDi.setTitle(name[0], for: .normal)
            diemDi = diaChi.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
            break
        case 1:
            self.dataFullLocationDiemDen = dataFull
            self.btnDiemDen.setTitle(name[0], for: .normal)
            diemDen = diaChi.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
            break
        default:
            break
        }
        
        TinhTien(diemBatDau: diemDi, diemKetThuc: diemDen)
      
    }
    
    func GoiTaxi(){
        //TrangChu.GoiSoDienThoai(phoneNumber: "tel://" + self.danhSachHangTaxi?[].components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
        UocTinhChiPhiView.nguoiDungGoiTaxiAlo?.GoiTaxiHander(soDienThoai1: (self.danhSachHangTaxi?[indexTinhTien].Sodienthoai)!, soDienThoai2: (self.danhSachHangTaxi?[indexTinhTien].Sodienthoai2)!)
    }
    
    
    
    func TinhTien(diemBatDau:String, diemKetThuc:String) {
        
        
        
        URLSession.shared.dataTask(with: URL(string: linkLayKhoangCach(diemBatDau: diemBatDau, diemKetThuc: diemKetThuc))!) { (data, response, error) in
            do{
                let jsonKhoangCach = try(JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                let jsonStatus = jsonKhoangCach as! NSDictionary
                
                var listTinhTien = [ModelTinhTien]()
               
                
                
                if jsonStatus["status"] as! String == "OK" {
                    let jsonRow = jsonStatus["rows"] as! [NSDictionary]
                    let jsonElements = jsonRow[0]["elements"] as! NSArray
                    let datas = jsonElements[0] as! NSDictionary
                    if datas["status"] as! String == "OK" {
                        let modelTinhTien = ModelTinhTien()
                        let distance = datas["distance"] as! NSDictionary
                        let duration = datas["duration"] as! NSDictionary
                        
                        if let txt = distance["text"] as? String {
                            modelTinhTien.text = txt
                           
                        } else {
                            modelTinhTien.text = ""
                        }
                        
                        if let v = distance["value"] as? NSNumber {
                            modelTinhTien.value = v
                            DispatchQueue.main.sync {
                                self.txtKhoangCach.text = "\(round(Float(v) * 0.001)) km"
                                self.khoangCach = round(Float(v) * 0.001)
                                self.txtChiPhi.text = "\(self.danhSachHangTaxi?[self.indexTinhTien].Giakmsau != nil ? self.numberFormart.string(from: Float((self.danhSachHangTaxi?[self.indexTinhTien].Giakmsau)!) * Float(v) as NSNumber)!:"0") đ"
                            }
    
                        } else {
                            modelTinhTien.value = 0
                        }
                        
                        listTinhTien.append(modelTinhTien)
                        
                        let model1 = ModelTinhTien()
                        
                        if let t = duration["text"] as? String {
                            model1.text = t
                            DispatchQueue.main.async {
                                 self.txtThoiGian.text = t
                            }
                           
                        } else {
                            model1.text = ""
                        }
                        
                        if let vs = duration["value"] as? NSNumber {
                            model1.value = vs
                        } else {
                            model1.value = 0
                        }
                        listTinhTien.append(model1)
                        
                    }
                    
                    
                }
                

            }catch let errorJson{
                print("TinhTien",errorJson)
            }
        }.resume()
        
    }
    
    
}


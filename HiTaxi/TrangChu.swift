//
//  TrangChu.swift
//  HiTaxi
//
//  Created by Nong Than on 2/3/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import UIKit
import PhoneNumberKit
import FBSDKLoginKit
import DropDown
import MarqueeLabel
import Google
import GoogleSignIn


class TrangChu: UICollectionViewController,  UICollectionViewDelegateFlowLayout, HanderNgoiDungGoiTaxi,  GIDSignInDelegate, GIDSignInUIDelegate {
    
    
    
    let phoneNumberKit = PhoneNumberKit()
     let listTinhThanh = DropDown()
    static var tinhThanhSelect:String?
    
    
    
    static var handerLochangTaxi:LocHangTaxiTheoTinhThanh?
    static var handerYeuThich:LocHangYeuThichDelegate?
    
    var danhSachTinhThanh:[TinhThanhModel]?{
        didSet{

            for items in (danhSachTinhThanh)!{
                
                listTinhThanh.dataSource.append(items.tenTinhThanh!)
                if items.maTinhThanh == "danang" {
                     self.btnHangTaxi.setTitle(items.tenTinhThanh, for: .normal)
                    TrangChu.handerLochangTaxi?.LocHangTaxiTheoTinhDelegate(modelTinhThanh: items)
                }
            }

        }
    }
    
    let imgButtonMenu:UIImageView = {
        let img = UIImageView(frame: .zero)
        img.image = UIImage(named: "menuList")?.withRenderingMode(.alwaysTemplate)
        img.isUserInteractionEnabled = true
        return img
    }()
    
    var viewSellect:UIView?
    
//    lazy var uicollectionView:UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.showsVerticalScrollIndicator = false
//        cv.showsHorizontalScrollIndicator = false
//        cv.dataSource = self
//        cv.delegate = self
//        return cv
//    }()
    
    
    let textTitle:UILabel = {
        let t = UILabel(frame: .zero)
        t.font = UIFont.systemFont(ofSize: 16)
        t.text = NSLocalizedString("TrangChu", comment: "")
        t.backgroundColor = UIColor.clear
        t.textColor = UIColor.white
        return t
    }()
    
    let viewBar:UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let viewDanhSachTaxi:DanhSachTaxiView = {
        let v = DanhSachTaxiView(frame: .zero)
        return v
    }()
    
    let viewThongBao:ThongBaoView = {
        let v = ThongBaoView(frame: .zero)
        return v
    }()
    
    let viewTaxiYeuThich:TaxiYeuThichView = {
        let v = TaxiYeuThichView(frame: .zero)
        return v
    }()
    
    let viewTaiKhoan:TaiKhoanView={
        let a = TaiKhoanView(frame: .zero)
        return a
    }()
    
    let viewGioiThieu:GioiThieuView={
        let a = GioiThieuView(frame: .zero)
        return a
    }()
    
    let viewCaiDat:CaiDatView={
        let a = CaiDatView(frame: .zero)
        return a
    }()
    
    let viewLienHe:LienHeView={
        let a = LienHeView(frame: .zero)
        return a
    }()

     let viewUocTinhChiPhiView = UocTinhChiPhiView()
    
    var textThongBao:MarqueeLabel = {
        var t = MarqueeLabel(frame:.zero)
            t.backgroundColor = UIColor.black
            t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/18)
            t.textAlignment = .center
            t.text = "Chất lượng được đánh giá theo người bình chọn "
            t.backgroundColor = UIColor.white
        
            return t
    }()
    
    let btnHangTaxi:UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setTitle(" ", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 1
        btn.clipsToBounds = true
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 3
        btn.titleLabel?.numberOfLines = 0
        btn.alpha = 0
        btn.titleLabel?.lineBreakMode = .byTruncatingTail
        return btn
    }()

    
//    let viewUocTinhChiPhiView:UocTinhChiPhiView = {
//        let v = UocTinhChiPhiView(frame: .zero)
//        return v
//    }()
    
    let naviMenu:NavigationMenu = NavigationMenu()
    let idCell:String = "idCell"
    let idCell1:String = "idCell1"
    let idCell2:String = "idCell2"
 
    
    
    override func viewDidLoad() {
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        
        collectionView?.backgroundColor = UIColor.white
        
        //UIApplication.shared.keyWindow
        navigationItem.titleView = viewBar
        
      //  viewBar.backgroundColor = UIColor.blue
        viewBar.addSubview(btnHangTaxi)
        viewBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
        viewBar.addSubview(imgButtonMenu)
        viewBar.addSubview(textTitle)
        imgButtonMenu.tintColor = UIColor.white
        imgButtonMenu.image = UIImage(named: "menuList")?.withRenderingMode(.alwaysTemplate)
        viewBar.addConstraintsArray(format: "H:|[v0(50)]", viewAdd: imgButtonMenu)
        viewBar.addConstraintsArray(format: "V:|[v0]|", viewAdd: imgButtonMenu)
        viewBar.addConstraintsArray(format: "H:[v0]", viewAdd: textTitle)
        viewBar.addConstraintsArray(format: "V:|[v0]|", viewAdd: textTitle)
        viewBar.addConstraint(NSLayoutConstraint(item: textTitle, attribute:
            .left, relatedBy: .equal, toItem: imgButtonMenu, attribute: .right, multiplier: 1, constant: 0))
       
        viewBar.addConstraintsArray(format: "H:[v0]|", viewAdd: btnHangTaxi)
        viewBar.addConstraintsArray(format: "V:|-3-[v0]-3-|", viewAdd: btnHangTaxi)
        
        viewBar.addConstraint(NSLayoutConstraint(item: btnHangTaxi, attribute: .width, relatedBy: .equal, toItem: viewBar, attribute: .width, multiplier: 0.5, constant: 0))
        
        imgButtonMenu.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ShowMenu)))
        btnHangTaxi.addTarget(self, action: #selector(ShowHangTaxi), for: .touchUpInside)
        collectionView?.alpha = 0
        //view.addSubview(uicollectionView)
        view.addSubview(textThongBao)
        
        //view.addConstraintsArray(format: "H:|[v0]|", viewAdd: uicollectionView)
       // view.addConstraintsArray(format: "V:|[v0]", viewAdd: uicollectionView)
        
        view.addConstraintsArray(format: "H:|[v0]|", viewAdd: textThongBao)
        view.addConstraintsArray(format: "V:[v0(\(UIScreen.main.bounds.width/8))]|", viewAdd: textThongBao)

       // view.addConstraint(NSLayoutConstraint(item: uicollectionView, attribute: .bottom, relatedBy: .equal, toItem: textThongBao, attribute: .top, multiplier: 1, constant: 0))
       // textThongBao = MarqueeLabel.init(frame: textThongBao.frame, rate: 2, fadeLength: 1).s
        
        collectionView?.register(CellHangTaxi.self, forCellWithReuseIdentifier: idCell)
        collectionView?.register(CellHangTaxi.self, forCellWithReuseIdentifier: idCell1)
        collectionView?.register(CellHangTaxi.self, forCellWithReuseIdentifier: idCell2)
        naviMenu.classTrangChu = self
        ItemCellHangTaxi.classTrangChu = self
        
        UocTinhChiPhiView.nguoiDungGoiTaxiAlo = self
        HangTaxiModel.classTrangChu = self
        TaiKhoanView.trangChu = self
        let modelNguoiDung = SQLiteConfig().thongTinNguoiDung()
        if let _ = modelNguoiDung.Manguoidung{
            self.viewTaiKhoan.setData(imgUser: modelNguoiDung.Password!, txtHoTen: modelNguoiDung.Tennguoidung!, txtSDT: modelNguoiDung.Sodienthoai!, txtDiaChi: "", txtEmail: modelNguoiDung.Email!)
            NavigationCellUser.imageUser.LoadImageUrlString(urlString: modelNguoiDung.Password!)
            NavigationCellUser.txtTen.text = modelNguoiDung.Tennguoidung!
            
        }
        
        
        
        TinhThanhModel.LayCacTinhThanh { (tinhThanh) in
            self.danhSachTinhThanh = tinhThanh
            if tinhThanh.count != 0 {
                TrangChu.tinhThanhSelect = tinhThanh[0].maTinhThanh
            }
        }
        listTinhThanh.anchorView = btnHangTaxi
        listTinhThanh.selectionAction = {{(index: Int, item: String) in
            self.btnHangTaxi.setTitle(item, for: .normal)
            TrangChu.tinhThanhSelect = self.danhSachTinhThanh?[index].maTinhThanh
            TrangChu.handerLochangTaxi?.LocHangTaxiTheoTinhDelegate(modelTinhThanh: (self.danhSachTinhThanh?[index])!)
            TrangChu.handerYeuThich?.LocHangTaxiTheoTinhYeuThichDelegate(modelTinhThanh: (self.danhSachTinhThanh?[index])!)
           
            }
        }()
        //set item menu 
        setViewOnclickMenu(index: 2)
        
        CaiDatView.trangChu = self
        
    }
   
    func ShowMenu(){
        naviMenu.setupMenu()
    }
    
    
    func ShowHangTaxi(){
        listTinhThanh.show()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCell, for: indexPath) as! CellHangTaxi
            cell.backgroundColor = UIColor.white
            HangTaxiModel.LayDanhSachHangTaxiTotNhat({ (hangTot) in
                cell.danhSachTaxi = hangTot
            })
            cell.txtRanhHang.text = "Taxi Tốt nhất"
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCell1, for: indexPath) as! CellHangTaxi
            HangTaxiModel.LayDanhSachHangTaxiReNhat({ (reNhat) in
                cell.danhSachTaxi = reNhat
                
            })
            cell.backgroundColor = UIColor.white
             cell.txtRanhHang.text = "Taxi Rẻ nhất"
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCell2, for: indexPath) as! CellHangTaxi
            HangTaxiModel.LayDanhSachHangTaxiTeNhat({ (teNhat) in
                cell.danhSachTaxi = teNhat
            })

             cell.txtRanhHang.text = "Taxi hạn chế"
            cell.backgroundColor = UIColor.white
            return cell
        }
     
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        
        return CGSize(width: view.frame.width, height: view.frame.width/1.2)
    }
    
    func setViewOnclickMenu(index:Int){
        switch index {
        case 1:
            UIView.animate(withDuration: 0.3) {
                self.viewDanhSachTaxi.alpha = 0
                self.viewThongBao.alpha = 0
                self.viewTaxiYeuThich.alpha = 0
                self.viewUocTinhChiPhiView.view.alpha = 0
                self.viewTaiKhoan.alpha = 0
                self.viewGioiThieu.alpha = 0
                self.viewCaiDat.alpha = 0
                self.viewLienHe.alpha = 0
                self.btnHangTaxi.alpha = 0
            }
            break
        case 2:
            setupViewMenu(views: viewDanhSachTaxi)
            self.btnHangTaxi.alpha = 1
            break
        case 3:
           
            setupViewMenu(views: viewThongBao)
            self.btnHangTaxi.alpha = 0
            break
        case 4:
            setupViewMenu(views: viewTaxiYeuThich)
            viewTaxiYeuThich.setUpData()
            self.btnHangTaxi.alpha = 1
            break
        case 5:
            setupViewMenu(views: viewUocTinhChiPhiView.view)
            self.btnHangTaxi.alpha = 0
            break
        case 6:
            setupViewMenu(views: viewTaiKhoan)
            self.btnHangTaxi.alpha = 0
            break
            
        case 7:
            setupViewMenu(views: viewCaiDat)
            self.btnHangTaxi.alpha = 0
            break
        case 8:
            setupViewMenu(views: viewGioiThieu)
            self.btnHangTaxi.alpha = 0
            break
        case 9:
            setupViewMenu(views: viewLienHe)
            self.btnHangTaxi.alpha = 0
            break
        default:
             setupViewMenu(views: viewTaiKhoan)
            self.btnHangTaxi.alpha = 0
            
        }
    }
    
    func goiHangTaxi(soDienThoai1:String, soDienThoai2:String){

        let thongBaoDialog:UIAlertController = UIAlertController(title: "Thông Báo!", message: "Bạn vui lòng chọn!", preferredStyle: .alert)
        let goiSo1:UIAlertAction = UIAlertAction(title: "Gọi Số 1", style: .default) { (action1) in
            TrangChu.GoiSoDienThoai(phoneNumber: "tel://" + soDienThoai1.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
        }
        
        let goiSo2:UIAlertAction = UIAlertAction(title: "Gọi Số 2", style: .default) { (action2) in
            TrangChu.GoiSoDienThoai(phoneNumber: "tel://" + soDienThoai2.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
        }
        let Huy:UIAlertAction = UIAlertAction(title: "Hủy", style: .destructive) { (action2) in
            
        }
        

        if soDienThoai1 != "" && soDienThoai2 != ""{
            thongBaoDialog.addAction(goiSo1)
            thongBaoDialog.addAction(goiSo2)
            thongBaoDialog.addAction(Huy)
        } else if soDienThoai1 != ""{
            thongBaoDialog.addAction(goiSo1)
            thongBaoDialog.addAction(Huy)
        } else {
            thongBaoDialog.addAction(goiSo2)
            thongBaoDialog.addAction(Huy)
        }
       
      
       self.present(thongBaoDialog, animated: true, completion: nil)
        
    }
    
    let thongBaoChiTiet = ThongBaoChiTiet()
    
    func HienThiChiTietGia(hanTaxi:HangTaxiModel){
        
        thongBaoChiTiet.caiDatThongBao()
        thongBaoChiTiet.modelHangTaxi = hanTaxi
        

    }
    
    
    
   static func GoiSoDienThoai(phoneNumber:String){
      
        UIApplication.shared.openURL(URL(string: phoneNumber)!)

    }
    
    
    func GoiTaxiHander(soDienThoai1: String, soDienThoai2: String) {
        goiHangTaxi(soDienThoai1: soDienThoai1, soDienThoai2: soDienThoai1)
    }
    

    
    public func ThongBao(noiDung:String){
        let alerThongBao:UIAlertController = UIAlertController(title: "Thông báo", message: noiDung, preferredStyle: .alert)
        
        let btnDongY:UIAlertAction = UIAlertAction(title: "Đông Ý", style: .default) { (daction1) in
            self.setViewOnclickMenu(index: 6)
        }
        
        let btnTuChoi:UIAlertAction = UIAlertAction(title: "Hủy", style: .default) { (aa) in
            
        }
        
        alerThongBao.addAction(btnDongY)
        alerThongBao.addAction(btnTuChoi)
        self.present(alerThongBao, animated: true, completion: nil)
    }
    
    
    func ThongBaoCustom(noiDung:String){
        let alerThongBao:UIAlertController = UIAlertController(title: "Thông báo", message: noiDung, preferredStyle: .alert)
        
        let btnDongY:UIAlertAction = UIAlertAction(title: "OK", style: .default) { (daction1) in
           
        }
        
       
        
        alerThongBao.addAction(btnDongY)
        self.present(alerThongBao, animated: true, completion: nil)
    }

    
    func setupViewMenu(views:UIView){
        view.addSubview(views)
        //viewSellect = views
        UIView.animate(withDuration: 0.3) { 
            views.alpha = 1
        }
        
        view.addConstraintsArray(format: "H:|[v0]|", viewAdd: views)
        view.addConstraintsArray(format: "V:|[v0]|", viewAdd: views)
    }
    
    
    static func reloadView(){
        print(11)
    }
    

    func changeToLanguage(_ langCode:String){
        
        if Bundle.main.preferredLocalizations.first != langCode {
            let confirmAlerCtrl = UIAlertController(title: NSLocalizedString("restartTitle", comment: ""), message: NSLocalizedString("restart", comment: ""), preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: NSLocalizedString("close", comment: ""), style: .destructive, handler: { _ in
                UserDefaults.standard.set([langCode], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
                _Exit(0)
            })
            confirmAlerCtrl.addAction(confirmAction)
            let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil)
            confirmAlerCtrl.addAction(cancelAction)
            
            
            self.present(confirmAlerCtrl, animated: true, completion: nil)
            
        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if error != nil {
            print(error)
            return
        }
        TaiKhoanView.DangNhapGoogleThangCong(user: user)
        naviMenu.user = user
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
        if error != nil {
            print(error)
            return
        }
    }
    
}


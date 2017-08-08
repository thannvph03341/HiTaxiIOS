//
//  TaiKhoanView.swift
//  HiTaxi
//
//  Created by Nong Than on 2/20/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Google
import GoogleSignIn

class TaiKhoanView:UIView, FBSDKLoginButtonDelegate {

    static var trangChu:TrangChu?
    
   static let btnLoginFacebook:FBSDKLoginButton = {
        let b = FBSDKLoginButton(frame: .zero)
        
        return b
    }()
    
    static let btnDangXuat:UIButton = {
        let b = UIButton(frame: .zero)
            b.setTitle(NSLocalizedString("btnDangXuat", comment: ""), for: .normal)
            b.titleLabel?.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/25)
            b.setTitleColor(UIColor.white, for: .normal)
            b.backgroundColor = UIColor.init(red: 110/255, green: 184/255, blue: 87/255, alpha: 1)
        return b
    }()
    
    static let btnCapNhatThongTin:UIButton = {
        let b = UIButton(frame: .zero)
        b.setTitle(NSLocalizedString("btnupdatainfo", comment: ""), for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/25)
        b.setTitleColor(UIColor.white, for: .normal)
        b.backgroundColor = UIColor.init(red: 110/255, green: 184/255, blue: 87/255, alpha: 1)
        return b
    }()
    
     static let btnLoginGoole:GIDSignInButton = {
        let b = GIDSignInButton(frame: .zero)
        return b
    }()
    
    static var imgUser:UIImageView = {
        let img = UIImageView(frame: .zero)
        img.image = UIImage(named: "noimage")
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        return img
    }()
    
    
    let lb1:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.textColor = UIColor.black
        lb.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        lb.text = "Họ Tên: "
        return lb
    }()
    
    static var txtHoTen:UITextField = {
        let lb = UITextField(frame: .zero)
        lb.textColor = UIColor.black
        lb.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        lb.text = ""
        lb.isEnabled = true
//        lb.layer.borderColor = UIColor.green.cgColor
//        lb.layer.borderWidth = 1
//        lb.clipsToBounds = true
//        lb.layer.masksToBounds = true

        return lb
    }()
    
    
    let lb2:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.textColor = UIColor.black
        lb.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        lb.text = "SDT: "
        return lb
    }()
    
    let txtSDT:UITextField = {
        let lb = UITextField(frame: .zero)
        lb.textColor = UIColor.black
        lb.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        lb.text = ""
        lb.isEnabled = true
//        lb.layer.borderColor = UIColor.green.cgColor
//        lb.layer.borderWidth = 1
//        lb.clipsToBounds = true
//        lb.layer.masksToBounds = true

        return lb
    }()
    
    let lb3:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.textColor = UIColor.black
        lb.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        lb.text = "Email: "
        return lb
    }()
    
    let lb4:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.textColor = UIColor.black
        lb.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        lb.text = ""
        return lb
    }()
    
    let txtDiaChi:UITextField = {
        let lb = UITextField(frame: .zero)
        lb.textColor = UIColor.black
        lb.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        lb.text = ""
        lb.isEnabled = false
//        lb.layer.borderColor = UIColor.green.cgColor
//        lb.layer.borderWidth = 1
//        lb.clipsToBounds = true
//        lb.layer.masksToBounds = true
        return lb
    }()
    
    
    static var txtEmail:UITextField = {
        let lb = UITextField(frame: .zero)
        lb.textColor = UIColor.black
        lb.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        lb.text = ""
        lb.isEnabled = true
        return lb
    }()
    
    
    public func setData(imgUser:String, txtHoTen:String, txtSDT:String, txtDiaChi:String, txtEmail:String){
        TaiKhoanView.imgUser.LoadImageUrlString(urlString: imgUser)
        TaiKhoanView.txtHoTen.text = txtHoTen
        self.txtSDT.text = txtSDT
        self.txtDiaChi.text = txtDiaChi
        TaiKhoanView.txtEmail.text = txtEmail
        GIDSignIn.sharedInstance().signInSilently()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        backgroundColor = UIColor.white
        setupView()
    }
    
    func setupView(){
       
        TaiKhoanView.btnLoginFacebook.delegate = self
        
        
        addSubview(TaiKhoanView.imgUser)
        addSubview(lb1)
        addSubview(TaiKhoanView.txtHoTen)
        addSubview(lb2)
        addSubview(txtSDT)
        
        addSubview(lb3)
        addSubview(TaiKhoanView.txtEmail)
        
        addSubview(lb4)
        addSubview(txtDiaChi)
        
        addSubview(TaiKhoanView.btnLoginFacebook)
        addSubview(TaiKhoanView.btnLoginGoole)
        addSubview(TaiKhoanView.btnDangXuat)
        addSubview(TaiKhoanView.btnCapNhatThongTin)
        
        TaiKhoanView.btnDangXuat.addTarget(self, action: #selector(DangXuatTaiKhoan), for: .touchUpInside)
        
        addConstraintsArray(format: "H:[v0]", viewAdd: TaiKhoanView.imgUser)
        addConstraintsArray(format: "V:|-10-[v0]", viewAdd: TaiKhoanView.imgUser)
        
        addConstraintsArray(format: "H:|-5-[v0]", viewAdd: lb1)
        addConstraintsArray(format: "V:[v0]", viewAdd: lb1)
        
        addConstraintsArray(format: "H:[v0]-5-|", viewAdd: TaiKhoanView.txtHoTen)
        addConstraintsArray(format: "V:[v0]", viewAdd: TaiKhoanView.txtHoTen)
        
        addConstraintsArray(format: "H:|-5-[v0]", viewAdd: lb2)
        addConstraintsArray(format: "V:[v0]", viewAdd: lb2)
        
        addConstraintsArray(format: "H:[v0]-5-|", viewAdd: txtSDT)
        addConstraintsArray(format: "V:[v0]", viewAdd: txtSDT)
        
        addConstraintsArray(format: "H:|-5-[v0]", viewAdd: lb3)
        addConstraintsArray(format: "V:[v0]", viewAdd: lb3)
        
        addConstraintsArray(format: "H:[v0]-5-|", viewAdd: TaiKhoanView.txtEmail)
        addConstraintsArray(format: "V:[v0]", viewAdd: TaiKhoanView.txtEmail)
        
        addConstraintsArray(format: "H:|-5-[v0]", viewAdd: lb4)
        addConstraintsArray(format: "V:[v0]", viewAdd: lb4)
        
        addConstraintsArray(format: "H:[v0]-5-|", viewAdd: txtDiaChi)
        addConstraintsArray(format: "V:[v0]", viewAdd: txtDiaChi)
        
        
        addConstraint(NSLayoutConstraint(item: TaiKhoanView.imgUser, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.3, constant: 0 ))
        addConstraint(NSLayoutConstraint(item: TaiKhoanView.imgUser, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.3, constant: 0 ))
        
        addConstraint(NSLayoutConstraint(item: TaiKhoanView.imgUser, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0 ))
       
        //
        addConstraint(NSLayoutConstraint(item: lb1, attribute: .top, relatedBy: .equal, toItem: TaiKhoanView.imgUser, attribute: .bottom, multiplier: 1, constant: 5 ))
        
        addConstraint(NSLayoutConstraint(item: lb1, attribute: .centerY, relatedBy: .equal, toItem: TaiKhoanView.txtHoTen, attribute: .centerY, multiplier: 1, constant: 0 ))
        
         addConstraint(NSLayoutConstraint(item: TaiKhoanView.txtHoTen, attribute: .top, relatedBy: .equal, toItem: TaiKhoanView.imgUser, attribute: .bottom, multiplier: 1, constant: 5 ))
        addConstraint(NSLayoutConstraint(item: TaiKhoanView.txtHoTen, attribute: .left, relatedBy: .equal, toItem: lb1, attribute: .right, multiplier: 1, constant: 5 ))
         addConstraint(NSLayoutConstraint(item: TaiKhoanView.txtHoTen, attribute: .height, relatedBy: .equal, toItem: lb1, attribute: .height, multiplier: 1, constant: 0 ))
        
        //
        addConstraint(NSLayoutConstraint(item: lb2, attribute: .width, relatedBy: .equal, toItem: lb1, attribute: .width, multiplier: 1, constant: 0 ))
        
        addConstraint(NSLayoutConstraint(item: lb2, attribute: .centerY, relatedBy: .equal, toItem: txtSDT, attribute: .centerY, multiplier: 1, constant: 0 ))
        
        addConstraint(NSLayoutConstraint(item: txtSDT, attribute: .top, relatedBy: .equal, toItem: TaiKhoanView.txtHoTen, attribute: .bottom, multiplier: 1, constant: 5 ))
        addConstraint(NSLayoutConstraint(item: txtSDT, attribute: .left, relatedBy: .equal, toItem: lb2, attribute: .right, multiplier: 1, constant: 5 ))
        addConstraint(NSLayoutConstraint(item: txtSDT, attribute: .height, relatedBy: .equal, toItem: lb2, attribute: .height, multiplier: 1, constant: 0 ))
        
        //
        addConstraint(NSLayoutConstraint(item: lb3, attribute: .width, relatedBy: .equal, toItem: lb1, attribute: .width, multiplier: 1, constant: 0 ))
        
        addConstraint(NSLayoutConstraint(item: lb3, attribute: .centerY, relatedBy: .equal, toItem: TaiKhoanView.txtEmail, attribute: .centerY, multiplier: 1, constant: 0 ))
        
        addConstraint(NSLayoutConstraint(item: TaiKhoanView.txtEmail, attribute: .top, relatedBy: .equal, toItem: txtSDT, attribute: .bottom, multiplier: 1, constant: 5 ))
        addConstraint(NSLayoutConstraint(item: TaiKhoanView.txtEmail, attribute: .left, relatedBy: .equal, toItem: lb3, attribute: .right, multiplier: 1, constant: 5 ))
        addConstraint(NSLayoutConstraint(item: TaiKhoanView.txtEmail, attribute: .height, relatedBy: .equal, toItem: lb3, attribute: .height, multiplier: 1, constant: 0 ))
        
        
        //
        addConstraint(NSLayoutConstraint(item: lb4, attribute: .width, relatedBy: .equal, toItem: lb1, attribute: .width, multiplier: 1, constant: 0 ))
        
        addConstraint(NSLayoutConstraint(item: lb4, attribute: .centerY, relatedBy: .equal, toItem: txtDiaChi, attribute: .centerY, multiplier: 1, constant: 0 ))
        
        addConstraint(NSLayoutConstraint(item: txtDiaChi, attribute: .top, relatedBy: .equal, toItem: TaiKhoanView.txtEmail, attribute: .bottom, multiplier: 1, constant: 5 ))
        addConstraint(NSLayoutConstraint(item: txtDiaChi, attribute: .left, relatedBy: .equal, toItem: lb4, attribute: .right, multiplier: 1, constant: 5 ))
        addConstraint(NSLayoutConstraint(item: txtDiaChi, attribute: .height, relatedBy: .equal, toItem: lb4, attribute: .height, multiplier: 1, constant: 0 ))
        
        
        TaiKhoanView.imgUser.layer.cornerRadius = (UIScreen.main.bounds.width*0.3)/2
        TaiKhoanView.imgUser.layer.masksToBounds = true
        
        addConstraintsArray(format: "H:[v0]", viewAdd: TaiKhoanView.btnLoginFacebook)
        addConstraintsArray(format: "V:[v0(35)]", viewAdd: TaiKhoanView.btnLoginFacebook)
        
        addConstraint(NSLayoutConstraint(item: TaiKhoanView.btnLoginFacebook, attribute: .top, relatedBy: .equal, toItem: txtDiaChi, attribute: .bottom, multiplier: 1, constant: 5))
        
        addConstraint(NSLayoutConstraint(item: TaiKhoanView.btnLoginFacebook, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: TaiKhoanView.btnLoginFacebook, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: 0))
        
        
        addConstraintsArray(format: "H:[v0]", viewAdd: TaiKhoanView.btnLoginGoole)
        addConstraintsArray(format: "V:[v0(50)]", viewAdd: TaiKhoanView.btnLoginGoole)
        
        
        addConstraint(NSLayoutConstraint(item: TaiKhoanView.btnLoginGoole, attribute: .top, relatedBy: .equal, toItem: TaiKhoanView.btnLoginFacebook, attribute: .bottom, multiplier: 1, constant: 5))
        
        addConstraint(NSLayoutConstraint(item: TaiKhoanView.btnLoginGoole, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: TaiKhoanView.btnLoginGoole, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: 0))
        addConstraintsArray(format: "H:|-8-[v0(\(UIScreen.main.bounds.width / 2.2))]", viewAdd: TaiKhoanView.btnDangXuat)
        addConstraintsArray(format: "V:[v0]", viewAdd: TaiKhoanView.btnDangXuat)

         addConstraint(NSLayoutConstraint(item: TaiKhoanView.btnDangXuat, attribute: .top, relatedBy: .equal, toItem: txtDiaChi, attribute: .bottom, multiplier: 1, constant: 8))

         addConstraint(NSLayoutConstraint(item: TaiKhoanView.btnDangXuat, attribute: .height, relatedBy: .equal, toItem: TaiKhoanView.btnLoginFacebook, attribute: .height, multiplier: 1, constant: 0))
        
        addConstraintsArray(format: "H:[v0(\(UIScreen.main.bounds.width / 2.2))]-8-|", viewAdd: TaiKhoanView.btnCapNhatThongTin)
        addConstraintsArray(format: "V:[v0]", viewAdd: TaiKhoanView.btnCapNhatThongTin)
        
        addConstraint(NSLayoutConstraint(item: TaiKhoanView.btnCapNhatThongTin, attribute: .top, relatedBy: .equal, toItem: txtDiaChi, attribute: .bottom, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: TaiKhoanView.btnCapNhatThongTin, attribute: .height, relatedBy: .equal, toItem: TaiKhoanView.btnDangXuat, attribute: .height, multiplier: 1, constant: 0))
        TaiKhoanView.btnCapNhatThongTin.addTarget(self, action: #selector(CapNhatThongTin), for: .touchUpInside)
        
        loadDataNguoiDung()
    }
    
    func CapNhatThongTin(){
        if TaiKhoanView.txtHoTen.text == ""{
            TaiKhoanView.trangChu?.ThongBao(noiDung: NSLocalizedString("vuiLongNhapHoTen", comment: ""))
            TaiKhoanView.txtHoTen.becomeFirstResponder()
            return
        }
        
        if txtSDT.text == ""{
            TaiKhoanView.trangChu?.ThongBao(noiDung: NSLocalizedString("vuiLongNhapsdt", comment: ""))
            txtSDT.becomeFirstResponder()
            return
        }
        
        if TaiKhoanView.txtEmail.text == ""{
            TaiKhoanView.trangChu?.ThongBao(noiDung: NSLocalizedString("vuiLongNhapEmail", comment: ""))
            TaiKhoanView.txtEmail.becomeFirstResponder()
            return
        }
        
        let ndSql = SQLiteConfig().thongTinNguoiDung()
        
        let modelNguoiDung = ModelNguoiDung()
            modelNguoiDung.Manguoidung = ndSql.Manguoidung
            modelNguoiDung.Tennguoidung = TaiKhoanView.txtHoTen.text
            modelNguoiDung.Sodienthoai = txtSDT.text
            modelNguoiDung.Email = TaiKhoanView.txtEmail.text
            modelNguoiDung.Facebook = ndSql.Manguoidung
            modelNguoiDung.Password = ndSql.Password
            modelNguoiDung.Ngaysinh = ""
        ModelNguoiDung.UpdataThongTin(thongTinUser: modelNguoiDung) { (st) in
            TaiKhoanView.trangChu?.ThongBaoCustom(noiDung: st)
        }

    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
      
        setL(txtView: TaiKhoanView.txtHoTen)
        setL(txtView: txtSDT)
        setL(txtView: TaiKhoanView.txtEmail)
    }
    
    func setL(txtView:UITextField){
        let b = CALayer()
        b.backgroundColor = UIColor.green.cgColor
        b.frame = CGRect(x: 0, y: txtView.frame.height - 1, width: txtView.frame.width, height: 1)
            txtView.layer.addSublayer(b)
    }
    
    
    func DangXuatTaiKhoan(){
        TaiKhoanView.btnLoginGoole.alpha = 1
        TaiKhoanView.btnLoginFacebook.alpha = 1
        TaiKhoanView.btnDangXuat.alpha = 0
        TaiKhoanView.btnCapNhatThongTin.alpha = 0
        TaiKhoanView.imgUser.image = UIImage(named: "")
        NavigationCellUser.imageUser.image = UIImage(named: "")
        NavigationCellUser.txtTen.text = ""
        TaiKhoanView.txtHoTen.text = ""
        self.txtSDT.text = ""
        self.txtDiaChi.text = ""
        TaiKhoanView.txtEmail.text = ""
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
    }
    

    
    func loadDataNguoiDung(){
        let model = SQLiteConfig().thongTinNguoiDung()
        if let _ = model.Manguoidung{
            TaiKhoanView.imgUser.LoadImageUrlString(urlString: model.Password!)
            TaiKhoanView.txtHoTen.text = model.Tennguoidung
            self.txtSDT.text = model.Sodienthoai
            self.txtDiaChi.text = model.Facebook
            TaiKhoanView.txtEmail.text = model.Email
            TaiKhoanView.btnLoginGoole.alpha = 0
            TaiKhoanView.btnLoginFacebook.alpha = 0
            //TaiKhoanView.btnDangXuat.frame = TaiKhoanView.btnLoginFacebook.frame
            NavigationCellUser.imageUser.LoadImageUrlString(urlString: model.Password!)
            NavigationCellUser.txtTen.text = model.Tennguoidung
            NavigationCellUser.txtTen.text = ""
            TaiKhoanView.btnDangXuat.alpha = 1
            TaiKhoanView.btnCapNhatThongTin.alpha = 1
        } else {
            TaiKhoanView.btnDangXuat.alpha = 0
            TaiKhoanView.btnCapNhatThongTin.alpha = 0
        }
    }
    
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
        print("loginButtonDidLogOut")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        let parammeters = ["fields": "email,link,id,first_name,last_name, name,locale,gender,picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me",parameters: parammeters).start { (connection, result, error) in
            if error != nil{
                
                print(error!)
                
                return
                
            }
            
            let data:[String:AnyObject] = result as! [String : AnyObject]
            
         //   let email = data["email"] as? String
            let firstname = data["name"] as? String
            //let last_name = data["last_name"] as? String
           // let gender = data["gender"] as? String
            let id = data["id"] as? String
            //let employee_number = data["employee_number"] as? String
            TaiKhoanView.txtHoTen.text = firstname
           // self.txtEmail.text = email!
            TaiKhoanView.imgUser.LoadImageUrlString(urlString: AnhFacebook(idNguoiDung: id!))
            
            let thongTin = ModelNguoiDung()
                thongTin.Manguoidung = id
                thongTin.Tennguoidung = firstname
                thongTin.Sodienthoai = ""
                thongTin.Facebook = id
                thongTin.Email = ""
                thongTin.Ngaysinh = ""
                thongTin.Password = AnhFacebook(idNguoiDung: id!)
            SQLiteConfig().themNguoiDung(modelNguoiDung: thongTin)
            TaiKhoanView.btnLoginGoole.alpha = 0
            TaiKhoanView.btnLoginFacebook.alpha = 0
            //TaiKhoanView.btnDangXuat.frame = TaiKhoanView.btnLoginFacebook.frame
            TaiKhoanView.btnDangXuat.alpha = 1
            TaiKhoanView.btnCapNhatThongTin.alpha = 1
            self.loadDataNguoiDung()
        }
        
    }
    
    
  static func DangNhapGoogleThangCong(user: GIDGoogleUser) {
    
        self.txtHoTen.text = user.profile.name
        self.txtEmail.text = user.profile.email
        self.imgUser.LoadImageUrlString(urlString: user.profile.imageURL(withDimension: 0).absoluteString)
    
    let thongTin = ModelNguoiDung()
    thongTin.Manguoidung = user.userID
    thongTin.Tennguoidung = user.profile.name
    thongTin.Sodienthoai = ""
    thongTin.Facebook = "Google: \(user.userID)"
    thongTin.Email = user.profile.email
    thongTin.Ngaysinh = ""
    thongTin.Password = user.profile.imageURL(withDimension: 0).absoluteString
    SQLiteConfig().themNguoiDung(modelNguoiDung: thongTin)
    TaiKhoanView.btnLoginGoole.alpha = 0
    TaiKhoanView.btnLoginFacebook.alpha = 0
   // TaiKhoanView.btnDangXuat.frame = TaiKhoanView.btnLoginFacebook.frame
    TaiKhoanView.btnDangXuat.alpha = 1
    TaiKhoanView.btnCapNhatThongTin.alpha = 1
    
   }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

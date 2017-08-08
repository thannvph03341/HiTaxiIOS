//
// CaiDatView.swift
//  HiTaxi
//
//  Created by Nong Than on 2/8/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import UIKit

class CaiDatView:UIView{
    
    
    static var trangChu:TrangChu?
    
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
//    
//    let textThongBao:UITextView = {
//        let t = UITextView(frame: .zero)
//        t.text = "GIỚI THIỆU: HITAXI là ứng dụng giúp người dụng tìm nhanh số điện thoại của các hãng taxi ngay trên Smartphone của mình. Không phải lo lắng mỗi khi cần đến taxi mà lại không biết số tổng đài để gọi.\nTác Giả: Hà Duy Sơn"
//        t.isSelectable = false
//        t.isEditable = false
//        t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
//        t.textAlignment = .justified
//        return t
//    }()
    
    let btnChonTiengViet:UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setTitle("◉ Tiếng Việt", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        return btn
    }()
    
    let btnChonTiengAnh:UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setTitle("◉ Tiếng Việt", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setupView()
        
        if Bundle.main.preferredLocalizations.first == "vi"{
            btnChonTiengViet.setTitle("◉ Tiếng Việt", for: .normal)
            btnChonTiengAnh.setTitle("◎ English", for: .normal)
        } else {
            btnChonTiengAnh.setTitle("◉ English", for: .normal)
            btnChonTiengViet.setTitle("◎ Tiếng Việt", for: .normal)
        }
    }
    
    func setupView() {
        
        //
        addSubview(btnChonTiengViet)
        addSubview(btnChonTiengAnh)
        addConstraintsArray(format: "H:|-10-[v0]", viewAdd: btnChonTiengViet)
        addConstraintsArray(format: "V:|-10-[v0]", viewAdd: btnChonTiengViet)
        addConstraintsArray(format: "H:[v0]-10-|", viewAdd: btnChonTiengAnh)
        addConstraintsArray(format: "V:|-10-[v0]", viewAdd: btnChonTiengAnh)
        
        addConstraint(NSLayoutConstraint(item: btnChonTiengViet, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.3, constant: 0))
        
        btnChonTiengViet.addTarget(self, action: #selector(ChonTiengViet), for: .touchUpInside)
        btnChonTiengAnh.addTarget(self, action: #selector(ChonTiengAnh), for: .touchUpInside)
        
//
//                addSubview(collectionViewConfigThongBao)
//                addConstraintsArray(format: "H:|[v0]|", viewAdd: collectionViewConfigThongBao)
//                addConstraintsArray(format: "V:|[v0]|", viewAdd: collectionViewConfigThongBao)
    }
    
    func ChonTiengViet(){
        CaiDatView.trangChu?.changeToLanguage("vi")
       // changeToLanguage("vi")
        
    }
    
    func ChonTiengAnh(){
        //changeToLanguage("en")
        CaiDatView.trangChu?.changeToLanguage("en")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    
//    func changeToLanguage(_ langCode:String){
//        
//        UserDefaults.standard.set([langCode], forKey: "AppleLanguages")
//        if UserDefaults.standard.synchronize() {
//       
//            if let windown = UIApplication.shared.keyWindow {
//                windown.rootViewController = UINavigationController(rootViewController: TrangChu(collectionViewLayout: UICollectionViewFlowLayout()))
//                
//            }
//        }
// 
//   }

    
    
}

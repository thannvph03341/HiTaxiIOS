//
//  ThongBaoView.swift
//  HiTaxi
//
//  Created by Nong Than on 2/8/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import UIKit

class ThongBaoView:UIView{
    
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
        t.text = "THÔNG BÁO: \nHiện ứng dụng Hitaxi đều có mặt trên Android và iOS. Tuy nhiên, phiên bản đang được thử nghiệm nên dữ liệu còn khá thiếu sót, rất mong người dùng có thể bổ sung thông tin cũng như đóng góp ý kiến cho đội ngũ của chúng tôi hoàn thiện tốt hơn về sản phẩm."
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
        
       let tt = SQLiteConfig().DanhSachThongBao()
        if let nd = tt.ngoiDungThongBao {
            textThongBao.text = "THÔNG BÁO: \n\(nd)"
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

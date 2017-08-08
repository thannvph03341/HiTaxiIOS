//
//  ThongBaoChiTiet.swift
//  HiTaxi
//
//  Created by Nong Than on 4/5/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import UIKit

class ThongBaoChiTiet:NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let numberFormart = NumberFormatter()
    
    lazy var collectionviewConfig:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
            v.dataSource = self
            v.delegate = self
            v.showsVerticalScrollIndicator = false
            v.showsHorizontalScrollIndicator = false
            v.backgroundColor = UIColor.white
            v.layer.borderWidth = 2
            v.layer.borderColor = UIColor(white: 0, alpha: 0).cgColor
            v.layer.masksToBounds = true
            v.clipsToBounds = true
            v.layer.cornerRadius = 5
            v.isScrollEnabled = false
        return v
    }()
    
    var modelHangTaxi:HangTaxiModel? {
        didSet{
            collectionviewConfig.reloadData()
            txtTenHangTaxi.text = modelHangTaxi?.Tenhangtaxi
        }
    }
    
    
    let view1:UIView = {
        let v = UIView(frame: .zero)
        return v
    }()
    
    
    let view2:UIView = {
        let v = UIView(frame: .zero)
        return v
    }()
    
    let txtTenHangTaxi:UITextView = {
        let t = UITextView(frame: .zero)
        t.text = "Tên taxi"
        t.textColor = UIColor.black
        t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/18)
        t.textAlignment = .center
        t.layer.borderWidth = 2
        t.layer.borderColor = UIColor(white: 0, alpha: 0).cgColor
        t.layer.masksToBounds = true
        t.clipsToBounds = true
        t.layer.cornerRadius = 5
        t.backgroundColor = UIColor.white
        return t
    }()
    
    let button:UIButton = {
        let b = UIButton(frame: .zero)
        b.setTitle("OK", for: .normal)
        b.setTitleColor(UIColor.black, for: .normal)
        b.titleLabel?.font =  UIFont.systemFont(ofSize: UIScreen.main.bounds.width/18)
        b.backgroundColor = UIColor.white
        b.layer.borderWidth = 2
        b.layer.borderColor = UIColor(white: 0, alpha: 0).cgColor
        b.layer.masksToBounds = true
        b.clipsToBounds = true
        b.layer.cornerRadius = 5
        return b
    }()
    
    
    func caiDatThongBao(){
    
       if let windown = UIApplication.shared.keyWindow {
             view1.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        
        view1.addSubview(txtTenHangTaxi)
        view1.addSubview(collectionviewConfig)
        view1.addSubview(button)
        
        
        view1.addConstraintsArray(format: "H:|-(\(UIScreen.main.bounds.width/10))-[v0]-(\(UIScreen.main.bounds.width/10))-|", viewAdd: txtTenHangTaxi)
        
         view1.addConstraintsArray(format: "V:|-(\(UIScreen.main.bounds.height/3))-[v0(\(UIScreen.main.bounds.width/10))]", viewAdd: txtTenHangTaxi)
        
        view1.addConstraintsArray(format: "H:|-(\(UIScreen.main.bounds.width/10))-[v0]-(\(UIScreen.main.bounds.width/10))-|", viewAdd: collectionviewConfig)
        view1.addConstraintsArray(format: "V:[v0(\(UIScreen.main.bounds.height/4.5))]", viewAdd: collectionviewConfig)
       
        
        
        view1.addConstraint(NSLayoutConstraint(item: collectionviewConfig, attribute: .top, relatedBy: .equal, toItem: txtTenHangTaxi, attribute: .bottom, multiplier: 1, constant: 0))
        
        view1.addConstraintsArray(format: "H:|-(\(UIScreen.main.bounds.width/10))-[v0]-(\(UIScreen.main.bounds.width/10))-|", viewAdd: button)
        
        view1.addConstraintsArray(format: "V:[v0(\(UIScreen.main.bounds.width/10))]", viewAdd: button)
        
        view1.addConstraint(NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: collectionviewConfig, attribute: .bottom, multiplier: 1, constant: 5))

        
        
        
        windown.addSubview(view1)
        windown.addConstraintsArray(format: "H:|[v0]|", viewAdd: view1)
        windown.addConstraintsArray(format: "V:|[v0]|", viewAdd: view1)
        view1.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveLinear, animations: { 
            self.view1.alpha = 1
        }, completion: nil)
        
        view1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TatThongBao)))
        button.addTarget(self, action: #selector(TatThongBao), for: .touchUpInside)
        
        
        
        }
    }
        
    
    
    func TatThongBao(){
        UIView.animate(withDuration: 0.5) { 
            self.view1.alpha = 0
        }
    }
    
    override init() {
        super.init()
        
        numberFormart.numberStyle = .decimal
        collectionviewConfig.register(UICellThongBao.self, forCellWithReuseIdentifier: "idCeoTB")
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idCeoTB", for: indexPath) as! UICellThongBao
        let top = CALayer()
        top.backgroundColor = UIColor.init(red: 79/255, green: 184/255, blue: 72/255, alpha: 1).cgColor
        top.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1)
            cell.layer.addSublayer(top)
        cell.txtLb1.alpha = 1
        
        
        
        switch indexPath.row {
        case 0:
            cell.txtLb1.text =  NSLocalizedString("4cho", comment: "")
            cell.txtLb1.textAlignment = .right
            break
            
        case 1:
            cell.txtLb1.text =  NSLocalizedString("7cho", comment: "")
            cell.txtLb1.textAlignment = .center
            break
            
        case 2:
            cell.txtLb1.text =  "\(NSLocalizedString("giamocua", comment: ""))    \(numberFormart.string(from: (modelHangTaxi?.Giamocua != nil ? modelHangTaxi?.Giamocua!:0)!)!) đ"
            cell.txtLb1.textAlignment = .right
            break
        case 3:
            cell.txtLb1.text = "\(numberFormart.string(from: (modelHangTaxi?.Giamocua7 != nil ? modelHangTaxi?.Giamocua7!:0)!)!) đ"
            cell.txtLb1.textAlignment = .center
              break
            
        case 4:
            cell.txtLb1.text = "\(NSLocalizedString("giadau", comment: "")) \(numberFormart.string(from: (modelHangTaxi?.Giakmdau != nil ? modelHangTaxi?.Giakmdau!:0)!)!) đ"
            cell.txtLb1.textAlignment = .right
            break
        case 5:
            cell.txtLb1.text = "\(numberFormart.string(from: (modelHangTaxi?.Giakmdau7 != nil ? modelHangTaxi?.Giakmdau7!:0)!)!) đ"
            cell.txtLb1.textAlignment = .center
             break
        case 6:
            cell.txtLb1.text = "\(NSLocalizedString("giasau", comment: "")) \(numberFormart.string(from: (modelHangTaxi?.Giakmdau != nil ? modelHangTaxi?.Giakmdau!:0)!)!) đ"
            cell.txtLb1.textAlignment = .right
             break
        case 7:
            cell.txtLb1.text = "\(numberFormart.string(from: (modelHangTaxi?.Giakmsau7 != nil ? modelHangTaxi?.Giakmsau7!:0)!)!) đ"
            cell.txtLb1.textAlignment = .center
            break
        
       default:
        cell.txtLb1.alpha = 0
            break
        }
      return cell
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row % 2 == 0 {
        
           return CGSize(width: (UIScreen.main.bounds.width - (UIScreen.main.bounds.width/10)*2)/1.8, height: UIScreen.main.bounds.width/10)
        } else {
            return CGSize(width:(UIScreen.main.bounds.width - (UIScreen.main.bounds.width/10)*2)/3.6, height: UIScreen.main.bounds.width/10)
        }
    }
    
}



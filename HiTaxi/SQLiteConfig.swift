//
//  SQLiteConfig.swift
//  HiTaxi
//
//  Created by Nong Than on 3/5/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import UIKit
import SQLite

class SQLiteConfig:NSObject {
    
    
    let tbTinhThanh:String = "tbTinhThanh"
    let tbHangTaxi:String = "tbHangTaxi"
    let tbHangTaxiYeuThich:String = "tbHangTaxiYeuThich"
    
    
    let dbHiTaxiThannvph03341 = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("dataTaxiThannvph03341.db").path
    var db:Connection?
    var dateFormat = DateFormatter()
    
    
   override init() {
        super.init()
        db = try! Connection(dbHiTaxiThannvph03341)
        dateFormat.dateFormat = "MM/dd/yyyy hh:mm:ss"
        print(db)
        CreateTable()
    }
    
    func CreateTable(){
        
        do {
            
            try db?.run("CREATE TABLE IF NOT EXISTS tbThongBao (noiDungThongBao NVARCHAR, ngayNhanThongBao DATETIME)")
            
             try db?.run("CREATE TABLE IF NOT EXISTS \(tbHangTaxiYeuThich) (Mahangtaxi NVARCHAR PRIMARY KEY NOT NULL UNIQUE, Tenhangtaxi NVARCHAR, Sodienthoai NVARCHAR, Sodienthoai2 NVARCHAR, Diachi NVARCHAR, Website NVARCHAR, Khoanggia NVARCHAR, Facebook NVARCHAR, MaTinhthanh NVARCHAR, Rate INTEGER, Hinhanh NVARCHAR, Giamocua DECIME(18,2), Giakmdau DECIME(18,2), Giakmsau DECIME(18,2), Khoanggia7cho DECIME(18,2), Giamocua7 DECIME(18,2), Giakmdau7 DECIME(18,2), Giakmsau7 DECIME(18,2))")
            
            try db?.run("CREATE TABLE IF NOT EXISTS tbNguoiDung(Manguoidung NVARCHAR PRIMARY KEY NOT NULL UNIQUE, Tennguoidung NVARCHAR, Sodienthoai NVARCHAR, Email NVARCHAR, Facebook NVARCHAR, Ngaysinh NVARCHAR, Password NVARCHAR)")
            
            try db?.run("CREATE TABLE IF NOT EXISTS \(tbTinhThanh) (MaTinhthanh NVARCHAR PRIMARY KEY NOT NULL UNIQUE, Tentinhthanh NVARCHAR)")
            try db?.run("CREATE TABLE IF NOT EXISTS \(tbHangTaxi) (Mahangtaxi NVARCHAR PRIMARY KEY NOT NULL UNIQUE, Tenhangtaxi NVARCHAR, Sodienthoai NVARCHAR, Sodienthoai2 NVARCHAR, Diachi NVARCHAR, Website NVARCHAR, Khoanggia NVARCHAR, Facebook NVARCHAR, MaTinhthanh NVARCHAR, Rate INTEGER, Hinhanh NVARCHAR, Giamocua DECIME(18,2), Giakmdau DECIME(18,2), Giakmsau DECIME(18,2), Khoanggia7cho DECIME(18,2), Giamocua7 DECIME(18,2), Giakmdau7 DECIME(18,2), Giakmsau7 DECIME(18,2))")
            
            
        }catch let err{
            print(err)
        }
        
    
    }
    
    
    func ThemThongBao(tb:ModelThongBao){
        do {
            try db?.run("INSERT INTO tbThongBao (noiDungThongBao, ngayNhanThongBao) VALUES ('\(tb.ngoiDungThongBao!)','\(dateFormat.string(from: tb.ngayThongBao!))')")
        } catch let e {
            print("ThemThongBao: \(e)")
        }
    }
    
    
    func DanhSachThongBao() -> ModelThongBao {
        let modelThongBao = ModelThongBao()
        do {
            
            for items in try(db?.prepare("SELECT * FROM tbThongBao WHERE ngayNhanThongBao = (SELECT MAX(ngayNhanThongBao) FROM tbThongBao) "))! {
              
                
                if let noidung = items[0] as? String {
                    modelThongBao.ngoiDungThongBao = noidung
                } else {
                    modelThongBao.ngoiDungThongBao = ""
                }
                
                if let ngay = items[1] as? String {
                    modelThongBao.ngayThongBao = dateFormat.date(from: ngay)
                } else {
                    modelThongBao.ngayThongBao = nil
                }
            }
            
            return modelThongBao
            
        }catch let errLayTinhThanh{
            print("DanhSachThongBao", errLayTinhThanh)
            return modelThongBao
        }
    }
    
    
    func layTinhThanh() -> [TinhThanhModel]{
         var danhSachTinhThanh = [TinhThanhModel]()
        do {
           
            for items in try(db?.prepare("SELECT * FROM \(tbTinhThanh)"))! {
                let modelTinhThanh = TinhThanhModel()
                
                if let maTinhThanh = items[0] as? String {
                    modelTinhThanh.maTinhThanh = maTinhThanh
                } else {
                    modelTinhThanh.maTinhThanh = ""
                }
                
                if let tenTinhThanh = items[1] as? String {
                    modelTinhThanh.tenTinhThanh = tenTinhThanh
                } else {
                    modelTinhThanh.tenTinhThanh = ""
                }
                danhSachTinhThanh.append(modelTinhThanh)
            }

            return danhSachTinhThanh
            
        }catch let errLayTinhThanh{
            print("layTinhThanh", errLayTinhThanh)
            return danhSachTinhThanh
        }
    }
    
    func layDanhSachHangTaxiTheoTinhThanh(maTinhThanh:String) -> [HangTaxiModel]{
        var danhSachHangTaix = [HangTaxiModel]()
        
        do{
            
            for items in try(db?.prepare("SELECT * FROM \(tbHangTaxi) WHERE MaTinhthanh = '\(maTinhThanh)'"))!{
                let modelhangTaxi = HangTaxiModel()
                
                if let Mahangtaxi = items[0] as? String {
                    modelhangTaxi.Mahangtaxi = Mahangtaxi
                } else {
                    modelhangTaxi.Mahangtaxi = ""
                }
                
                if let Tenhangtaxi = items[1] as? String {
                    modelhangTaxi.Tenhangtaxi = Tenhangtaxi
                } else {
                    modelhangTaxi.Tenhangtaxi = ""
                }
                
                if let Sodienthoai = items[2] as? String {
                    modelhangTaxi.Sodienthoai = Sodienthoai
                } else {
                    modelhangTaxi.Sodienthoai = ""
                }
                
                
                if let Sodienthoai2 = items[3] as? String {
                    modelhangTaxi.Sodienthoai2 = Sodienthoai2
                } else {
                    modelhangTaxi.Sodienthoai2 = ""
                }
                
                if let Diachi = items[4] as? String {
                    modelhangTaxi.Diachi = Diachi
                } else {
                    modelhangTaxi.Diachi = ""
                }
                
                if let Website = items[5] as? String {
                    modelhangTaxi.Website = Website
                } else {
                    modelhangTaxi.Website = ""
                }
                
                if let Khoanggia = items[6] as? String {
                    modelhangTaxi.Khoanggia = Khoanggia
                } else {
                    modelhangTaxi.Khoanggia = ""
                }
                
                if let Facebook = items[7] as? String {
                    modelhangTaxi.Facebook = Facebook
                } else {
                    modelhangTaxi.Facebook = ""
                }
                
                if let MaTinhthanh = items[8] as? String {
                    modelhangTaxi.MaTinhthanh = MaTinhthanh
                } else {
                    modelhangTaxi.MaTinhthanh = ""
                }
                
                if let Rate = items[9] as? NSNumber {
                    modelhangTaxi.Rate = Rate
                } else {
                    modelhangTaxi.Rate = 0
                }
                
                if let Hinhanh = items[10] as? String {
                    modelhangTaxi.Hinhanh = Hinhanh
                } else {
                    modelhangTaxi.Hinhanh = ""
                }
                
                
                if let Giamocua = items[11] as? NSNumber {
                    modelhangTaxi.Giamocua = Giamocua
                } else {
                    modelhangTaxi.Giamocua = 0
                }
                
                
                if let Giakmdau = items[12] as? NSNumber {
                    modelhangTaxi.Giakmdau = Giakmdau
                } else {
                    modelhangTaxi.Giakmdau = 0
                }
                
                if let Giakmsau = items[13] as? NSNumber {
                    modelhangTaxi.Giakmsau = Giakmsau
                } else {
                    modelhangTaxi.Giakmsau = 0
                }
                
                if let Khoanggia7cho = items[14] as? NSNumber {
                    modelhangTaxi.Khoanggia7cho = Khoanggia7cho
                } else {
                    modelhangTaxi.Khoanggia7cho = 0
                }
                
                if let Giamocua7 = items[15] as? NSNumber {
                    modelhangTaxi.Giamocua7 = Giamocua7
                } else {
                    modelhangTaxi.Giamocua7 = 0
                }
                
                if let Giakmdau7 = items[16] as? NSNumber {
                    modelhangTaxi.Giakmdau7 = Giakmdau7
                } else {
                    modelhangTaxi.Giakmdau7 = 0
                }
                
                if let Giakmsau7 = items[17] as? NSNumber {
                    modelhangTaxi.Giakmsau7 = Giakmsau7
                } else {
                    modelhangTaxi.Giakmsau7 = 0
                }
                
                
                danhSachHangTaix.append(modelhangTaxi)
            }
            
            return danhSachHangTaix
        }catch let errHangTaxi{
            print(layDanhSachHangTaxi, errHangTaxi)
            return danhSachHangTaix
        }
        
    }
    
    
    func layDanhSachHangTaxiYeuThichTheoTinhThanh(maTinhThanh:String) -> [HangTaxiModel]{
        var danhSachHangTaix = [HangTaxiModel]()
        
        do{
            
            for items in try(db?.prepare("SELECT * FROM \(tbHangTaxiYeuThich) WHERE MaTinhthanh = '\(maTinhThanh)'"))!{
                let modelhangTaxi = HangTaxiModel()
                
                if let Mahangtaxi = items[0] as? String {
                    modelhangTaxi.Mahangtaxi = Mahangtaxi
                } else {
                    modelhangTaxi.Mahangtaxi = ""
                }
                
                if let Tenhangtaxi = items[1] as? String {
                    modelhangTaxi.Tenhangtaxi = Tenhangtaxi
                } else {
                    modelhangTaxi.Tenhangtaxi = ""
                }
                
                if let Sodienthoai = items[2] as? String {
                    modelhangTaxi.Sodienthoai = Sodienthoai
                } else {
                    modelhangTaxi.Sodienthoai = ""
                }
                
                
                if let Sodienthoai2 = items[3] as? String {
                    modelhangTaxi.Sodienthoai2 = Sodienthoai2
                } else {
                    modelhangTaxi.Sodienthoai2 = ""
                }
                
                if let Diachi = items[4] as? String {
                    modelhangTaxi.Diachi = Diachi
                } else {
                    modelhangTaxi.Diachi = ""
                }
                
                if let Website = items[5] as? String {
                    modelhangTaxi.Website = Website
                } else {
                    modelhangTaxi.Website = ""
                }
                
                if let Khoanggia = items[6] as? String {
                    modelhangTaxi.Khoanggia = Khoanggia
                } else {
                    modelhangTaxi.Khoanggia = ""
                }
                
                if let Facebook = items[7] as? String {
                    modelhangTaxi.Facebook = Facebook
                } else {
                    modelhangTaxi.Facebook = ""
                }
                
                if let MaTinhthanh = items[8] as? String {
                    modelhangTaxi.MaTinhthanh = MaTinhthanh
                } else {
                    modelhangTaxi.MaTinhthanh = ""
                }
                
                if let Rate = items[9] as? NSNumber {
                    modelhangTaxi.Rate = Rate
                } else {
                    modelhangTaxi.Rate = 0
                }
                
                if let Hinhanh = items[10] as? String {
                    modelhangTaxi.Hinhanh = Hinhanh
                } else {
                    modelhangTaxi.Hinhanh = ""
                }
                
                
                if let Giamocua = items[11] as? NSNumber {
                    modelhangTaxi.Giamocua = Giamocua
                } else {
                    modelhangTaxi.Giamocua = 0
                }
                
                
                if let Giakmdau = items[12] as? NSNumber {
                    modelhangTaxi.Giakmdau = Giakmdau
                } else {
                    modelhangTaxi.Giakmdau = 0
                }
                
                if let Giakmsau = items[13] as? NSNumber {
                    modelhangTaxi.Giakmsau = Giakmsau
                } else {
                    modelhangTaxi.Giakmsau = 0
                }
                
                if let Khoanggia7cho = items[14] as? NSNumber {
                    modelhangTaxi.Khoanggia7cho = Khoanggia7cho
                } else {
                    modelhangTaxi.Khoanggia7cho = 0
                }
                
                if let Giamocua7 = items[15] as? NSNumber {
                    modelhangTaxi.Giamocua7 = Giamocua7
                } else {
                    modelhangTaxi.Giamocua7 = 0
                }
                
                if let Giakmdau7 = items[16] as? NSNumber {
                    modelhangTaxi.Giakmdau7 = Giakmdau7
                } else {
                    modelhangTaxi.Giakmdau7 = 0
                }
                
                if let Giakmsau7 = items[17] as? NSNumber {
                    modelhangTaxi.Giakmsau7 = Giakmsau7
                } else {
                    modelhangTaxi.Giakmsau7 = 0
                }
                
                
                danhSachHangTaix.append(modelhangTaxi)
            }
            
            return danhSachHangTaix
        }catch let errHangTaxi{
            print(layDanhSachHangTaxi, errHangTaxi)
            return danhSachHangTaix
        }
        
    }
    
    
    func layDanhSachHangTaxi() -> [HangTaxiModel]{
        var danhSachHangTaix = [HangTaxiModel]()
        
        do{
        
            for items in try(db?.prepare("SELECT * FROM \(tbHangTaxi)"))!{
                let modelhangTaxi = HangTaxiModel()
              
                if let Mahangtaxi = items[0] as? String {
                    modelhangTaxi.Mahangtaxi = Mahangtaxi
                } else {
                    modelhangTaxi.Mahangtaxi = ""
                }
                
                if let Tenhangtaxi = items[1] as? String {
                    modelhangTaxi.Tenhangtaxi = Tenhangtaxi
                } else {
                    modelhangTaxi.Tenhangtaxi = ""
                }
                
                if let Sodienthoai = items[2] as? String {
                    modelhangTaxi.Sodienthoai = Sodienthoai
                } else {
                    modelhangTaxi.Sodienthoai = ""
                }
                
                
                if let Sodienthoai2 = items[3] as? String {
                    modelhangTaxi.Sodienthoai2 = Sodienthoai2
                } else {
                    modelhangTaxi.Sodienthoai2 = ""
                }
                
                if let Diachi = items[4] as? String {
                    modelhangTaxi.Diachi = Diachi
                } else {
                    modelhangTaxi.Diachi = ""
                }
                
                if let Website = items[5] as? String {
                    modelhangTaxi.Website = Website
                } else {
                    modelhangTaxi.Website = ""
                }
                
                if let Khoanggia = items[6] as? String {
                    modelhangTaxi.Khoanggia = Khoanggia
                } else {
                    modelhangTaxi.Khoanggia = ""
                }
                
                if let Facebook = items[7] as? String {
                    modelhangTaxi.Facebook = Facebook
                } else {
                    modelhangTaxi.Facebook = ""
                }
                
                if let MaTinhthanh = items[8] as? String {
                    modelhangTaxi.MaTinhthanh = MaTinhthanh
                } else {
                    modelhangTaxi.MaTinhthanh = ""
                }
                
                if let Rate = items[9] as? NSNumber {
                    modelhangTaxi.Rate = Rate
                } else {
                    modelhangTaxi.Rate = 0
                }

                if let Hinhanh = items[10] as? String {
                    modelhangTaxi.Hinhanh = Hinhanh
                } else {
                    modelhangTaxi.Hinhanh = ""
                }

                
                if let Giamocua = items[11] as? NSNumber {
                    modelhangTaxi.Giamocua = Giamocua
                } else {
                    modelhangTaxi.Giamocua = 0
                }

                
                if let Giakmdau = items[12] as? NSNumber {
                    modelhangTaxi.Giakmdau = Giakmdau
                } else {
                    modelhangTaxi.Giakmdau = 0
                }
                
                if let Giakmsau = items[13] as? NSNumber {
                    modelhangTaxi.Giakmsau = Giakmsau
                } else {
                    modelhangTaxi.Giakmsau = 0
                }
                
                if let Khoanggia7cho = items[14] as? NSNumber {
                    modelhangTaxi.Khoanggia7cho = Khoanggia7cho
                } else {
                    modelhangTaxi.Khoanggia7cho = 0
                }
                
                if let Giamocua7 = items[15] as? NSNumber {
                    modelhangTaxi.Giamocua7 = Giamocua7
                } else {
                    modelhangTaxi.Giamocua7 = 0
                }
                
                if let Giakmdau7 = items[16] as? NSNumber {
                    modelhangTaxi.Giakmdau7 = Giakmdau7
                } else {
                    modelhangTaxi.Giakmdau7 = 0
                }
                
                if let Giakmsau7 = items[17] as? NSNumber {
                    modelhangTaxi.Giakmsau7 = Giakmsau7
                } else {
                    modelhangTaxi.Giakmsau7 = 0
                }
                
                danhSachHangTaix.append(modelhangTaxi)
            }
            
            return danhSachHangTaix
        }catch let errHangTaxi{
            print("layDanhSachHangTaxi", errHangTaxi)
            return danhSachHangTaix
        }
        
    }
    
    
    func layDanhSachHangTaxiGiaRe(idTinhThanh:String) -> [HangTaxiModel]{
        var danhSachHangTaix = [HangTaxiModel]()
        
        do{
            
            for items in try(db?.prepare("select * from (select * from tbHangTaxi where MaTinhthanh = '\(idTinhThanh)') ORDER BY  Giakmdau ASC"))!{
                let modelhangTaxi = HangTaxiModel()
                
                if let Mahangtaxi = items[0] as? String {
                    modelhangTaxi.Mahangtaxi = Mahangtaxi
                } else {
                    modelhangTaxi.Mahangtaxi = ""
                }
                
                if let Tenhangtaxi = items[1] as? String {
                    modelhangTaxi.Tenhangtaxi = Tenhangtaxi
                } else {
                    modelhangTaxi.Tenhangtaxi = ""
                }
                
                if let Sodienthoai = items[2] as? String {
                    modelhangTaxi.Sodienthoai = Sodienthoai
                } else {
                    modelhangTaxi.Sodienthoai = ""
                }
                
                
                if let Sodienthoai2 = items[3] as? String {
                    modelhangTaxi.Sodienthoai2 = Sodienthoai2
                } else {
                    modelhangTaxi.Sodienthoai2 = ""
                }
                
                if let Diachi = items[4] as? String {
                    modelhangTaxi.Diachi = Diachi
                } else {
                    modelhangTaxi.Diachi = ""
                }
                
                if let Website = items[5] as? String {
                    modelhangTaxi.Website = Website
                } else {
                    modelhangTaxi.Website = ""
                }
                
                if let Khoanggia = items[6] as? String {
                    modelhangTaxi.Khoanggia = Khoanggia
                } else {
                    modelhangTaxi.Khoanggia = ""
                }
                
                if let Facebook = items[7] as? String {
                    modelhangTaxi.Facebook = Facebook
                } else {
                    modelhangTaxi.Facebook = ""
                }
                
                if let MaTinhthanh = items[8] as? String {
                    modelhangTaxi.MaTinhthanh = MaTinhthanh
                } else {
                    modelhangTaxi.MaTinhthanh = ""
                }
                
                if let Rate = items[9] as? NSNumber {
                    modelhangTaxi.Rate = Rate
                } else {
                    modelhangTaxi.Rate = 0
                }
                
                if let Hinhanh = items[10] as? String {
                    modelhangTaxi.Hinhanh = Hinhanh
                } else {
                    modelhangTaxi.Hinhanh = ""
                }
                
                
                if let Giamocua = items[11] as? NSNumber {
                    modelhangTaxi.Giamocua = Giamocua
                } else {
                    modelhangTaxi.Giamocua = 0
                }
                
                
                if let Giakmdau = items[12] as? NSNumber {
                    modelhangTaxi.Giakmdau = Giakmdau
                } else {
                    modelhangTaxi.Giakmdau = 0
                }
                
                if let Giakmsau = items[13] as? NSNumber {
                    modelhangTaxi.Giakmsau = Giakmsau
                } else {
                    modelhangTaxi.Giakmsau = 0
                }
                
                if let Khoanggia7cho = items[14] as? NSNumber {
                    modelhangTaxi.Khoanggia7cho = Khoanggia7cho
                } else {
                    modelhangTaxi.Khoanggia7cho = 0
                }
                
                if let Giamocua7 = items[15] as? NSNumber {
                    modelhangTaxi.Giamocua7 = Giamocua7
                } else {
                    modelhangTaxi.Giamocua7 = 0
                }
                
                if let Giakmdau7 = items[16] as? NSNumber {
                    modelhangTaxi.Giakmdau7 = Giakmdau7
                } else {
                    modelhangTaxi.Giakmdau7 = 0
                }
                
                if let Giakmsau7 = items[17] as? NSNumber {
                    modelhangTaxi.Giakmsau7 = Giakmsau7
                } else {
                    modelhangTaxi.Giakmsau7 = 0
                }
                
                danhSachHangTaix.append(modelhangTaxi)
            }
            
            return danhSachHangTaix
        }catch let errHangTaxi{
            print("layDanhSachHangTaxi", errHangTaxi)
            return danhSachHangTaix
        }
        
    }
    
    
    
    func layDanhSachHangTaxiDanhGiaTotNhat(idTinhThanh:String) -> [HangTaxiModel]{
        var danhSachHangTaix = [HangTaxiModel]()
        
        do{
            
            for items in try(db?.prepare("select * from (select * from tbHangTaxi where MaTinhthanh = '\(idTinhThanh)') ORDER BY  Rate DESC"))!{
                let modelhangTaxi = HangTaxiModel()
                
                if let Mahangtaxi = items[0] as? String {
                    modelhangTaxi.Mahangtaxi = Mahangtaxi
                } else {
                    modelhangTaxi.Mahangtaxi = ""
                }
                
                if let Tenhangtaxi = items[1] as? String {
                    modelhangTaxi.Tenhangtaxi = Tenhangtaxi
                } else {
                    modelhangTaxi.Tenhangtaxi = ""
                }
                
                if let Sodienthoai = items[2] as? String {
                    modelhangTaxi.Sodienthoai = Sodienthoai
                } else {
                    modelhangTaxi.Sodienthoai = ""
                }
                
                
                if let Sodienthoai2 = items[3] as? String {
                    modelhangTaxi.Sodienthoai2 = Sodienthoai2
                } else {
                    modelhangTaxi.Sodienthoai2 = ""
                }
                
                if let Diachi = items[4] as? String {
                    modelhangTaxi.Diachi = Diachi
                } else {
                    modelhangTaxi.Diachi = ""
                }
                
                if let Website = items[5] as? String {
                    modelhangTaxi.Website = Website
                } else {
                    modelhangTaxi.Website = ""
                }
                
                if let Khoanggia = items[6] as? String {
                    modelhangTaxi.Khoanggia = Khoanggia
                } else {
                    modelhangTaxi.Khoanggia = ""
                }
                
                if let Facebook = items[7] as? String {
                    modelhangTaxi.Facebook = Facebook
                } else {
                    modelhangTaxi.Facebook = ""
                }
                
                if let MaTinhthanh = items[8] as? String {
                    modelhangTaxi.MaTinhthanh = MaTinhthanh
                } else {
                    modelhangTaxi.MaTinhthanh = ""
                }
                
                if let Rate = items[9] as? NSNumber {
                    modelhangTaxi.Rate = Rate
                } else {
                    modelhangTaxi.Rate = 0
                }
                
                if let Hinhanh = items[10] as? String {
                    modelhangTaxi.Hinhanh = Hinhanh
                } else {
                    modelhangTaxi.Hinhanh = ""
                }
                
                
                if let Giamocua = items[11] as? NSNumber {
                    modelhangTaxi.Giamocua = Giamocua
                } else {
                    modelhangTaxi.Giamocua = 0
                }
                
                
                if let Giakmdau = items[12] as? NSNumber {
                    modelhangTaxi.Giakmdau = Giakmdau
                } else {
                    modelhangTaxi.Giakmdau = 0
                }
                
                if let Giakmsau = items[13] as? NSNumber {
                    modelhangTaxi.Giakmsau = Giakmsau
                } else {
                    modelhangTaxi.Giakmsau = 0
                }
                
                if let Khoanggia7cho = items[14] as? NSNumber {
                    modelhangTaxi.Khoanggia7cho = Khoanggia7cho
                } else {
                    modelhangTaxi.Khoanggia7cho = 0
                }
                
                if let Giamocua7 = items[15] as? NSNumber {
                    modelhangTaxi.Giamocua7 = Giamocua7
                } else {
                    modelhangTaxi.Giamocua7 = 0
                }
                
                if let Giakmdau7 = items[16] as? NSNumber {
                    modelhangTaxi.Giakmdau7 = Giakmdau7
                } else {
                    modelhangTaxi.Giakmdau7 = 0
                }
                
                if let Giakmsau7 = items[17] as? NSNumber {
                    modelhangTaxi.Giakmsau7 = Giakmsau7
                } else {
                    modelhangTaxi.Giakmsau7 = 0
                }
                
                danhSachHangTaix.append(modelhangTaxi)
            }
            
            return danhSachHangTaix
        }catch let errHangTaxi{
            print("layDanhSachHangTaxi", errHangTaxi)
            return danhSachHangTaix
        }
        
    }
    
    
    func themNguoiDung(modelNguoiDung:ModelNguoiDung){
        do{
            try db?.run("DELETE FROM tbNguoiDung")
            try db?.run("INSERT INTO tbNguoiDung (Manguoidung, Tennguoidung, Sodienthoai, Email, Facebook, Ngaysinh, Password) VALUES ('\(modelNguoiDung.Manguoidung!)', '\(modelNguoiDung.Tennguoidung!)', '\(modelNguoiDung.Sodienthoai!)', '\(modelNguoiDung.Email!)', '\(modelNguoiDung.Facebook!)', '\(modelNguoiDung.Ngaysinh!)', '\(modelNguoiDung.Password!)')")
        
        }catch let err {
            print("themNguoiDung", err)
        }
    }
    
    func thongTinNguoiDung() -> ModelNguoiDung {
        do{
            let modelNguoiDung = ModelNguoiDung()
            
            for items in  try (db?.prepare("SELECT * FROM tbNguoiDung LIMIT 1"))! {
                
                if let ma = items[0] as? String {
                    modelNguoiDung.Manguoidung = ma
                } else {
                    modelNguoiDung.Manguoidung = ""
                }
                
                if let ten = items[1] as? String {
                    modelNguoiDung.Tennguoidung = ten
                } else {
                    modelNguoiDung.Tennguoidung = ""
                }
                
                if let sdt = items[2] as? String {
                    modelNguoiDung.Sodienthoai = sdt
                } else {
                    modelNguoiDung.Sodienthoai = ""
                }
                
                if let e = items[3] as? String {
                    modelNguoiDung.Email = e
                } else {
                    modelNguoiDung.Email = ""
                }
                
                if let f = items[4] as? String {
                    modelNguoiDung.Facebook = f
                } else {
                    modelNguoiDung.Facebook = ""
                }
                
                if let n = items[5] as? String {
                    modelNguoiDung.Ngaysinh = n
                } else {
                    modelNguoiDung.Ngaysinh = ""
                }
                if let p = items[6] as? String {
                    modelNguoiDung.Password = p
                } else {
                    modelNguoiDung.Password = ""
                }
            }
            
            return modelNguoiDung
        
        }catch let err {
            
            print("thongTinNguoiDung: \(err)")
            return ModelNguoiDung()
        }
    }
    
    
   func themDanhSachTinhThanh(modelTinhThanh:TinhThanhModel){
        do{
            if modelTinhThanh.maTinhThanh != nil && modelTinhThanh.tenTinhThanh != nil {
                try db?.run("INSERT INTO \(tbTinhThanh) (MaTinhthanh, Tentinhthanh) VALUES ('\(modelTinhThanh.maTinhThanh!)', '\(modelTinhThanh.tenTinhThanh!)')")
            }
            
            
        }catch let errThemTinhThanh{
            print("themDanhSachTinhThanh", errThemTinhThanh)
//            if modelTinhThanh.maTinhThanh != nil && modelTinhThanh.tenTinhThanh != nil {
//                try! db?.run("UPDATE \(tbTinhThanh) SET Tentinhthanh = '\(modelTinhThanh.tenTinhThanh!)' WHERE MaTinhthanh = '\(modelTinhThanh.maTinhThanh!)'")
//            }
        }
    }
    
    func themHangTaxi(modelHangTaxi:HangTaxiModel){
        do{
            try db?.run("INSERT INTO \(tbHangTaxi) (Mahangtaxi, Tenhangtaxi, Sodienthoai, Sodienthoai2, Diachi, Website, Khoanggia, Facebook, MaTinhthanh, Rate, Hinhanh, Giamocua, Giakmdau, Giakmsau, Khoanggia7cho, Giamocua7, Giakmdau7, Giakmsau7) VALUES('\(modelHangTaxi.Mahangtaxi!)', '\(modelHangTaxi.Tenhangtaxi!)','\(modelHangTaxi.Sodienthoai!)','\(modelHangTaxi.Sodienthoai2!)','\(modelHangTaxi.Diachi!)','\(modelHangTaxi.Website!)','\(modelHangTaxi.Khoanggia!)','\(modelHangTaxi.Facebook!)','\(modelHangTaxi.MaTinhthanh!)','\(modelHangTaxi.Rate!)','\(modelHangTaxi.Hinhanh!)','\(modelHangTaxi.Giamocua!)','\(modelHangTaxi.Giakmdau!)','\(modelHangTaxi.Giakmsau!)', '\(modelHangTaxi.Khoanggia7cho!)', '\(modelHangTaxi.Giamocua7!)', '\(modelHangTaxi.Giakmdau7!)', '\(modelHangTaxi.Giakmsau7!)')")
        }catch let errHang{
            
            print("themHangTaxi", errHang)
 
        }
    }
    
    func themHangTaxiYeuThich(modelHangTaxi:HangTaxiModel){
        do{
           // try db?.run("DELETE FROM \(tbHangTaxiYeuThich)")
            try db?.run("INSERT INTO \(tbHangTaxiYeuThich) (Mahangtaxi, Tenhangtaxi, Sodienthoai, Sodienthoai2, Diachi, Website, Khoanggia, Facebook, MaTinhthanh, Rate, Hinhanh, Giamocua, Giakmdau, Giakmsau, Khoanggia7cho, Giamocua7, Giakmdau7, Giakmsau7) VALUES('\(modelHangTaxi.Mahangtaxi!)', '\(modelHangTaxi.Tenhangtaxi!)','\(modelHangTaxi.Sodienthoai!)','\(modelHangTaxi.Sodienthoai2!)','\(modelHangTaxi.Diachi!)','\(modelHangTaxi.Website!)','\(modelHangTaxi.Khoanggia!)','\(modelHangTaxi.Facebook!)','\(modelHangTaxi.MaTinhthanh!)','\(modelHangTaxi.Rate!)','\(modelHangTaxi.Hinhanh!)','\(modelHangTaxi.Giamocua!)','\(modelHangTaxi.Giakmdau!)','\(modelHangTaxi.Giakmsau!)', '\(modelHangTaxi.Khoanggia7cho!)', '\(modelHangTaxi.Giamocua7!)', '\(modelHangTaxi.Giakmdau7!)', '\(modelHangTaxi.Giakmsau7!)')")
        }catch let errHang{
            
            print("themHangTaxiYeuThich", errHang)
            
        }
    }
    
}

//
//  HangTaxiModel.swift
//  HiTaxi
//
//  Created by Nong Than on 2/14/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import UIKit

class HangTaxiModel:NSObject {
    var Mahangtaxi:String?
    var Tenhangtaxi:String?
    var Sodienthoai:String?
    var Sodienthoai2:String?
    var Diachi:String?
    var Website:String?
    var Khoanggia:String?
    var Facebook:String?
    var MaTinhthanh:String?
    var Rate:NSNumber?
    var Hinhanh:String?
    var Giamocua:NSNumber?
    var Giakmdau:NSNumber?
    var Giakmsau:NSNumber?
    var Khoanggia7cho: NSNumber?
    var Giamocua7: NSNumber?
    var Giakmdau7: NSNumber?
    var Giakmsau7: NSNumber?
    
    
    static var classTrangChu:TrangChu?
    
    static func LayDanhSachHangTaxi(_ danhSachHangTaxi:@escaping ([HangTaxiModel]) -> Void){
    
        URLSession.shared.dataTask(with: URL(string: UrlLinkHangTaxi)!) { (data, response, error) in
            if error != nil {
                
                DispatchQueue.main.sync(execute: {
                    danhSachHangTaxi(SQLiteConfig().layDanhSachHangTaxi())
                })
                
                print(error!)
                return
            }
            if data?.count != 0 {
                do {
                    let jsonDanhSachTaxi = try (JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                    
                     var listHangTaxi = [HangTaxiModel]()
                    
                    for item in jsonDanhSachTaxi as! [[String:NSObject]]{
                        let hangTaxi = HangTaxiModel()
                        
                        if let Mahangtaxi = item["Mahangtaxi"] as? String {
                            hangTaxi.Mahangtaxi = Mahangtaxi
                        } else {
                            hangTaxi.Mahangtaxi = ""
                        }
                        if let Tenhangtaxi = item["Tenhangtaxi"] as? String {
                            hangTaxi.Tenhangtaxi = Tenhangtaxi
                        } else {
                            hangTaxi.Tenhangtaxi = ""
                        }
                        
                        if let Sodienthoai = item["Sodienthoai"] as? String {
                            hangTaxi.Sodienthoai = Sodienthoai
                        } else {
                            hangTaxi.Sodienthoai = ""
                        }
                        
                        if let Sodienthoai2 = item["Sodienthoai2"] as? String {
                            hangTaxi.Sodienthoai2 = Sodienthoai2
                        } else {
                            hangTaxi.Sodienthoai2 = ""
                        }
                        
                        if let Diachi = item["Diachi"] as? String {
                            hangTaxi.Diachi = Diachi
                        } else {
                            hangTaxi.Diachi = ""
                        }
                        
                        if let Website = item["Website"] as? String {
                            hangTaxi.Website = Website
                        } else {
                            hangTaxi.Website = ""
                        }
                        
                        if let Khoanggia = item["Khoanggia"] as? String {
                            hangTaxi.Khoanggia = Khoanggia
                        } else {
                            hangTaxi.Khoanggia = ""
                        }
                        
                        if let Facebook = item["Facebook"] as? String {
                            hangTaxi.Facebook = Facebook
                        } else {
                            hangTaxi.Facebook = ""
                        }
                        
                        if let MaTinhthanh = item["MaTinhthanh"] as? String {
                            hangTaxi.MaTinhthanh = MaTinhthanh
                        } else {
                            hangTaxi.MaTinhthanh = ""
                        }
                        
                        if let Rate = item["Rate"] as? NSNumber {
                            hangTaxi.Rate = Rate
                        } else {
                            hangTaxi.Rate = 0
                        }
                        
                        if let Hinhanh = item["Hinhanh"] as? String {
                            hangTaxi.Hinhanh = Hinhanh
                        } else {
                            hangTaxi.Hinhanh = ""
                        }
                        
                        if let Giamocua = item["Giamocua"] as? NSNumber {
                            hangTaxi.Giamocua = Giamocua
                        } else {
                            hangTaxi.Giamocua = 0
                        }
                        
                        if let Giakmdau = item["Giakmdau"] as? NSNumber {
                            hangTaxi.Giakmdau = Giakmdau
                        } else {
                            hangTaxi.Giakmdau = 0
                        }
                        
                        if let Giakmsau = item["Giakmsau"] as? NSNumber {
                            hangTaxi.Giakmsau = Giakmsau
                        } else {
                            hangTaxi.Giakmsau = 0
                        }
//                        
//                        var Khoanggia7cho: NSNumber?
//                        var Giamocua7: NSNumber?
//                        var Giakmdau7: NSNumber?
//                        var Giakmsau7: NSNumber?
                        
                        if let Khoanggia7cho = item["Khoanggia7cho"] as? NSNumber {
                            hangTaxi.Khoanggia7cho = Khoanggia7cho
                        } else {
                            hangTaxi.Khoanggia7cho = 0
                        }
                        
                        
                        if let Giamocua7 = item["Giamocua7"] as? NSNumber {
                            hangTaxi.Giamocua7 = Giamocua7
                        } else {
                            hangTaxi.Giamocua7 = 0
                        }
                        
                        if let Giakmdau7 = item["Giakmdau7"] as? NSNumber {
                            hangTaxi.Giakmdau7 = Giakmdau7
                        } else {
                            hangTaxi.Giakmdau7 = 0
                        }
                        
                        if let Giakmsau7 = item["Giakmsau7"] as? NSNumber {
                            hangTaxi.Giakmsau7 = Giakmsau7
                        } else {
                            hangTaxi.Giakmsau7 = 0
                        }
                        
                        
                        listHangTaxi.append(hangTaxi)
                        SQLiteConfig().themHangTaxi(modelHangTaxi: hangTaxi)
                        
                    }
                    
                    DispatchQueue.main.sync(execute: { 
                        danhSachHangTaxi(listHangTaxi)
                    })
                    
                }catch let err {
                    print(err)
                    
                    DispatchQueue.main.sync(execute: {
                        danhSachHangTaxi(SQLiteConfig().layDanhSachHangTaxi())
                    })
                }
            } else {
                
                print("Loi load data!")
                
                DispatchQueue.main.sync(execute: {
                    danhSachHangTaxi(SQLiteConfig().layDanhSachHangTaxi())
                })
            }
        }.resume()
        
    }
    
    static func TaxiDuocDanhGiaCaoNhat(s1:HangTaxiModel, s2:HangTaxiModel) -> Bool{
        return Float(s1.Rate!) > Float(s2.Rate!)
    }

    static func TaxiDuocDanhGiaReNhat(s1:HangTaxiModel, s2:HangTaxiModel) -> Bool{
        return Float(s1.Giakmdau!) < Float(s2.Giakmdau!)
    }
    
    static func TaxiDuocDanhGiaTeNhat(s1:HangTaxiModel, s2:HangTaxiModel) -> Bool{
        return Float(s1.Rate!) < Float(s2.Rate!)
    }
    
    static func XepTheoTen(s1:HangTaxiModel, s2:HangTaxiModel) -> Bool{
        return s1.Tenhangtaxi! > s2.Tenhangtaxi!
    }
    
    static func LayDanhSachHangTaxiTotNhat(_ danhSachHangTaxi:@escaping ([HangTaxiModel]) -> Void){
        
        URLSession.shared.dataTask(with: URL(string: UrlLinkHangTaxi)!) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.sync(execute: {
                    danhSachHangTaxi(SQLiteConfig().layDanhSachHangTaxi())
                })
                print(error!)
                return
            }
            if data?.count != 0 {
                do {
                    let jsonDanhSachTaxi = try (JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                    
                    var listHangTaxi = [HangTaxiModel]()
                   
                    for item in jsonDanhSachTaxi as! [[String:NSObject]]{
                        let hangTaxi = HangTaxiModel()
                        
                        if let Mahangtaxi = item["Mahangtaxi"] as? String {
                            hangTaxi.Mahangtaxi = Mahangtaxi
                        } else {
                            hangTaxi.Mahangtaxi = ""
                        }
                        if let Tenhangtaxi = item["Tenhangtaxi"] as? String {
                            hangTaxi.Tenhangtaxi = Tenhangtaxi
                        } else {
                            hangTaxi.Tenhangtaxi = ""
                        }
                        
                        if let Sodienthoai = item["Sodienthoai"] as? String {
                            hangTaxi.Sodienthoai = Sodienthoai
                        } else {
                            hangTaxi.Sodienthoai = ""
                        }
                        
                        if let Sodienthoai2 = item["Sodienthoai2"] as? String {
                            hangTaxi.Sodienthoai2 = Sodienthoai2
                        } else {
                            hangTaxi.Sodienthoai2 = ""
                        }
                        
                        if let Diachi = item["Diachi"] as? String {
                            hangTaxi.Diachi = Diachi
                        } else {
                            hangTaxi.Diachi = ""
                        }
                        
                        if let Website = item["Website"] as? String {
                            hangTaxi.Website = Website
                        } else {
                            hangTaxi.Website = ""
                        }
                        
                        if let Khoanggia = item["Khoanggia"] as? String {
                            hangTaxi.Khoanggia = Khoanggia
                        } else {
                            hangTaxi.Khoanggia = ""
                        }
                        
                        if let Facebook = item["Facebook"] as? String {
                            hangTaxi.Facebook = Facebook
                        } else {
                            hangTaxi.Facebook = ""
                        }
                        
                        if let MaTinhthanh = item["MaTinhthanh"] as? String {
                            hangTaxi.MaTinhthanh = MaTinhthanh
                        } else {
                            hangTaxi.MaTinhthanh = ""
                        }
                        
                        if let Rate = item["Rate"] as? NSNumber {
                            hangTaxi.Rate = Rate
                        } else {
                            hangTaxi.Rate = 0
                        }
                        
                        if let Hinhanh = item["Hinhanh"] as? String {
                            hangTaxi.Hinhanh = Hinhanh
                        } else {
                            hangTaxi.Hinhanh = ""
                        }
                        
                        if let Giamocua = item["Giamocua"] as? NSNumber {
                            hangTaxi.Giamocua = Giamocua
                        } else {
                            hangTaxi.Giamocua = 0
                        }
                        
                        if let Giakmdau = item["Giakmdau"] as? NSNumber {
                            hangTaxi.Giakmdau = Giakmdau
                        } else {
                            hangTaxi.Giakmdau = 0
                        }
                        
                        if let Giakmsau = item["Giakmsau"] as? NSNumber {
                            hangTaxi.Giakmsau = Giakmsau
                        } else {
                            hangTaxi.Giakmsau = 0
                        }
                        
                        if let Khoanggia7cho = item["Khoanggia7cho"] as? NSNumber {
                            hangTaxi.Khoanggia7cho = Khoanggia7cho
                        } else {
                            hangTaxi.Khoanggia7cho = 0
                        }
                        
                        
                        if let Giamocua7 = item["Giamocua7"] as? NSNumber {
                            hangTaxi.Giamocua7 = Giamocua7
                        } else {
                            hangTaxi.Giamocua7 = 0
                        }
                        
                        if let Giakmdau7 = item["Giakmdau7"] as? NSNumber {
                            hangTaxi.Giakmdau7 = Giakmdau7
                        } else {
                            hangTaxi.Giakmdau7 = 0
                        }
                        
                        if let Giakmsau7 = item["Giakmsau7"] as? NSNumber {
                            hangTaxi.Giakmsau7 = Giakmsau7
                        } else {
                            hangTaxi.Giakmsau7 = 0
                        }

                        
                        
                        listHangTaxi.append(hangTaxi)
                        SQLiteConfig().themHangTaxi(modelHangTaxi: hangTaxi)
                        
                    }
                    
                   // listHangTaxi.sort(by: XepTheoTen)
                    listHangTaxi.sort(by: TaxiDuocDanhGiaCaoNhat)
                   
                    
                    DispatchQueue.main.sync(execute: {
                        danhSachHangTaxi(listHangTaxi)
                    })
                    
                }catch let err {
                    
                    DispatchQueue.main.sync(execute: {
                        danhSachHangTaxi(SQLiteConfig().layDanhSachHangTaxi())
                    })
                    print(err)
                }
            } else {
                print("Loi load data!")
                DispatchQueue.main.sync(execute: {
                    danhSachHangTaxi(SQLiteConfig().layDanhSachHangTaxi())
                })
            }
            }.resume()
        
    }
    
    static func LayDanhSachHangTaxiReNhat(_ danhSachHangTaxi:@escaping ([HangTaxiModel]) -> Void){
        
        URLSession.shared.dataTask(with: URL(string: UrlLinkHangTaxi)!) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.sync(execute: {
                    danhSachHangTaxi(SQLiteConfig().layDanhSachHangTaxi())
                })
                print(error!)
                return
            }
            if data?.count != 0 {
                do {
                    let jsonDanhSachTaxi = try (JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                    
                    var listHangTaxi = [HangTaxiModel]()
                    
                    for item in jsonDanhSachTaxi as! [[String:NSObject]]{
                        let hangTaxi = HangTaxiModel()
                        
                        if let Mahangtaxi = item["Mahangtaxi"] as? String {
                            hangTaxi.Mahangtaxi = Mahangtaxi
                        } else {
                            hangTaxi.Mahangtaxi = ""
                        }
                        if let Tenhangtaxi = item["Tenhangtaxi"] as? String {
                            hangTaxi.Tenhangtaxi = Tenhangtaxi
                        } else {
                            hangTaxi.Tenhangtaxi = ""
                        }
                        
                        if let Sodienthoai = item["Sodienthoai"] as? String {
                            hangTaxi.Sodienthoai = Sodienthoai
                        } else {
                            hangTaxi.Sodienthoai = ""
                        }
                        
                        if let Sodienthoai2 = item["Sodienthoai2"] as? String {
                            hangTaxi.Sodienthoai2 = Sodienthoai2
                        } else {
                            hangTaxi.Sodienthoai2 = ""
                        }
                        
                        if let Diachi = item["Diachi"] as? String {
                            hangTaxi.Diachi = Diachi
                        } else {
                            hangTaxi.Diachi = ""
                        }
                        
                        if let Website = item["Website"] as? String {
                            hangTaxi.Website = Website
                        } else {
                            hangTaxi.Website = ""
                        }
                        
                        if let Khoanggia = item["Khoanggia"] as? String {
                            hangTaxi.Khoanggia = Khoanggia
                        } else {
                            hangTaxi.Khoanggia = ""
                        }
                        
                        if let Facebook = item["Facebook"] as? String {
                            hangTaxi.Facebook = Facebook
                        } else {
                            hangTaxi.Facebook = ""
                        }
                        
                        if let MaTinhthanh = item["MaTinhthanh"] as? String {
                            hangTaxi.MaTinhthanh = MaTinhthanh
                        } else {
                            hangTaxi.MaTinhthanh = ""
                        }
                        
                        if let Rate = item["Rate"] as? NSNumber {
                            hangTaxi.Rate = Rate
                        } else {
                            hangTaxi.Rate = 0
                        }
                        
                        if let Hinhanh = item["Hinhanh"] as? String {
                            hangTaxi.Hinhanh = Hinhanh
                        } else {
                            hangTaxi.Hinhanh = ""
                        }
                        
                        if let Giamocua = item["Giamocua"] as? NSNumber {
                            hangTaxi.Giamocua = Giamocua
                        } else {
                            hangTaxi.Giamocua = 0
                        }
                        
                        if let Giakmdau = item["Giakmdau"] as? NSNumber {
                            hangTaxi.Giakmdau = Giakmdau
                        } else {
                            hangTaxi.Giakmdau = 0
                        }
                        
                        if let Giakmsau = item["Giakmsau"] as? NSNumber {
                            hangTaxi.Giakmsau = Giakmsau
                        } else {
                            hangTaxi.Giakmsau = 0
                        }
                        
                        if let Khoanggia7cho = item["Khoanggia7cho"] as? NSNumber {
                            hangTaxi.Khoanggia7cho = Khoanggia7cho
                        } else {
                            hangTaxi.Khoanggia7cho = 0
                        }
                        
                        
                        if let Giamocua7 = item["Giamocua7"] as? NSNumber {
                            hangTaxi.Giamocua7 = Giamocua7
                        } else {
                            hangTaxi.Giamocua7 = 0
                        }
                        
                        if let Giakmdau7 = item["Giakmdau7"] as? NSNumber {
                            hangTaxi.Giakmdau7 = Giakmdau7
                        } else {
                            hangTaxi.Giakmdau7 = 0
                        }
                        
                        if let Giakmsau7 = item["Giakmsau7"] as? NSNumber {
                            hangTaxi.Giakmsau7 = Giakmsau7
                        } else {
                            hangTaxi.Giakmsau7 = 0
                        }

                        
                        
                        listHangTaxi.append(hangTaxi)
                        SQLiteConfig().themHangTaxi(modelHangTaxi: hangTaxi)
                        
                    }
                    
                    listHangTaxi.sort(by: TaxiDuocDanhGiaReNhat)
                    
                    
                    DispatchQueue.main.sync(execute: {
                        danhSachHangTaxi(listHangTaxi)
                    })
                    
                }catch let err {
                    print(err)
                    DispatchQueue.main.sync(execute: {
                        danhSachHangTaxi(SQLiteConfig().layDanhSachHangTaxi())
                    })
                }
            } else {
                print("Loi load data!")
                DispatchQueue.main.sync(execute: {
                    danhSachHangTaxi(SQLiteConfig().layDanhSachHangTaxi())
                })
            }
            }.resume()
        
    }
    
    
    static func LayDanhSachHangTaxiTeNhat(_ danhSachHangTaxi:@escaping ([HangTaxiModel]) -> Void){
        
        URLSession.shared.dataTask(with: URL(string: UrlLinkHangTaxi)!) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.sync(execute: {
                    danhSachHangTaxi(SQLiteConfig().layDanhSachHangTaxi())
                })
                print(error!)
                return
            }
            if data?.count != 0 {
                do {
                    let jsonDanhSachTaxi = try (JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                    
                    var listHangTaxi = [HangTaxiModel]()
                    
                    for item in jsonDanhSachTaxi as! [[String:NSObject]]{
                        let hangTaxi = HangTaxiModel()
                        
                        if let Mahangtaxi = item["Mahangtaxi"] as? String {
                            hangTaxi.Mahangtaxi = Mahangtaxi
                        } else {
                            hangTaxi.Mahangtaxi = ""
                        }
                        if let Tenhangtaxi = item["Tenhangtaxi"] as? String {
                            hangTaxi.Tenhangtaxi = Tenhangtaxi
                        } else {
                            hangTaxi.Tenhangtaxi = ""
                        }
                        
                        if let Sodienthoai = item["Sodienthoai"] as? String {
                            hangTaxi.Sodienthoai = Sodienthoai
                        } else {
                            hangTaxi.Sodienthoai = ""
                        }
                        
                        if let Sodienthoai2 = item["Sodienthoai2"] as? String {
                            hangTaxi.Sodienthoai2 = Sodienthoai2
                        } else {
                            hangTaxi.Sodienthoai2 = ""
                        }
                        
                        if let Diachi = item["Diachi"] as? String {
                            hangTaxi.Diachi = Diachi
                        } else {
                            hangTaxi.Diachi = ""
                        }
                        
                        if let Website = item["Website"] as? String {
                            hangTaxi.Website = Website
                        } else {
                            hangTaxi.Website = ""
                        }
                        
                        if let Khoanggia = item["Khoanggia"] as? String {
                            hangTaxi.Khoanggia = Khoanggia
                        } else {
                            hangTaxi.Khoanggia = ""
                        }
                        
                        if let Facebook = item["Facebook"] as? String {
                            hangTaxi.Facebook = Facebook
                        } else {
                            hangTaxi.Facebook = ""
                        }
                        
                        if let MaTinhthanh = item["MaTinhthanh"] as? String {
                            hangTaxi.MaTinhthanh = MaTinhthanh
                        } else {
                            hangTaxi.MaTinhthanh = ""
                        }
                        
                        if let Rate = item["Rate"] as? NSNumber {
                            hangTaxi.Rate = Rate
                        } else {
                            hangTaxi.Rate = 0
                        }
                        
                        if let Hinhanh = item["Hinhanh"] as? String {
                            hangTaxi.Hinhanh = Hinhanh
                        } else {
                            hangTaxi.Hinhanh = ""
                        }
                        
                        if let Giamocua = item["Giamocua"] as? NSNumber {
                            hangTaxi.Giamocua = Giamocua
                        } else {
                            hangTaxi.Giamocua = 0
                        }
                        
                        if let Giakmdau = item["Giakmdau"] as? NSNumber {
                            hangTaxi.Giakmdau = Giakmdau
                        } else {
                            hangTaxi.Giakmdau = 0
                        }
                        
                        if let Giakmsau = item["Giakmsau"] as? NSNumber {
                            hangTaxi.Giakmsau = Giakmsau
                        } else {
                            hangTaxi.Giakmsau = 0
                        }
                        
                        if let Khoanggia7cho = item["Khoanggia7cho"] as? NSNumber {
                            hangTaxi.Khoanggia7cho = Khoanggia7cho
                        } else {
                            hangTaxi.Khoanggia7cho = 0
                        }
                        
                        
                        if let Giamocua7 = item["Giamocua7"] as? NSNumber {
                            hangTaxi.Giamocua7 = Giamocua7
                        } else {
                            hangTaxi.Giamocua7 = 0
                        }
                        
                        if let Giakmdau7 = item["Giakmdau7"] as? NSNumber {
                            hangTaxi.Giakmdau7 = Giakmdau7
                        } else {
                            hangTaxi.Giakmdau7 = 0
                        }
                        
                        if let Giakmsau7 = item["Giakmsau7"] as? NSNumber {
                            hangTaxi.Giakmsau7 = Giakmsau7
                        } else {
                            hangTaxi.Giakmsau7 = 0
                        }

                        
                        
                        listHangTaxi.append(hangTaxi)
                        SQLiteConfig().themHangTaxi(modelHangTaxi: hangTaxi)
                        
                    }
                    
                    listHangTaxi.sort(by: TaxiDuocDanhGiaTeNhat)
                    
                    
                    DispatchQueue.main.sync(execute: {
                        danhSachHangTaxi(listHangTaxi)
                    })
                    
                }catch let err {
                    print(err)
                    DispatchQueue.main.sync(execute: {
                        danhSachHangTaxi(SQLiteConfig().layDanhSachHangTaxi())
                    })
                }
            } else {
                print("Loi load data!")
                DispatchQueue.main.sync(execute: {
                    danhSachHangTaxi(SQLiteConfig().layDanhSachHangTaxi())
                })
            }
            }.resume()
        
    }
    
    
    static func DanhGiaTaxi(modelHangDanhGia:NSDictionary){
        
        let request = NSMutableURLRequest(url: URL(string: UrlLinkDanhGia)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try! JSONSerialization.data(withJSONObject: modelHangDanhGia, options: [])
        
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if error != nil {
                print("DanhGiaTaxi", error!)
                return
            }
            
            let httpStatus = response as! HTTPURLResponse
            
            if httpStatus.statusCode == 201 {
                
            }
            
            
        }.resume()
    }

    static func ThemTaxiYeuThich(modelHangYeuThic:NSDictionary){
        
        let request = NSMutableURLRequest(url: URL(string: UrlLinkYeuThich)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try! JSONSerialization.data(withJSONObject: modelHangYeuThic, options: [])
        
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if error != nil {
                print("modelHangYeuThic", error!)
                return
            }
            
            let httpStatus = response as! HTTPURLResponse
            
            if httpStatus.statusCode == 201 {
                DispatchQueue.main.sync {
                    
                    HangTaxiModel.classTrangChu?.ThongBaoCustom(noiDung: "Thêm yêu thích thành công!")
                }
            } else {
                DispatchQueue.main.sync {
                 HangTaxiModel.classTrangChu?.ThongBaoCustom(noiDung: "Taxi này đã có trong danh sách yêu thích của bạn!")
                    }
                
            }
            
            
            }.resume()
    }
    
    
    static func LayDanhSachHangTaxiYeuThich(idNguoiDung:String, _ danhSachHangTaxiYeuThich:@escaping ([HangTaxiModel]) -> Void){
        
        URLSession.shared.dataTask(with: URL(string: linkHangTaxiYeuThich(maNguoiDung: idNguoiDung))!) { (data, response, error) in
            if error != nil {
                
             
                print(error!)
                return
            }
            if data?.count != 0 {
                do {
                    let jsonDanhSachTaxi = try (JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                    
                    var listHangTaxi = [HangTaxiModel]()
                    
                    for item in jsonDanhSachTaxi as! [[String:NSObject]]{
                        let hangTaxi = HangTaxiModel()
                        
                        if let Mahangtaxi = item["Mahangtaxi"] as? String {
                            hangTaxi.Mahangtaxi = Mahangtaxi
                        } else {
                            hangTaxi.Mahangtaxi = ""
                        }
                        if let Tenhangtaxi = item["Tenhangtaxi"] as? String {
                            hangTaxi.Tenhangtaxi = Tenhangtaxi
                        } else {
                            hangTaxi.Tenhangtaxi = ""
                        }
                        
                        if let Sodienthoai = item["Sodienthoai"] as? String {
                            hangTaxi.Sodienthoai = Sodienthoai
                        } else {
                            hangTaxi.Sodienthoai = ""
                        }
                        
                        if let Sodienthoai2 = item["Sodienthoai2"] as? String {
                            hangTaxi.Sodienthoai2 = Sodienthoai2
                        } else {
                            hangTaxi.Sodienthoai2 = ""
                        }
                        
                        if let Diachi = item["Diachi"] as? String {
                            hangTaxi.Diachi = Diachi
                        } else {
                            hangTaxi.Diachi = ""
                        }
                        
                        if let Website = item["Website"] as? String {
                            hangTaxi.Website = Website
                        } else {
                            hangTaxi.Website = ""
                        }
                        
                        if let Khoanggia = item["Khoanggia"] as? String {
                            hangTaxi.Khoanggia = Khoanggia
                        } else {
                            hangTaxi.Khoanggia = ""
                        }
                        
                        if let Facebook = item["Facebook"] as? String {
                            hangTaxi.Facebook = Facebook
                        } else {
                            hangTaxi.Facebook = ""
                        }
                        
                        if let MaTinhthanh = item["MaTinhthanh"] as? String {
                            hangTaxi.MaTinhthanh = MaTinhthanh
                        } else {
                            hangTaxi.MaTinhthanh = ""
                        }
                        
                        if let Rate = item["Rate"] as? NSNumber {
                            hangTaxi.Rate = Rate
                        } else {
                            hangTaxi.Rate = 0
                        }
                        
                        if let Hinhanh = item["Hinhanh"] as? String {
                            hangTaxi.Hinhanh = Hinhanh
                        } else {
                            hangTaxi.Hinhanh = ""
                        }
                        
                        if let Giamocua = item["Giamocua"] as? NSNumber {
                            hangTaxi.Giamocua = Giamocua
                        } else {
                            hangTaxi.Giamocua = 0
                        }
                        
                        if let Giakmdau = item["Giakmdau"] as? NSNumber {
                            hangTaxi.Giakmdau = Giakmdau
                        } else {
                            hangTaxi.Giakmdau = 0
                        }
                        
                        if let Giakmsau = item["Giakmsau"] as? NSNumber {
                            hangTaxi.Giakmsau = Giakmsau
                        } else {
                            hangTaxi.Giakmsau = 0
                        }
                        
                        
                        if let Khoanggia7cho = item["Khoanggia7cho"] as? NSNumber {
                            hangTaxi.Khoanggia7cho = Khoanggia7cho
                        } else {
                            hangTaxi.Khoanggia7cho = 0
                        }
                        
                        
                        if let Giamocua7 = item["Giamocua7"] as? NSNumber {
                            hangTaxi.Giamocua7 = Giamocua7
                        } else {
                            hangTaxi.Giamocua7 = 0
                        }
                        
                        if let Giakmdau7 = item["Giakmdau7"] as? NSNumber {
                            hangTaxi.Giakmdau7 = Giakmdau7
                        } else {
                            hangTaxi.Giakmdau7 = 0
                        }
                        
                        if let Giakmsau7 = item["Giakmsau7"] as? NSNumber {
                            hangTaxi.Giakmsau7 = Giakmsau7
                        } else {
                            hangTaxi.Giakmsau7 = 0
                        }

                        
                        listHangTaxi.append(hangTaxi)
                        
                    }
                    
                  //  listHangTaxi.sort(by: TaxiDuocDanhGiaTeNhat)
                    
                    
                    DispatchQueue.main.sync(execute: {
                        danhSachHangTaxiYeuThich(listHangTaxi)
                    })
                    
                }catch let err {
                    print(err)
                }
            } else {
                print("Loi load data!")
            }
            }.resume()
        
    }
    
    
    static func LayDanhSachHangTaxiTheoTinhThanh(idTinhThanh:String, _ danhSachHangTaxi:@escaping ([HangTaxiModel]) -> Void){
        
        URLSession.shared.dataTask(with: URL(string: UrlLinkHangTaxi + idTinhThanh)!) { (data, response, error) in
            if error != nil {
                
                DispatchQueue.main.sync(execute: {
                    danhSachHangTaxi(SQLiteConfig().layDanhSachHangTaxiTheoTinhThanh(maTinhThanh: idTinhThanh))
                })
                
                print(error!)
                return
            }
            if data?.count != 0 {
                do {
                    let jsonDanhSachTaxi = try (JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                    
                    var listHangTaxi = [HangTaxiModel]()
                    
                    for item in jsonDanhSachTaxi as! [[String:NSObject]]{
                        let hangTaxi = HangTaxiModel()
                        
                        if let Mahangtaxi = item["Mahangtaxi"] as? String {
                            hangTaxi.Mahangtaxi = Mahangtaxi
                        } else {
                            hangTaxi.Mahangtaxi = ""
                        }
                        if let Tenhangtaxi = item["Tenhangtaxi"] as? String {
                            hangTaxi.Tenhangtaxi = Tenhangtaxi
                        } else {
                            hangTaxi.Tenhangtaxi = ""
                        }
                        
                        if let Sodienthoai = item["Sodienthoai"] as? String {
                            hangTaxi.Sodienthoai = Sodienthoai
                        } else {
                            hangTaxi.Sodienthoai = ""
                        }
                        
                        if let Sodienthoai2 = item["Sodienthoai2"] as? String {
                            hangTaxi.Sodienthoai2 = Sodienthoai2
                        } else {
                            hangTaxi.Sodienthoai2 = ""
                        }
                        
                        if let Diachi = item["Diachi"] as? String {
                            hangTaxi.Diachi = Diachi
                        } else {
                            hangTaxi.Diachi = ""
                        }
                        
                        if let Website = item["Website"] as? String {
                            hangTaxi.Website = Website
                        } else {
                            hangTaxi.Website = ""
                        }
                        
                        if let Khoanggia = item["Khoanggia"] as? String {
                            hangTaxi.Khoanggia = Khoanggia
                        } else {
                            hangTaxi.Khoanggia = ""
                        }
                        
                        if let Facebook = item["Facebook"] as? String {
                            hangTaxi.Facebook = Facebook
                        } else {
                            hangTaxi.Facebook = ""
                        }
                        
                        if let MaTinhthanh = item["MaTinhthanh"] as? String {
                            hangTaxi.MaTinhthanh = MaTinhthanh
                        } else {
                            hangTaxi.MaTinhthanh = ""
                        }
                        
                        if let Rate = item["Rate"] as? NSNumber {
                            hangTaxi.Rate = Rate
                        } else {
                            hangTaxi.Rate = 0
                        }
                        
                        if let Hinhanh = item["Hinhanh"] as? String {
                            hangTaxi.Hinhanh = Hinhanh
                        } else {
                            hangTaxi.Hinhanh = ""
                        }
                        
                        if let Giamocua = item["Giamocua"] as? NSNumber {
                            hangTaxi.Giamocua = Giamocua
                        } else {
                            hangTaxi.Giamocua = 0
                        }
                        
                        if let Giakmdau = item["Giakmdau"] as? NSNumber {
                            hangTaxi.Giakmdau = Giakmdau
                        } else {
                            hangTaxi.Giakmdau = 0
                        }
                        
                        if let Giakmsau = item["Giakmsau"] as? NSNumber {
                            hangTaxi.Giakmsau = Giakmsau
                        } else {
                            hangTaxi.Giakmsau = 0
                        }
                        
                        if let Khoanggia7cho = item["Khoanggia7cho"] as? NSNumber {
                            hangTaxi.Khoanggia7cho = Khoanggia7cho
                        } else {
                            hangTaxi.Khoanggia7cho = 0
                        }
                        
                        
                        if let Giamocua7 = item["Giamocua7"] as? NSNumber {
                            hangTaxi.Giamocua7 = Giamocua7
                        } else {
                            hangTaxi.Giamocua7 = 0
                        }
                        
                        if let Giakmdau7 = item["Giakmdau7"] as? NSNumber {
                            hangTaxi.Giakmdau7 = Giakmdau7
                        } else {
                            hangTaxi.Giakmdau7 = 0
                        }
                        
                        if let Giakmsau7 = item["Giakmsau7"] as? NSNumber {
                            hangTaxi.Giakmsau7 = Giakmsau7
                        } else {
                            hangTaxi.Giakmsau7 = 0
                        }

                        
                        
                        listHangTaxi.append(hangTaxi)
                        
                    }
                    
                    //  listHangTaxi.sort(by: TaxiDuocDanhGiaTeNhat)
                    
                    
                    DispatchQueue.main.sync(execute: {
                        danhSachHangTaxi(listHangTaxi)
                    })
                    
                }catch let err {
                    print(err)
                    DispatchQueue.main.sync(execute: {
                        danhSachHangTaxi(SQLiteConfig().layDanhSachHangTaxiTheoTinhThanh(maTinhThanh: idTinhThanh))
                    })
                }
            } else {
                print("Loi load data!")
                DispatchQueue.main.sync(execute: {
                    danhSachHangTaxi(SQLiteConfig().layDanhSachHangTaxiTheoTinhThanh(maTinhThanh: idTinhThanh))
                })
            }
            }.resume()
        
    }
    
}

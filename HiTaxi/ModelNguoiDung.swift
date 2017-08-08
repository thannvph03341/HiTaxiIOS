//
//  ModelNguoiDung.swift
//  HiTaxi
//
//  Created by Nong Than on 4/23/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import UIKit

class ModelNguoiDung:NSObject {

    var Manguoidung:String?
    var Tennguoidung:String?
    var Sodienthoai:String?
    var Email:String?
    var Facebook:String?
    var Ngaysinh:String?
    var Password:String?
    
    override func setValue(_ value: Any?, forKey key: String) {
        switch key {
        case "Manguoidung":
            Manguoidung = value as? String
            break
        case "Tennguoidung":
            Tennguoidung = value as? String
            break
            
        case "Sodienthoai":
            Sodienthoai = value as? String
            break
        case "Email":
            Email = value as? String
            break
        case "Facebook":
            Facebook = value as? String
            break
        case "Ngaysinh":
            Ngaysinh = value as? String
            break
        case "Password":
            Password = value as? String
            break
        default:
            break
        }
    }
    
    
    static func UpdataThongTin(thongTinUser:ModelNguoiDung, status:@escaping (String) -> Void){
        
        let request = NSMutableURLRequest(url: URL(string: UrlUpdataThongTin())!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try! JSONSerialization.data(withJSONObject: ["Manguoidung":thongTinUser.Manguoidung!, "Tennguoidung":thongTinUser.Tennguoidung!,"Sodienthoai": thongTinUser.Sodienthoai!, "Email":thongTinUser.Email!,"Facebook":thongTinUser.Facebook!,"Ngaysinh":thongTinUser.Ngaysinh!, "Password":")_&*()&*%^&%&*#$$^*(&$&%^%*(P"], options: [])

        URLSession.shared.dataTask(with: request as URLRequest) { (data, respon, error) in
            if error != nil {
                print("UpdataThongTin: \(error!)")
            }
            
            if (data?.count)! > 0 {
                let httstatus = respon as! HTTPURLResponse
                if httstatus.statusCode == 200 || httstatus.statusCode == 201 {
                    
                    do{
                    
                        let json = try(JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                        let dataUpdata = json as! [String:AnyObject]
                        
                        if let statusss = dataUpdata["responseText"]{
                            DispatchQueue.main.sync {
                                status("\(statusss)")
                                SQLiteConfig().themNguoiDung(modelNguoiDung: thongTinUser)
                            }
                        } else {
                            DispatchQueue.main.sync {
                                status("Cập nhật thông tin không thành công!")
                            }
                        }
                    }catch let err{
                        DispatchQueue.main.sync {
                            status("Cập nhật thông tin không thành công!")
                        }
                        print("UpdataThongTin: \(err)")
                    }
                } else {
                    DispatchQueue.main.sync {
                        status("Cập nhật thông tin không thành công!")
                    }
                }
            } else {
                DispatchQueue.main.sync {
                    status("Cập nhật thông tin không thành công!")
                }
            }
            
            
        }.resume()
    }
    
    
    static func NoiDung(idNoiDung:String, status:@escaping (String) -> Void){
        
        let request = NSMutableURLRequest(url: URL(string: UrlThongTin())!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try! JSONSerialization.data(withJSONObject: ["idthongtin":idNoiDung], options: [])
        
        URLSession.shared.dataTask(with: request as URLRequest) { (data, respon, error) in
            if error != nil {
                print("NoiDung: \(error!)")
            }
            
            if (data?.count)! > 0 {
                let httstatus = respon as! HTTPURLResponse
                if httstatus.statusCode == 200 || httstatus.statusCode == 201 {
                    
                    do{
                        
                        let json = try(JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                        let dataUpdata = json as! [String:AnyObject]
                        let dataGioiThieu = dataUpdata["data"] as! [String:AnyObject]
                        
                        if let statusss = dataGioiThieu["thongTin"]{
                            DispatchQueue.main.sync {
                                status("\(statusss)")
                                
                            }
                        } else {
                            DispatchQueue.main.sync {
                                //status("Cập nhật thông tin không thành công!")
                            }
                        }
                    }catch let err{
                        DispatchQueue.main.sync {
                            //status("Cập nhật thông tin không thành công!")
                        }
                        print("UpdataThongTin: \(err)")
                    }
                } else {
                    DispatchQueue.main.sync {
                        //status("Cập nhật thông tin không thành công!")
                    }
                }
            } else {
                DispatchQueue.main.sync {
                    //status("Cập nhật thông tin không thành công!")
                }
            }
            
            
            }.resume()
    }
    
    
    static func AddToken(token:String, status:@escaping (String) -> Void){
        
        let request = NSMutableURLRequest(url: URL(string: UrlThongTin())!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try! JSONSerialization.data(withJSONObject: ["token":token], options: [])
        
        URLSession.shared.dataTask(with: request as URLRequest) { (data, respon, error) in
            if error != nil {
                print("AddToken: \(error!)")
            }
            
            if (data?.count)! > 0 {
                let httstatus = respon as! HTTPURLResponse
                if httstatus.statusCode == 200 || httstatus.statusCode == 201 {
                    
                    do{
                        
                        let json = try(JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                        
                        print(json)
                        
//                        let dataUpdata = json as! [String:AnyObject]
//                        let dataGioiThieu = dataUpdata["data"] as! [String:AnyObject]
//                        
//                        if let statusss = dataGioiThieu["thongTin"]{
//                            DispatchQueue.main.sync {
//                                status("\(statusss)")
//                                
//                            }
//                        } else {
//                            DispatchQueue.main.sync {
//                                //status("Cập nhật thông tin không thành công!")
//                            }
//                        }
                    }catch let err{
                        DispatchQueue.main.sync {
                            //status("Cập nhật thông tin không thành công!")
                        }
                        print("AddToken: \(err)")
                    }
                } else {
                    DispatchQueue.main.sync {
                        //status("Cập nhật thông tin không thành công!")
                    }
                }
            } else {
                DispatchQueue.main.sync {
                    //status("Cập nhật thông tin không thành công!")
                }
            }
            
            
            }.resume()
    }
    
    
}


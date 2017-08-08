//
//  TinhThanhModel.swift
//  HiTaxi
//
//  Created by Nong Than on 2/14/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import UIKit

class TinhThanhModel:NSObject {
    
    var maTinhThanh:String?
    var tenTinhThanh:String?
    
    
    static func LayCacTinhThanh(danhSachTinhThanh:@escaping ([TinhThanhModel]) -> Void){
        URLSession.shared.dataTask(with: URL(string:UrlLinkCacTinhThanh)!) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    danhSachTinhThanh(SQLiteConfig().layTinhThanh())
                }
                print(error!)
                return
            }
            
            if data?.count != -1 {
                do{
                    let jsonTinhThanh = try(JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                    var listTinhThanh = [TinhThanhModel]()
                    
                  
                    for items in jsonTinhThanh as! [[String:AnyObject]]{
                        let tinhThanh = TinhThanhModel()
                        
                        if let matinhThanh = items["MaTinhthanh"] as? String {
                            tinhThanh.maTinhThanh = matinhThanh
                        } else  {
                            tinhThanh.maTinhThanh = ""
                        }
                        
                        if let tenTinhThanh = items["Tentinhthanh"] as? String {
                            tinhThanh.tenTinhThanh = tenTinhThanh
                        } else  {
                            tinhThanh.tenTinhThanh = ""
                        }
                        
                        listTinhThanh.append(tinhThanh)
                        SQLiteConfig().themDanhSachTinhThanh(modelTinhThanh: tinhThanh)
                    }
                    
                    
                    DispatchQueue.main.async {
                        danhSachTinhThanh(listTinhThanh)
                    }
                }catch let errJson {
                    print(errJson)
                    DispatchQueue.main.async {
                        danhSachTinhThanh(SQLiteConfig().layTinhThanh())
                    }
                }
            } else {
                DispatchQueue.main.async {
                    danhSachTinhThanh(SQLiteConfig().layTinhThanh())
                }
            }
        }.resume()
    }
}

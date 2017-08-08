//
//  StringUrl.swift
//  HiTaxi
//
//  Created by Nong Than on 2/14/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import UIKit

let UrlLinkCacTinhThanh:String = "http://hitaxi.vn/api/TinhthanhApi"
let UrlLinkHangTaxi:String = "http://hitaxi.vn/api/HangTaxiApi/"
let UrlLinkDanhGia:String = "http://hitaxi.vn/api/Danhgia"
let UrlLinkYeuThich:String = "http://hitaxi.vn/api/Yeuthich"

func linkHangTaxiYeuThich(maNguoiDung:String) -> String{
    
    return "http://hitaxi.vn/HangTaxiApi/\(maNguoiDung)/GetHangtaxiYeuthich"
}

func linkLayKhoangCach(diemBatDau:String ,diemKetThuc:String ) -> String{
    return "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=\(diemBatDau)&destinations=\(diemKetThuc)&key=AIzaSyCWa0b0qghBA0r_LhHHtzGMNZIaYUYCSLM"
}

func AnhFacebook (idNguoiDung:String ) -> String{
    return "https://graph.facebook.com/\(idNguoiDung)/picture?type=large"
}

func UrlUpdataThongTin() -> String{
    return "http://hitaxi.vn/KhachHang/UpdateNguoidung"
}


func UrlThongTin() -> String{
    return "http://hitaxi.vn/dmThongTin/GetThongTin"
}




//
//  HanderChonLocHangTaxi.swift
//  HiTaxi
//
//  Created by Nong Than on 2/20/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import UIKit

protocol LocHangTaxiTheoTinhThanh {
    
    mutating func LocHangTaxiTheoTinhDelegate(modelTinhThanh:TinhThanhModel)
    
}

protocol LocHangYeuThichDelegate {
    mutating func LocHangTaxiTheoTinhYeuThichDelegate(modelTinhThanh:TinhThanhModel)
}

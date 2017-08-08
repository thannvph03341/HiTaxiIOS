//
//  DangNhapDelegate.swift
//  HiTaxi
//
//  Created by Nong Than on 4/23/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import UIKit

protocol DangNhapDelegate{
    mutating func faceLoginSusse()
    mutating func faceLogutSusse(check:Bool)
    mutating func googleLoginSusse()
    mutating func googleLogout()
    
}

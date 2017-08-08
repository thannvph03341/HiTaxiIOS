//
//  ViewPlaceAutocompile.swift
//  HiTaxi
//
//  Created by Nong Than on 2/10/17.
//  Copyright © 2017 Nong Than. All rights reserved.
//

import UIKit
import GooglePlaces

class ViewPlaceAutocompile:UIView, GMSAutocompleteViewControllerDelegate {
    
    
    let autocompleteController = GMSAutocompleteViewController()
    static var classUocTinhChiPhi:UocTinhChiPhiView?
    static var indexTimKiem:Int = -1
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViewShearch()
    }
    
    func setupViewShearch(){
        
        autocompleteController.delegate = self
        addSubview(autocompleteController.view)
        addConstraintsArray(format: "H:|[v0]|", viewAdd: autocompleteController.view)
        addConstraintsArray(format: "V:|[v0]|", viewAdd: autocompleteController.view)
 
       
    }
    
    
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        ViewPlaceAutocompile.classUocTinhChiPhi?.showData(indexTimKiem: ViewPlaceAutocompile.indexTimKiem ,diaChi: place.formattedAddress!, dataFull: place)
        ViewPlaceAutocompile.classUocTinhChiPhi?.caiDatTimKiem.alpha = 0
        
        //        print("Place name: \(place.name)")
//        print("Place address: \(place.formattedAddress)")
//        print("Place attributions: \(place.attributions)")
        //dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
       // self.alpha = 0
         ViewPlaceAutocompile.classUocTinhChiPhi?.caiDatTimKiem.alpha = 0
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
       
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
      
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
}

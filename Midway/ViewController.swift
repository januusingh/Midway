//
//  ViewController.swift
//  Midway
//
//  Created by Jahnavi Singh on 04/12/18.
//  Copyright © 2018 Jahnavi Singh. All rights reserved.
//

import UIKit
import CoreLocation
import GooglePlaces

class ViewController: UIViewController {
    var locationManager: CLLocationManager = CLLocationManager()

    var placesClient: GMSPlacesClient?
    
    // Add a pair of UILabels in Interface Builder, and connect the outlets to these variables.
    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placesClient = GMSPlacesClient.shared()
        locationManager.requestAlwaysAuthorization()
    }
    
    // Add a UIButton in Interface Builder, and connect the action to this function.

    @IBAction func getCurrentPlace(sender: UIButton) {
        
        placesClient?.currentPlace(callback: {
            (placeLikelihoodList: GMSPlaceLikelihoodList?, error: NSError?) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            self.nameLabel.text = "No current place"
            self.addressLabel.text = ""
            
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                if let place = place {
                    self.nameLabel.text = place.name
                    self.addressLabel.text = place.formattedAddress!.components(separatedBy: ", ")
                      .joined(separator: "\n")
                }
            }
        } as! GMSPlaceLikelihoodListCallback)
    }

    placesClient.currentPlaceWithCallback({ (placeLikelihoods, error) -> Void in
    guard error == nil else {
    print("Current Place error: \(error!.localizedDescription)")
    return
    }
    
    if let placeLikelihoods = placeLikelihoods {
    for likelihood in placeLikelihoods.likelihoods {
    let place = likelihood.place
    print("Current Place name \(place.name) at likelihood \(likelihood.likelihood)")
    print("Current Place address \(place.formattedAddress)")
    print("Current Place attributions \(place.attributions)")
    print("Current PlaceID \(place.placeID)")
    }
    }
    })

}


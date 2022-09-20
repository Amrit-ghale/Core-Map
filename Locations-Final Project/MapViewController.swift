//
//  MapViewController.swift
//  Locations-Final Project
//
//  Created by Parwat Kunwar on 2022-09-19.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationListViewCtrl: LocationListViewController!
    var locationIndex: Int?
    var location = Location();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        location = DatabaseHelper.shared.getLocationFromCoreData(index: locationIndex!)
        mapView.delegate = self
    }

    
    
    @IBAction func Cancel(_ sender: UIButton) {
        locationListViewCtrl = storyboard?.instantiateViewController(withIdentifier: "LocationListViewontroller") as? LocationListViewController
        
        locationListViewCtrl.modalPresentationStyle = .fullScreen
        self.present(locationListViewCtrl, animated: true, completion: nil)
    }
}

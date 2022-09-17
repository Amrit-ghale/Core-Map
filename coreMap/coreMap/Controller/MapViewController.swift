//
//  MapViewController.swift
//  coreMap
//
//  Created by Parwat Kunwar on 2022-09-16.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    var locationFormCtrl: LocationFormController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addNewLocation(_ sender: UIButton) {
        locationFormCtrl = storyboard?.instantiateViewController(withIdentifier: "LocationFormController") as? LocationFormController
        
        locationFormCtrl.modalPresentationStyle = .fullScreen
        self.present(locationFormCtrl, animated: true, completion: nil)
    }
}

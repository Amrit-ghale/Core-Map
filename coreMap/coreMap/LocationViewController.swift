//
//  LocationViewController.swift
//  coreMap
//
//  Created by Parwat Kunwar on 2022-09-11.
//

import Foundation
import UIKit

class LocationViewController:UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectPhotos(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true // allows to crop (square a photo)
        present(vc, animated: true)
    }
}

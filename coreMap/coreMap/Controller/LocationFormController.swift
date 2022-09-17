//
//  LocationViewController.swift
//  coreMap
//
//  Created by Parwat Kunwar on 2022-09-11.
//

import Foundation
import UIKit

class LocationFormController:UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var info: UITextField!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var longitude: UITextField!
    
    var i = Int()
    var isUpdate = Bool()
    
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        if let img = info[.originalImage] as? UIImage{
            self.selectedImage.image = img
        }
    }
    
    @IBAction func addLocation(_ sender: Any) {
        let error = validateLocationInput();
        
        if(!error.isEmpty) {
            return showAlert(error);
        } else {
            let dic : [String : String] = ["name":name.text! ,"info":info.text!]
            
            if(isUpdate){
                
                LocationModel.dbmInstance.updateLocationData(data: dic, index: i)
                

                name.text?.removeAll()
                info.text?.removeAll()
                
            }else{
            
            
            LocationModel.dbmInstance.saveLocationData(data: dic)
            
            
            name.text?.removeAll()
            info.text?.removeAll()
            
            }
            
        }
    }
    
    func validateLocationInput() -> String {
        var err = "";
        
        if (name.text!.isEmpty && latitude.text!.isEmpty && longitude.text!.isEmpty) {
            err = "Please enter location name, latitude and longitude";
        }
        
        if (name.text!.isEmpty) {
            err = "Please enter location name";
        }
        
        if (latitude.text!.isEmpty) {
            err = "Please enter latitude";
        }
        
        if (longitude.text!.isEmpty) {
            err = "Please enter longitude"
        }
        
        if (Double(latitude.text!) == nil || Double(longitude.text!) == nil) {
            err = "Invalid input entered";
        }
        
        return err;
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)

        return present(alert, animated: true, completion: nil)
    }
}

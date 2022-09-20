//
//  LocationCollectionViewController.swift
//  Locations-Final Project
//
//  Created by Parwat Kunwar on 2022-09-19.
//

import UIKit

class LocationCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var locations = [Location]();
    var locationFormViewController: LocationFormViewController!
    var mapViewController: MapViewController!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        collectionView.delegate = self
        collectionView.dataSource = self
        loadLocationData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadLocationData(){
        locations = DatabaseHelper.shared.getLocationsFromCoreData()
    }
    
    @IBAction func openLocationForm(_ sender: Any) {
        locationFormViewController = storyboard?.instantiateViewController(withIdentifier: "LocationFormViewController") as? LocationFormViewController
        
        locationFormViewController.modalPresentationStyle = .fullScreen
        self.present(locationFormViewController, animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell

        cell.locationName?.text = locations[indexPath.row].name
        cell.locationDescription?.text = locations[indexPath.row].latitude
        
        if let imgData = locations[indexPath.row].photo {
            cell.locationImage?.image = UIImage(data: imgData)
        }
        
        //This creates the shadows and modifies the cards a little bit
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        navigateToMapView(indexPath.item)
    }
    
    func navigateToMapView(_ index: Int) {
        mapViewController = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController
        
        mapViewController.modalPresentationStyle = .fullScreen
        mapViewController.locationIndex = index
        self.present(mapViewController, animated: true, completion: nil)
    }
}


//
//  TableViewCell.swift
//  Locations-Final Project
//
//  Created by Parwat Kunwar on 2022-09-19.
//

import UIKit

class LocationListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var locationFormViewController: LocationFormViewController!
    var locations = [Location]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadLocationData()
    }
    
    func loadLocationData(){
        locations = DatabaseHelper.shared.getLocationsFromCoreData()
    }
    
    
    @IBAction func openLocationForm(_ sender: Any) {
        locationFormViewController = storyboard?.instantiateViewController(withIdentifier: "LocationFormViewController") as? LocationFormViewController
        
        locationFormViewController.modalPresentationStyle = .fullScreen
        self.present(locationFormViewController, animated: true, completion: nil)
    }
}

extension LocationListViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        cell.lblName?.text = locations[indexPath.row].name
        cell.lblDate?.text = locations[indexPath.row].latitude
        
        if let imgData = locations[indexPath.row].photo {
            cell.img?.image = UIImage(data: imgData)
        }
        
        return cell;
    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//
//        return true
//
//    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//     let delete = UIContextualAction(style: .destructive, title: "Delete") { (deleteAction, view, nil) in
//
//        self.locations.remove(at: indexPath.row)
//        self.tableView.deleteRows(at: [indexPath], with: .automatic)
//        DatabaseHelper.shared.deleteLocationData(index: indexPath.row)
//
//
//        }
//
//        let edit = UIContextualAction(style: .normal, title: "Edit") { (editAction, view, nil) in
//
//            let dic = ["name":self.locations[indexPath.row].name,"city":self.locations[indexPath.row].city]
//            self.delegate.dataPassing(data: dic as! [String : String],index: indexPath.row, isEdit: true)
//            self.navigationController?.popViewController(animated: true)
//        }
//
//        let config = UISwipeActionsConfiguration(actions: [delete,edit])
//        config.performsFirstActionWithFullSwipe = false
//        return config
//
//    }
}

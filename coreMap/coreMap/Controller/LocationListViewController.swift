//
//  LocationListViewController.swift
//  coreMap
//
//  Created by Parwat Kunwar on 2022-09-15.
//

import Foundation
import UIKit

protocol Data {
    func dataMap(data: [String: String], index: Int, isEdit: Bool)
}

class LocationListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var location = [Location]()
    
    var delegate:Data!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
//        location = LocationModel.dbmInstance.getLocationData()

        loadData()
//     createSearchbar()
    }
    
    func loadData(){
        location = LocationModel.dbmInstance.getLocationData()
    }
    
}

extension LocationListViewController : UITableViewDataSource,UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return location.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! LocationViewCell
        
        cell.name.text = location[indexPath.row].name
        cell.info.text = location[indexPath.row].info
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
     let delete = UIContextualAction(style: .destructive, title: "Delete") { (deleteAction, view, nil) in
    
        self.location.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        LocationModel.dbmInstance.deleteLocationData(index: indexPath.row)
        }
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { (editAction, view, nil) in
            
            let dic = ["name":self.location[indexPath.row].name,"city":self.location[indexPath.row].info]
            self.delegate.dataMap(data: dic as! [String : String],index: indexPath.row, isEdit: true)
            self.navigationController?.popViewController(animated: true)
        }
        
        let config = UISwipeActionsConfiguration(actions: [delete,edit])
        config.performsFirstActionWithFullSwipe = false
        return config
        
    }
}

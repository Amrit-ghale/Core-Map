//
//  DatabaseHelper.swift
//  locations
//
//  Created by Parwat Kunwar on 2022-09-19.
//

import Foundation
import UIKit
import CoreData

class DatabaseHelper{
    
    static let shared = DatabaseHelper()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveImageToCoreData(imgData: Data, _ name: String, _ lat: String, _ long: String)
    {
        let location = NSEntityDescription.insertNewObject(forEntityName: "Location", into: context) as! Location
        location.photo = imgData
        
        print("----", name, lat, long)
        location.name = name
        location.latitude = lat
        location.longitude = long
        do{
            try context.save()
        }catch{
            print("Error saving Image Data")
        }
    }
    
    func getImageFromCoreData() -> [Location]
    {
        var arrLocation = [Location]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        do{
            arrLocation = try context.fetch(fetchRequest) as! [Location]
        }catch{
            print("Error getting Image")
        }
        return arrLocation
    }
    
    func getLocationsFromCoreData() -> [Location] {
        var locations = [Location]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        
        do {
            locations = try context.fetch(fetchRequest) as! [Location]
        } catch {
            print("Error getting locations")
        }
        
        return locations
    }
}

//
//  LocationModel.swift
//  coreMap
//
//  Created by Parwat Kunwar on 2022-09-15.
//

import Foundation
import CoreData
import UIKit

class LocationModel: NSObject {
     static let dbmInstance = LocationModel() //Singleton Model
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveLocationData(data : [String:String]){
        let location = NSEntityDescription.insertNewObject(forEntityName: "Location", into: context) as! Location
        location.name = data["name"]
        location.latitude = data["latitude"]
        location.longitude = data["longitude"]
        location.info = data["info"]
        
        do{
            try context.save()
        }catch{
            print("Faild to save Data")
        }
    }
    
    func getLocationData() -> [Location]{
        var location = [Location]()
        let fetchData = NSFetchRequest<NSManagedObject>(entityName: "Location")
        
        do{
            location = try context.fetch(fetchData) as! [Location]
        } catch{
            print("Faild to fetch data")
        }

        return location
    }
    
    
    func deleteLocationData(index : Int) {
        let location = getLocationData()
        let objectToDelete = location[index] as NSManagedObject
         
        context.delete(objectToDelete)
        
        do {
            try context.save()
            
        } catch{
            print("Faild to delete")
        }
    }
    
    func updateLocationData(data: [String:String],index : Int){
        let location = getLocationData()
        
        location[index].name = data["name"]
        location[index].latitude = data["latitude"]
        location[index].longitude = data["longitude"]
        location[index].info = data["info"]
//        location[index].date = data["date"]
        
        do{
            try context.save()
            
        } catch{
            print("Faild to update")
        }
    }
}

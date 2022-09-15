//
//  LocationModel.swift
//  coreMap
//
//  Created by Parwat Kunwar on 2022-09-15.
//

import Foundation
import CoreData
import UIKit

class DatabaseModel: NSObject {
     static let dbmInstance = DatabaseModel() //Singleton Model
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func savePersonData(data : [String:String]){
        let person = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context) as! Person
        person.name = data["name"]
        person.city = data["city"]
        
        do{
            try context.save()
        }catch{
            print("Faild to save Data")
        }
    }
    
    func getPersonData() -> [Person]{
        var person = [Person]()
        let fetchData = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        do{
            person = try context.fetch(fetchData) as! [Person]
        } catch{
            print("Faild to fetch data")
        }

        return person
    }
    
    
    func deletePersonData(index : Int) {
        
        let person = getPersonData()
        let objectToDelete = person[index] as NSManagedObject
         
        context.delete(objectToDelete)
        
        do {
            try context.save()
            
        } catch{
            print("Faild to delete")
        }
    }
    
    func updateData(data: [String:String],index : Int){
        
        let person = getPersonData()
        
        person[index].name = data["name"]
        person[index].city = data["city"]
        
        do{
            try context.save()
            
        } catch{
            print("Faild to update")
        }
    }
}

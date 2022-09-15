//
//  Location.swift
//  coreMap
//
//  Created by Parwat Kunwar on 2022-09-15.
//

import Foundation
import CoreData

@objc(Location)
public class Location: NSManagedObject {

}

extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var name: String?
    @NSManaged public var info: String?
    @NSManaged public var latitude: String?
}


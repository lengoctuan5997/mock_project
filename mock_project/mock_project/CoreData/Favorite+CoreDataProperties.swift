//
//  Favorite+CoreDataProperties.swift
//  
//
//  Created by Lê Ngọc Tuấn on 10/10/2022.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var image: Data?
    @NSManaged public var age: String?
    @NSManaged public var animal: String?
    @NSManaged public var history: String?
    @NSManaged public var origin: String?
    @NSManaged public var information: String?
    @NSManaged public var species: String?
    @NSManaged public var type: String?
    @NSManaged public var weight: String?
    @NSManaged public var uid: String?
    @NSManaged public var height: String?

}

//
//  Favorite+CoreDataClass.swift
//  
//
//  Created by Lê Ngọc Tuấn on 10/10/2022.
//
//

import Foundation
import CoreData

public class Favorite: NSManagedObject {
    static func insertFavorite(
        _ animal: Animal,
        _ uid: String
        ) -> Favorite? {
        let favorite = NSEntityDescription
            .insertNewObject(
                forEntityName: "Favorite",
                into: AppDelegate.managedObjectContext!) as? Favorite
        favorite?.animal = animal.animal
            favorite?.image = animal.image.pngData()
        favorite?.uid = uid
        favorite?.age = animal.age
        favorite?.history = animal.history
        favorite?.information = animal.information
        favorite?.origin = animal.origin
        favorite?.species = animal.species
        favorite?.weight = animal.weight
        favorite?.height = animal.height
        favorite?.type = animal.type

        do {
            try AppDelegate.managedObjectContext?.save()
        } catch let error as NSError {
            print("can't insert Favorite: \(error)")
            return nil
        }
        return favorite
    }

    static func getFavoriteOfCurrentUser() -> [Favorite] {
        var result = [Favorite]()
        let appDelegate = AppDelegate.managedObjectContext

        do {
            result = try appDelegate?.fetch(Favorite.fetchRequest()) as? [Favorite] ?? [Favorite]()
        } catch let error as NSError {
            print("can't fetch contacts \(error)" )
        }
        return result
    }

    static func deleteFavorite(_ favorite: NSManagedObject) -> Bool {
        let appDelegate = AppDelegate.managedObjectContext

        appDelegate?.delete(favorite)

        do {
            try appDelegate?.save()
        } catch let error as NSError {
            print("can't delete favorite \(error)")
        }
        return true
    }
}

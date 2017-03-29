//
//  Favoritos+CoreDataProperties.swift
//  Favoritos
//
//  Created by Victor Hugo Vázquez Riojas on 3/21/17.
//  Copyright © 2017 Victor Hugo Vázquez Riojas. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Favoritos {

    @NSManaged var categoria: String?
    @NSManaged var importe: NSNumber?
    @NSManaged var titulo: String?

}


extension Favoritos {
    
    @objc(addFavoritosObject:)
    @NSManaged internal func addToFavoritos(value: Favoritos)
}
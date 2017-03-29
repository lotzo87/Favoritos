//
//  DBManager.swift
//  Favoritos
//
//  Created by Victor Hugo Vázquez Riojas on 3/20/17.
//  Copyright © 2017 Victor Hugo Vázquez Riojas. All rights reserved.
//

import Foundation
import CoreData


class DBManager {
    
    static let _instance = DBManager()
    
    
    func consultarFavoritos(nombreEntidad:String)-> NSArray {
        let query:NSFetchRequest = NSFetchRequest()
        let entidad:NSEntityDescription = NSEntityDescription.entityForName(nombreEntidad, inManagedObjectContext: self.managedObjectContext!)!
        query.entity = entidad
        do {
            let result = try self.managedObjectContext!.executeFetchRequest(query)
            return result as NSArray
        }
        catch {
            print ("Error al ejecutar la consulta")
            return NSArray()
        }
    }
    
    func guardarFavorito(nombreEntidad:String, categoria: String, importe: NSNumber, titulo: String)-> Bool
    {
        var result = true
        let favorito = NSEntityDescription.insertNewObjectForEntityForName(nombreEntidad, inManagedObjectContext: self.managedObjectContext!) as! Favoritos
        favorito.setValue(categoria, forKey: "categoria")
        favorito.setValue(importe, forKey: "importe")
        favorito.setValue(titulo, forKey: "titulo")
        do {
            try managedObjectContext?.save()
        } catch {
            fatalError("Error al guardar favorito: \(error)")
            result = false
        }
        return result
    }
    
    
    lazy var managedObjectContext:NSManagedObjectContext? = {
        let persistence = self.persistentStore
        if persistence == nil {
            return nil
        }
        var moc = NSManagedObjectContext(concurrencyType:.PrivateQueueConcurrencyType)
        moc.persistentStoreCoordinator = persistence
        return moc
    }()
    lazy var managedObjectModel:NSManagedObjectModel? = {
        let modelURL = NSBundle.mainBundle().URLForResource("Favoritos_Core_Data", withExtension: "momd")
        var model = NSManagedObjectModel(contentsOfURL: modelURL!)
        return model
    }()
    lazy var persistentStore:NSPersistentStoreCoordinator? = {
        let model = self.managedObjectModel
        if model == nil {
            return nil
        }
        let persist = NSPersistentStoreCoordinator(managedObjectModel: model!)
        let urlDeLaBD = self.directorioDocuments.URLByAppendingPathComponent("Favoritos_Core_Data.sqlite")
        do {
            let opcionesDePersistencia = [NSMigratePersistentStoresAutomaticallyOption:true,
                                          NSInferMappingModelAutomaticallyOption:true]
            try persist.addPersistentStoreWithType(NSSQLiteStoreType, configuration:nil, URL:urlDeLaBD, options:opcionesDePersistencia)
        }
        catch {
            print ("no se puede abrir la base de datos")
            abort()
        }
        return persist
    }()
    lazy var directorioDocuments:NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count - 1]
    }()
}


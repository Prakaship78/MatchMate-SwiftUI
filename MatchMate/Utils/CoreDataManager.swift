//
//  CoreDataManager.swift
//  MatchMate
//
//  Created by Prakash on 26/09/25.
//

import Foundation
import CoreData

// Utility low level class to handle fetch and save data to core data
final class CoreDataManager{
    static let shared = CoreDataManager()
    let container : NSPersistentContainer
    
    private init(){
        container = NSPersistentContainer(name: "MatchMate")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("core data load error \(error.localizedDescription)")
            }
        }
    }
    
    var context : NSManagedObjectContext {
        return container.viewContext
    }
    
    func save(){
        if context.hasChanges {
            do {
                try context.save()
            }catch {
                print("failed to save data \(error.localizedDescription)")
            }
        }
    }
}
 

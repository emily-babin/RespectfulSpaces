//
//  CoreDataStack.swift
//  EPath-v0.0.1
//
//  Created by Pillas,Carlos Andre on 2025-05-07.
//

import Foundation
import CoreData

// CoreDataStack.swift
// Manages your Core Data setup: the container, contexts, and loading of stores.

class CoreDataStack {
    
    // Singleton instance so the whole app uses the same Core Data container
    static let shared = CoreDataStack(modelName: "RespectfulSpacesModel")

    private let container: NSPersistentContainer
    
    //Private initalizer prevents others from creating new stacks
    private init(modelName: String) {
        
        //create the container based on the modelName
        container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { storeDesc, error in
          if let error = error {
            //If the store fails to load, crash early so you can fix the model/config
            fatalError("Core Data failed to load: \(error)")
          }
        }
        
        //Makes viewContext automatically merge changes saved on background contexts
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    //main thread context for reads and uibound work
    var viewContext: NSManagedObjectContext { container.viewContext }

    //Use for background writes
    func newBackgroundContext() -> NSManagedObjectContext {
        let ctx = container.newBackgroundContext()
        //If there’s a merge conflict, keep the background values
        ctx.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return ctx
    }
}

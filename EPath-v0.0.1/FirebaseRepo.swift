//
//  ScenariosRepository.swift
//  EPath-v0.0.1
//
//  Created by Pillas,Carlos Andre on 2025-05-07.
//

import Foundation
import FirebaseFirestore
import CoreData
import Network

// Coordinates Firestore and Core Data syncing and provides an in-memory array for the UI.
class FirebaseRepository {
    
    private let db = Firestore.firestore() //Firestore connection
    private let monitor = NWPathMonitor() //Monitors if internet or no
    private var scenarioListener: ListenerRegistration? //Holds Firestore listener so we can remove it
    private var toolBoxListener: ListenerRegistration? //Holds Firestore listener so we can remove it

    private let coreDataStack = CoreDataStack.shared // Shared CoreDataStack singleton
    
    //Exposed array of models our UI will read; private(set) means only this class can change it ScenariosRepository
    private(set) var scenarios: [Scenarios] = []
    private(set) var toolBox: [ToolBox] = []
    
    //Ensures NWPathMonitor starts only once to avoid duplicate path handlers
    private var flagMonitoring = false
    
    //Start monitoring network and load data accordingly
    //Parameter completion is called whenever data is ready online or offline
    
    func startAll(onUpdate: @escaping ()-> Void) {
        
        // Avoid calling start again if already monitoring
        guard !flagMonitoring else { return }
        flagMonitoring = true
        
        //pathUpdateHandler fires on any network change(wifi, data, offline)
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else {return}
            if path.status == .satisfied {
                // We have Internet: subscribe to realtime Firestore updates
                self.subscribeToFirestoreScenarios{ onUpdate()}
                self.subscribeToFirestoreToolBox{ onUpdate()}
              
            } else {
                //No Internet: Loads last data in CoreData
                self.loadFromScenariosCoreData()
                self.loadFromToolBoxCoreData()
                onUpdate() //Tell viewController to reload its table
            }
        }
        //Begin monitoring on a background queue(so UI thread stays free)
        monitor.start(queue: .global())
    }
    
    //Attach a Firestore listener and cache incoming snapshots
    private func subscribeToFirestoreScenarios(completion: @escaping ()->Void) {
        scenarioListener?.remove() // Remove any existing listener to avoid duplicates
        scenarioListener = db.collection("Scenarios")
          .order(by: "title")               // Sort documents by the "title" field
          .addSnapshotListener { [weak self] snapshot, error in
            guard let snap = snapshot else { return }  // If there's an error, do nothing

            // Map each Firestore document into our plain Swift struct
            let models = snap.documents.map { doc -> Scenarios in
              Scenarios(
                title: doc.get("title") as? String ?? "No Title Yet",
                imageName: doc.get("type") as? String ?? "EMPATHY",
                description: doc.get("description") as? String ?? "No Description Yet",
                content: doc.get("content") as? String ?? "No Content Yet",
                commonResponse: doc.get("common") as? String ?? "No Responses Yet",
                facts: doc.get("facts") as? String ?? "No Facts Gathered Yet",
                tags: doc.get("tag") as? [String] ?? []
              )
            }
            self?.scenarios = models           // Update in-memory cache
            self?.cacheToCoreDataScenarios(models)      // Persist into Core Data
            completion()                       // Notify UI to reload
          }
      }
    
    //Attach a Firestore listener and cache incoming snapshots
    private func subscribeToFirestoreToolBox(completion: @escaping ()->Void) {
        toolBoxListener?.remove()  // Remove any existing listener to avoid duplicates
        toolBoxListener = db.collection("ToolboxTalks")
          .order(by: "title")               // Sort documents by the "title" field
          .addSnapshotListener { [weak self] snapshot, error in
            guard let snap = snapshot else { return }  // If there's an error, do nothing

            // Map each Firestore document into our plain Swift struct
            let models = snap.documents.map { doc -> ToolBox in
                ToolBox(title: doc.get("title") as? String ?? "No Title Yet",
                        imageName: doc.get("type") as? String ?? "EMPATHY",
                        description: doc.get("description") as? String ?? "No Description Yet",
                        content: doc.get("text") as? String ?? "No Content Yet")
            }
            self?.toolBox = models           // Update in-memory cache
            self?.cacheToCoreDataToolBox(models)      // Persist into Core Data
            completion()                       // Notify UI to reload
          }
      }
    
    // Persist an array of Scenarios into Core Data as our offline cache
    private func cacheToCoreDataScenarios(_ models: [Scenarios]) {
        let bg = coreDataStack.newBackgroundContext() // Use a background context for thread safety
        bg.perform {
            
            do {
                // 1) Delete old cached records to avoid duplicates
                // Delete old cache
                let req = NSFetchRequest<NSFetchRequestResult>(entityName: "ScenariosEntity")
                let del = NSBatchDeleteRequest(fetchRequest: req)
                _ = try? bg.execute(del)

                // 2) Insert fresh records matching the Firestore snapshot
                for m in models {
                    let e = ScenariosEntity(context: bg)       // New Core Data object
                    e.title          = m.title                // Copy title field
                    e.descriptionText = m.description          // Copy description
                    e.content        = m.content              // Copy content
                    e.commonResponse = m.commonResponse       // Copy common response
                    e.facts          = m.facts                // Copy facts
                    e.imageName      = m.imageName            // Copy image name/type
                    e.tags           = m.tags as NSArray      // Transformable [String]
                    e.timeStamp      = Date()                 // Mark when we cached it
                }
                
                try bg.save() // Save changes to disk
                
            } catch {
                print("Failed to save Scenarios: \(error)")
            }
        }
    }
    
    // Persist an array of Scenarios into Core Data as our offline cache
    private func cacheToCoreDataToolBox(_ models: [ToolBox]) {
        let bg = coreDataStack.newBackgroundContext() // Use a background context for thread safety
        
        bg.perform {
            do {
                // 1) Delete old cached records to avoid duplicates
                // Delete old cache
                let req = NSFetchRequest<NSFetchRequestResult>(entityName: "ToolBoxEntity")
                let del = NSBatchDeleteRequest(fetchRequest: req)
                _ = try? bg.execute(del)

                // 2) Insert fresh records matching the Firestore snapshot
                for m in models {
                    let e = ToolBoxEntity(context: bg)       // New Core Data object
                    e.title          = m.title                // Copy title field
                    e.descriptionText = m.description          // Copy description
                    e.content        = m.content              // Copy content
                    e.imageName      = m.imageName            // Copy image name/type
                    e.timeStamp      = Date()                 // Mark when we cached it
                }
                
                try bg.save()   // Save changes to disk
            } catch {
                print("Failed to save ToolBox: \(error)")
            }
        }
    }

    //Load cached ScenarioEntity objects from Core Data into memory
    private func loadFromScenariosCoreData() {
        let req: NSFetchRequest<ScenariosEntity> = ScenariosEntity.fetchRequest()
        // Sort by timestamp descending so newest appear first
        req.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        if let entities = try? coreDataStack.viewContext.fetch(req) {
            // Map Core Data entities back into plain Swift structs for the UI
            scenarios = entities.map { entity in
                Scenarios(
                    title: entity.title!,               // Unwrap because attribute is non-optional
                    imageName: entity.imageName!,
                    description: entity.descriptionText!,
                    content: entity.content!,
                    commonResponse: entity.commonResponse!,
                    facts: entity.facts!,
                    tags: (entity.tags as? [String]) ?? []
                )
            }
        }
    }
    
    private func loadFromToolBoxCoreData() {
        
        let req: NSFetchRequest<ToolBoxEntity> = ToolBoxEntity.fetchRequest()
        
        //Sort by timeStamp descending so newest will appear first
        req.sortDescriptors = [NSSortDescriptor(key: "timeStamp", ascending: false)]
        if let entities = try? coreDataStack.viewContext.fetch(req) {
            //Map Core Data entities back into plain swift structs for the UI
            toolBox = entities.map { entity in
                ToolBox(title: entity.title!,
                        imageName: entity.imageName!,
                        description: entity.descriptionText!,
                        content: entity.content!)
            }
        }
    }
}

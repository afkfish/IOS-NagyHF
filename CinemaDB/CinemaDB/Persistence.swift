//
//  Persistence.swift
//  CinemaDB
//
//  Created by Beni Kis on 29/11/2023.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container = NSPersistentContainer(name: "CinemaDB")

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        
        let newFilm = FilmData(from: Film.dummy, context: result.container.viewContext)
        
        return result
    }()

    init(inMemory: Bool = false) {
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func save() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

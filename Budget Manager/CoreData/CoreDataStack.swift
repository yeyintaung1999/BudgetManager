//
//  CoreDataStack.swift
//  Budget Manager
//
//  Created by Ye Yint Aung on 16/01/2023.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    let persistenceContainer: NSPersistentContainer
    
    var context : NSManagedObjectContext {
        get{
            persistenceContainer.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
            return persistenceContainer.viewContext
        }
    }
    
    private init(){
        self.persistenceContainer = NSPersistentContainer(name: "Budget Manager")
        
        persistenceContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Couldn't Load Core Data Stack with error \(error.localizedDescription)")
            }
        }
    }
    
    func saveContext(){
        let context = self.context
        if context.hasChanges {
            do{
                try context.save()
            }catch {
                let error = error as NSError
                fatalError("Unresolved Error \(error) \(error.userInfo)")
            }
        }
    }
    
}

//
//  Service.swift
//  SweepApp
//
//  Created by Joan Wilson Oliveira on 09/09/22.
//

import CoreData
import Foundation
import UIKit

final class CoreDataManager {

    public func fetchAllTasks() -> [Task] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        var allTasks: [Task] = []
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")

        do {
            allTasks = try managedContext.fetch(fetchRequest)
        } catch {
            print(error)
        }

        return allTasks
    }

    public func addATask(for name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)!
        let task = NSManagedObject(entity: entity, insertInto: managedContext)
        task.setValue(name, forKey: "name")
        task.setValuesForKeys([
            "name": name,
            "isCompleted": false
        ])

        do {
            try managedContext.save()
        } catch {
            print(error)
        }
    }

    public func completeATask(_ task: Task) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        task.setValue(true, forKey: "isCompleted")
//        var updatedObject = managedContext.object(with: task.objectID)
//
//        print(updatedObject)
//
//        updatedObject.setValue(true, forKey: "isCompleted")

        do {
            try managedContext.save()
        } catch {
            print(error)
        }

    }

    public func deleteATaskByName(name: String?) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let results = fetchAllTasks()
        for index in results {
            if let indexName = index.value(forKey: "name") as? String, indexName == name {
                managedContext.delete(index)
            }
        }

        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        }
    }

    public func deleteAllTasks() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Task")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }

    public func deleteATask(_ task: Task) {
        guard let appDelete = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelete.persistentContainer.viewContext
        managedContext.delete(task)

        do {
            try managedContext.save()
        } catch {
            print(error)
        }
    }

}

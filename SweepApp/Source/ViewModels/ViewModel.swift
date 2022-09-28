//
//  File.swift
//  SweepApp
//
//  Created by Joan Wilson Oliveira on 09/09/22.
//

import Foundation
import CoreData

struct ViewModel {

    var taskArray: [Task] = []

    public let service = CoreDataManager()

    var mocArray: [TaskMoc] = [
        TaskMoc(name: "Limpar o quarto", isCompleted: false),
        TaskMoc(name: "Limpar o quarto", isCompleted: false),
        TaskMoc(name: "Limpar o quarto", isCompleted: false),
        TaskMoc(name: "Limpar o quarto", isCompleted: false),
        TaskMoc(name: "Limpar o quarto", isCompleted: false)
    ]

    init() {
        setTaskArray()
    }

    mutating public func setTaskArray() {
        self.taskArray = self.service.fetchAllTasks()
        self.taskArray = self.taskArray.reversed()
    }

    public func getCompletedArray() -> [Task] {
        var array: [Task] = []

        for index in taskArray {
            if index.isCompleted == true {
                array.append(index)
            }
        }

        return array
    }

    public func getUncompletedArray() -> [Task] {
        var array: [Task] = []

        for index in taskArray {
            if index.isCompleted == false {
                array.append(index)
            }
        }

        return array
    }

}

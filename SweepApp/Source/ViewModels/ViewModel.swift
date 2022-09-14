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

}

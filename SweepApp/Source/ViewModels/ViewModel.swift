//
//  File.swift
//  SweepApp
//
//  Created by Joan Wilson Oliveira on 09/09/22.
//

import Foundation

final class ViewModel {

    fileprivate let service = CoreDataManager()
    var mocArray: [TaskMoc] = [
        TaskMoc(name: "Limpar o quarto", isCompleted: false),
        TaskMoc(name: "Limpar o quarto", isCompleted: false),
        TaskMoc(name: "Limpar o quarto", isCompleted: false),
        TaskMoc(name: "Limpar o quarto", isCompleted: false),
        TaskMoc(name: "Limpar o quarto", isCompleted: false)
    ]
}

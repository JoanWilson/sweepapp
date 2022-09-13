//
//  ViewController.swift
//  SweepApp
//
//  Created by Nicolas Barbosa on 09/09/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    fileprivate let viewModel = ViewModel()
    fileprivate let coreDataManager = CoreDataManager()

    var tasks: [NSManagedObject] = []

    override func loadView() {
        self.view = View()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = coreDataManager.fetchAllTasks()
        coreDataManager.deleteATaskByName(name: "testaaa")
        for index in tasks {
            print(index.value(forKey: "name"))
            print(index)
        }

    }

}

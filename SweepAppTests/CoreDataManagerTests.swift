//
//  CoreDataManagerTests.swift
//  SweepAppTests
//
//  Created by Joan Wilson Oliveira on 12/09/22.
//

import XCTest
import CoreData
@testable import SweepApp

class ManagedObjectContextSpy: NSManagedObjectContext {

    private(set) var saveCallCount = 0
    override func save() throws {
        saveCallCount += 1
    }
}

class CoreDataManagerTests: XCTestCase {

    var sut: TaskService!

    var managedObjectSpy: ManagedObjectContextSpy!
    var coreDataStack: CoreDataStack!

    override func setUp() {
        managedObjectSpy = ManagedObjectContextSpy()

        coreDataStack = TestCoreDataStack()
        sut = TaskService(managedObjectContext: managedObjectSpy,
                          coreDataStack: coreDataStack)
    }

    override func tearDown() {

    }

    func test_addATask() throws {

        let task = sut.addATask(for: "TesteCoreData")

        XCTAssertEqual(task.name, "TesteCoreData")
        XCTAssertFalse(task.isCompleted)
//        XCTAssertEqual(managedObjectSpy.saveCallCount, 1)

//        let results = sut.fetchAllTasks()
//        print(results)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

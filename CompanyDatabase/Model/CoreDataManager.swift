//
//  CoreDataManager.swift
//  CompanyDatabase
//
//  Created by Igor Tkach on 11.11.2019.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import CoreData


struct CoreDataManager {
  
  static let shared = CoreDataManager() // will live forever as long as your application still alive, it's properties will too
  
  
  
  let persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "CompanyModel")
      container.loadPersistentStores { (storeDescription, error) in
        if let error = error {
          fatalError("Loading of store failed: \(error)")
        }
      }
    return container
  }()
  
}

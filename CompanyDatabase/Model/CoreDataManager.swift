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
  
  
  func fetchCompanies() -> [Company] {
    
    // fetch CoreData
     
    let context = persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
    do {
      let companies = try context.fetch(fetchRequest)
      return companies
    } catch let error {
      print("Unable to fetch data from CoreData store: ", error.localizedDescription)
    }
    return []
  }
  
  
  func createEmployee(employeeName: Any?, company: Company) -> (Employee?, Error?) {
    let context = persistentContainer.viewContext
    
    let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
    
    employee.company = company
    
    employee.setValue(employeeName, forKey: "name")
    
    
    
    do {
      try context.save()
      //save succeed
      return (employee, nil)
    } catch let error {
      print("Unable to create Employee: ", error.localizedDescription)
      return (nil, error)
    }
  }
  
}

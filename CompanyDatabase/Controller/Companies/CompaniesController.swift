//
//  ViewController.swift
//  CompanyDatabase
//
//  Created by Igor Tkach on 10.11.2019.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController {
  
  
  let cellId = "companyCell"
  
  var companies = [Company]() // empty array
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.companies = CoreDataManager.shared.fetchCompanies()
    
    // Do any additional setup after loading the view.
    
    view.backgroundColor = .plum
    
    setupTableView()
    setupNavigationStyle(title: "Companies")
    
    navigationItem.leftBarButtonItems = [
      UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleResetCompany)),
      UIBarButtonItem(title: "Do Nested", style: .plain, target: self, action: #selector(doNested))]
    
    navigationItem.leftBarButtonItems?.forEach({ (bar) in
      bar.tintColor = .white
    })
    
    setupPlusButtonInNavigationBar(action: #selector(handleAddCompany))
  }
  
  @objc private func doWork() {
    
    print("Do work")
    
    //perform coredata context work on bg thread
    CoreDataManager.shared.persistentContainer.performBackgroundTask { (bgContext) in
      
      (0...5).forEach { (value) in
        print(value)
        let company = Company(context: bgContext)
        company.name = String(value)
      }
      
      do {
        try bgContext.save()
        
        DispatchQueue.main.async {
          self.companies = CoreDataManager.shared.fetchCompanies()
          self.tableView.reloadData()
        }
        
      } catch let error {
        print("error saving: ", error.localizedDescription)
      }
      
    }
    
    
  }
  
  
  
  @objc private func doUpdates() {
    
    print("BGContext")
    
    CoreDataManager.shared.persistentContainer.performBackgroundTask { (bgContext) in
      
      let request: NSFetchRequest<Company> = Company.fetchRequest()
      
      do {
         let companies = try bgContext.fetch(request)
        
        companies.forEach { (company) in
          print(company.name ?? "")
          company.name = "B: \(company.name ?? "")"
        }
        
        do {
          try bgContext.save()
          
          //update UI after saving
          
          DispatchQueue.main.async {
            self.companies = CoreDataManager.shared.fetchCompanies()
            self.tableView.reloadData()
          }
          
        } catch let bgError {
          print("Failed to save bg...", bgError.localizedDescription)
        }
        
      } catch let error {
        print(error.localizedDescription)
      }
      
      
      
    }
    
  }
  
  @objc func doNested() {
    print("Nested")
    
    DispatchQueue.global(qos: .background).async {
      //perform
      
      let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
      
      privateContext.parent = CoreDataManager.shared.persistentContainer.viewContext
      
      let request: NSFetchRequest<Company> = Company.fetchRequest()
      request.fetchLimit = 1
      
      do {
        let companies = try privateContext.fetch(request)
        
        companies.forEach { (company) in
          print(company.name ?? "")
          company.name = "D : \(company.name ?? "")"
        }
        
        
        do {
          try privateContext.save()
          
          //after save succeeds
          
          DispatchQueue.main.async {
            
            do  {
              let context = CoreDataManager.shared.persistentContainer.viewContext
              if context.hasChanges {
               try context.save()
              }
              
            
            } catch let error {
              print("error", error.localizedDescription)
            }
            
            
            self.tableView.reloadData()
          }
        } catch let error {
          print(error.localizedDescription)
        }
        
        
      } catch let error {
        print("Unable to fetch: ", error.localizedDescription)
      }
      
      
    }
  }
  
  
  
  // MARK: - Add Button Action
  @objc private func handleAddCompany() {
    
    let createCompanyController = CreateCompanyController()
    
    let navController = UINavigationController(rootViewController: createCompanyController)
    
    createCompanyController.delegate = self

    present(navController, animated: true)
    
  }
  
  @objc private func handleResetCompany() {
    
    print("Delete all coreData object ")
    
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
    
    do {
      try context.execute(batchDeleteRequest)
      
      // if succeeded to reset all from CoreData
      
      var indexPathToRemove = [IndexPath]()
      
      _ = companies.enumerated().compactMap { index, _ in
        let indexPath = IndexPath(row: index, section: 0)
        indexPathToRemove.append(indexPath)
      }
      
      companies.removeAll()
      tableView.deleteRows(at: indexPathToRemove, with: .left)
      
    } catch let error {
      print("Failed delete all core data objects: ", error.localizedDescription)
    }

  }
 
 
}

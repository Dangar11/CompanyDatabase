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
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleResetCompany))
    navigationItem.leftBarButtonItem?.tintColor = .white
    
    setupPlusButtonInNavigationBar(action: #selector(handleAddCompany))
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

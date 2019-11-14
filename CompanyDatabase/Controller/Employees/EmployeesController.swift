//
//  EmployeesController.swift
//  CompanyDatabase
//
//  Created by Igor Tkach on 14.11.2019.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class EmployeeController: UITableViewController {
  
  
  var company: Company? {
    didSet {
      navigationItem.title = company?.name
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.backgroundColor = .lusciousLavender
    
    setupPlusButtonInNavigationBar(action: #selector(handleAdd))
  }
  
  
  @objc private func handleAdd() {
    let createEmployee = CreateEmployeeController()
    let navController = UINavigationController(rootViewController: createEmployee)
    present(navController, animated: true, completion: nil)
  }
  
}

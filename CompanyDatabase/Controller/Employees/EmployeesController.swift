//
//  EmployeesController.swift
//  CompanyDatabase
//
//  Created by Igor Tkach on 14.11.2019.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit
import CoreData


class EmployeeController: UITableViewController, CreateEmployeeControllerDelegate {
  
  
  let cellId = "EmployeeCell"
  
  var employees = [Employee]()
  
  var company: Company? {
    didSet {
      navigationItem.title = company?.name
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.backgroundColor = .lusciousLavender
    
    fetchEmployees()
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    
    setupPlusButtonInNavigationBar(action: #selector(handleAdd))
  }
  
  
  
  private func fetchEmployees() {
    
    guard let companyEmployees = company?.employees?.allObjects as? [Employee] else { return }
    
    self.employees = companyEmployees
    
//    let context = CoreDataManager.shared.persistentContainer.viewContext
//
//    let request = NSFetchRequest<Employee>(entityName: "Employee")
//
//    do {
//      let employees = try context.fetch(request)
//
//      self.employees = employees
//    } catch let error {
//      print("Error occured during fetch Employee: ", error.localizedDescription)
//    }
  }
  
  
  func didAddEmployee(employee: Employee) {
    employees.append(employee)
    tableView.reloadData()
  }

  
  
  @objc private func handleAdd() {
    let createEmployee = CreateEmployeeController()
    createEmployee.company = company
    createEmployee.delegate = self
    let navController = UINavigationController(rootViewController: createEmployee)
    present(navController, animated: true, completion: nil)
  }
  
  
  // MARK: - TableView
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return employees.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    let employee = employees[indexPath.row]
    cell.textLabel?.text = employee.name
    cell.backgroundColor = UIColor.aqueous
    cell.textLabel?.textColor = .white
    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    return cell
  }
  
}

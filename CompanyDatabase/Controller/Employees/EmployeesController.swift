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
  
  var shortNameEmployees = [Employee]()
  var longNameEmployees = [Employee]()
  var reallyLongName = [Employee]()
  
  var allEmployees = [[Employee]]()
  
  var employeeTypes = [
    EmployeeType.Intern.rawValue,
    EmployeeType.Executive.rawValue,
    EmployeeType.SeniorManagement.rawValue,
    EmployeeType.Staff.rawValue
  ]
  
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
    
    //every time we call this function set empty allEmployees array
    allEmployees = []
    
    // go throught enum looping
    employeeTypes.forEach { (employeeType) in
      
      // filter each enumType for companyEmployees and adding them to allEmplooyes array
      allEmployees.append(
        companyEmployees.filter { $0.type == employeeType }
      )
    }
  }
  
  
  
  
  // Call this when we dismiss employee creation - Delegate
  func didAddEmployee(employee: Employee) {
    //in which section we adding
    guard let employeeType = employee.type else { return }
    guard let section = employeeTypes.firstIndex(of: employeeType) else { return }
    // which row we adding
    let row = allEmployees[section].count
    let insertionIndexPath = IndexPath(row: row, section: section)
    
    allEmployees[section].append(employee)
    
    tableView.insertRows(at: [insertionIndexPath], with: .middle)
  }

  @objc private func handleAdd() {
    let createEmployee = CreateEmployeeController()
    createEmployee.company = company
    createEmployee.delegate = self
    let navController = UINavigationController(rootViewController: createEmployee)
    present(navController, animated: true, completion: nil)
  }
  
  
  // MARK: - TableView
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return allEmployees.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return allEmployees[section].count
    }
    

  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    
    
    let employee = allEmployees[indexPath.section][indexPath.row]
    
    
    cell.textLabel?.text = employee.fullName
    if let birthday = employee.birthday {
      let dateFormatter = DateFormatter()
      dateFormatter.dateStyle = .long
      let birthdayDate = dateFormatter.string(from: birthday)
      cell.textLabel?.text = "\(employee.fullName ?? "") - Born: \(birthdayDate)"
    }
    cell.backgroundColor = UIColor.aqueous
    cell.textLabel?.textColor = .white
    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    return cell
  }
  
  
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = IndentedLabel()
    
    label.text = employeeTypes[section]
    label.backgroundColor = UIColor.plum
    label.font = UIFont.boldSystemFont(ofSize: 16)
    return label
  }
  
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
}



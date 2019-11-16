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
    
    
    shortNameEmployees = companyEmployees.filter({ (employee) -> Bool in
      if let employeeCount = employee.name?.count {
        return employeeCount < 6
      }
        return false
    })
    
    
    longNameEmployees = companyEmployees.filter { (employee) -> Bool in
      if let employeeCount = employee.name?.count {
        return employeeCount > 6 && employeeCount < 9
      }
      return false
    }
    
    reallyLongName = companyEmployees.filter { (employee) -> Bool in
      if let employeeCount = employee.name?.count {
        return employeeCount > 9
      }
      return false
    }
    
    allEmployees = [
    shortNameEmployees,
    longNameEmployees,
    reallyLongName
    ]
    
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
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return allEmployees.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return allEmployees[section].count
    }
    

  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    
//    let employee = indexPath.section == 0 ? shortNameEmployees[indexPath.row] : longNameEmployees[indexPath.row]
    
    let employee = allEmployees[indexPath.section][indexPath.row]
    
    
    cell.textLabel?.text = employee.name
    if let birthday = employee.birthday {
      let dateFormatter = DateFormatter()
      dateFormatter.dateStyle = .long
      let birthdayDate = dateFormatter.string(from: birthday)
      cell.textLabel?.text = "\(employee.name ?? "") - Born: \(birthdayDate)"
    }
    cell.backgroundColor = UIColor.aqueous
    cell.textLabel?.textColor = .white
    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    return cell
  }
  
  
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = IndentedLabel()
    
    switch section {
    case 0 :
      label.text = "Short names"
    case 1 :
      label.text = "Long names"
    case 2 :
      label.text = "Very Long Names"
    default:
      label.text = "Other"
    }
    label.backgroundColor = UIColor.plum
    label.font = UIFont.boldSystemFont(ofSize: 16)
    return label
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
}



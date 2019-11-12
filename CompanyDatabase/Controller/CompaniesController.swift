//
//  ViewController.swift
//  CompanyDatabase
//
//  Created by Igor Tkach on 10.11.2019.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController, CreateCompanyControllerDelegate {
  
  
  
  let cellId = "companyCell"
  
  var companies = [Company]() // empty array
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchCompanies()
    
    // Do any additional setup after loading the view.
    
    view.backgroundColor = .white
    
    setupTableView()
    setupNavigationStyle(title: "Companies")
    
     navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleCompany))
  }
  
  
  private func fetchCompanies() {
    // fetch CoreData
     
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    
    let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
    
    do {
      let companies = try context.fetch(fetchRequest)
      
      self.companies = companies
      self.tableView.reloadData()
    } catch let error {
      print("Unable to fetch data from CoreData store: ", error.localizedDescription)
    }
  }
  
  
   func didAddCompany(company: Company) {
     companies.append(company)
     
     //Index the last element in the Array - 1
     let newIndexPath = IndexPath(row: companies.count - 1, section: 0)
     
     tableView.insertRows(at: [newIndexPath], with: .automatic)
   }
  
  
  // MARK: - Setup TableView
  private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        tableView.backgroundColor = .lusciousLavender
        tableView.tableFooterView = UIView() // blank UIView bellow tableView
        tableView.separatorColor = .white
    
  }



  
  // MARK: - Add Button Action
  @objc private func handleCompany() {
    
    let createCompanyController = CreateCompanyController()
    
    let navController = UINavigationController(rootViewController: createCompanyController)
    
    createCompanyController.delegate = self

    present(navController, animated: true)
    
  }
  
  
  
  
  
  //MARK: - TableView
  
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return companies.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    cell.backgroundColor = .aqueous
    let company = companies[indexPath.row]
    cell.textLabel?.text = company.name
    
    cell.textLabel?.textColor = .white
    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    return cell
  }
  
  
  override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (contextAction, view, boolValue) in
      view.backgroundColor = .black
      let company = self.companies[indexPath.row]
      
      //remove the company from our tableView
      self.companies.remove(at: indexPath.row)
      self.tableView.deleteRows(at: [indexPath], with: .fade)
      
      
      //delete company from Core Data
      let context = CoreDataManager.shared.persistentContainer.viewContext
      context.delete(company)
      
      do {
        try context.save()
      } catch let error {
        print("Unable to commit changes after deletion:", error.localizedDescription)
      }
      

    }
    
    let editAction = UIContextualAction(style: .normal, title: "Edit") { (contextAction, view, boolValue) in
      contextAction.backgroundColor = .brown
      contextAction.title = "Hello"
      
      
      print("Editing company...")
    }
    editAction.backgroundColor = .systemGreen
    
    
    
    let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    return swipeActions
  }
  
  
  
  
  
  //MARK: - Header Section

  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = UIView()
    view.backgroundColor = .plum
    return view
  }
  
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  
  
}





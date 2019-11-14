//
//  CompaniesController+UITableView.swift
//  CompanyDatabase
//
//  Created by Igor Tkach on 14.11.2019.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


extension CompaniesController {
  
  
  // MARK: - Setup TableView
   func setupTableView() {
        tableView.register(CompanyCell.self, forCellReuseIdentifier: cellId)
        
        tableView.backgroundColor = .lusciousLavender
        tableView.tableFooterView = UIView() // blank UIView bellow tableView
        tableView.separatorColor = .white
    
  }
  
  
   //MARK: - TableView
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return companies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CompanyCell
      let company = companies[indexPath.row]
      cell.company = company
      return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 60
    }
    

    
    
    // MARK: - TableView Editing
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
      
      let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (contextAction, view, boolValue) in
        view.backgroundColor = .black
        
        self.removeRowAt(indexPath: indexPath)
      }
      
      let editAction = UIContextualAction(style: .normal, title: "Edit") { (contextAction, view, boolValue) in
        
        self.isEditing = false
        let editCompanyController = CreateCompanyController()
        editCompanyController.delegate = self
        editCompanyController.company = self.companies[indexPath.row]
        let navController = CustomNavigationController(rootViewController: editCompanyController)
        self.present(navController, animated: true, completion: {
          
        })
        
        print("Editing company...")
      }
      editAction.backgroundColor = .lusciousLavender
      
      
      
      let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
      return swipeActions
    }
    
    
    
    // MARK: - Editing Function
    private func removeRowAt(indexPath: IndexPath) {
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
    
    
    //MARK: - Header Section

    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      let view = UIView()
      view.backgroundColor = .plum
      return view
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      return 50
    }
    
    
    // MARK: - Footer Section
    
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
      
      let label = UILabel()
      label.text = "No companies available..."
      label.textColor = .white
      label.textAlignment = .center
      label.font = UIFont.boldSystemFont(ofSize: 16)
      return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
      return companies.count == 0 ? 150 : 0
    }
    
    
    
  }





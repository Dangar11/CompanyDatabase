//
//  CompaniesAutoUpdateController.swift
//  CompanyDatabase
//
//  Created by Igor Tkach on 22.11.2019.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit
import CoreData

class CompaniesAutoUpdateController: UITableViewController, NSFetchedResultsControllerDelegate {
  
  // warning code this going to be a bit monster
  
  let cellID = "companyCell"
  
  lazy var fetchResultsController: NSFetchedResultsController<Company> = {
    
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    let request: NSFetchRequest<Company> = Company.fetchRequest()
    
    // sort by name key
    request.sortDescriptors = [
    NSSortDescriptor(key: "name", ascending: true)]
    
    let nfrc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: "name", cacheName: nil)
    
    
    nfrc.delegate = self
    
    
    do {
      try nfrc.performFetch()
    } catch let error {
      print(error.localizedDescription)
    }
    
    
    return nfrc
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(CompanyCell.self, forCellReuseIdentifier: cellID)
    

    
    navigationItem.leftBarButtonItems = [
      UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleAdd)),
      UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(handleDelete))
    ]
    
    navigationItem.title = "Company Auto Updates"
    
    tableView.backgroundColor = UIColor.aqueous
    
  }
  
  //for section
  
  
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
      tableView.beginUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
      switch type {
      case .insert:
          tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
      case .delete:
          tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
      case .move:
          break
      case .update:
          break
      }
  }
  
  
  
  // for cells
func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
    case .insert:
        tableView.insertRows(at: [newIndexPath!], with: .fade)
    case .delete:
        tableView.deleteRows(at: [indexPath!], with: .fade)
    case .update:
        tableView.reloadRows(at: [indexPath!], with: .fade)
    case .move:
        tableView.moveRow(at: indexPath!, to: newIndexPath!)
    }
}
  
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
      tableView.endUpdates()
  }
  
  
  @objc private func handleAdd() {
    print("Let's add a company called BMW")
    
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    let company = Company(context: context)
    company.name = "ZZZZ"
    
    do {
      try context.save()
    } catch let error {
      print(error.localizedDescription)
    }
    
  }

  
  
  @objc func handleDelete() {
    
    let request: NSFetchRequest<Company> = Company.fetchRequest()
    
    request.predicate = NSPredicate(format: "name CONTAINS %@", "Z")
    
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    let companyWithB = try? context.fetch(request)
    
    companyWithB?.forEach { (company) in
      context.delete(company)
    }
    
    try? context.save()
    
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fetchResultsController.sections![section].numberOfObjects
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return fetchResultsController.sections?.count ?? 0
  }
  
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = IndentedLabel()
    label.text = fetchResultsController.sectionIndexTitles[section]
    label.backgroundColor = .white
    return label
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, sectionIndexTitleForSectionName sectionName: String) -> String? {
    return sectionName
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CompanyCell
    let company = fetchResultsController.object(at: indexPath)
    cell.company = company
    return cell
  }
  
}

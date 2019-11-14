//
//  CompaniesController+CreateCompany.swift
//  CompanyDatabase
//
//  Created by Igor Tkach on 14.11.2019.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit

extension CompaniesController: CreateCompanyControllerDelegate {
  
  
  func didAddCompany(company: Company) {
    companies.append(company)
    
    //Index the last element in the Array - 1
    let newIndexPath = IndexPath(row: companies.count - 1, section: 0)
    
    tableView.insertRows(at: [newIndexPath], with: .automatic)
  }
  
  
  func didEditCompany(company: Company) {
    // update my tableView
    
    let row = companies.firstIndex(of: company)
    guard let rowUnwrap = row else { return }
    let reloadIndexPath = IndexPath(row: rowUnwrap, section: 0)
    
    DispatchQueue.main.async {
      self.tableView.reloadRows(at: [reloadIndexPath], with: .middle)
    }
    
  }
  
  
}

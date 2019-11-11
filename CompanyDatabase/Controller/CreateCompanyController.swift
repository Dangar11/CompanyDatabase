//
//  CreateCompanyController.swift
//  CompanyDatabase
//
//  Created by Igor Tkach on 11.11.2019.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class CreateCompanyController: UIViewController {
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .green
    
    setupNavigationStyle(title: "Create Company")
    
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    navigationItem.leftBarButtonItem?.tintColor = .white
  }
  
  
  @objc func handleCancel() {
    dismiss(animated: true)
  }
  
  
  
  
}

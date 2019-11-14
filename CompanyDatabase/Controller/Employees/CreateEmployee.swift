//
//  CreateEmployee.swift
//  CompanyDatabase
//
//  Created by Igor Tkach on 14.11.2019.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class CreateEmployeeController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigationStyle(title: "Create Employee")
    
    setupCancelButtonInNavigationBar()
    
    
    view.backgroundColor = .red
  }
  
  
  @objc func handleCancel() {
    dismiss(animated: true, completion: nil)
  }
  
}

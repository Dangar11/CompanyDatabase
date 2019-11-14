//
//  CreateEmployee.swift
//  CompanyDatabase
//
//  Created by Igor Tkach on 14.11.2019.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


class CreateEmployeeController: UIViewController {
  
  
  let nameLabel: UILabel = {
     let label = UILabel()
     label.text = "Name"
     label.translatesAutoresizingMaskIntoConstraints = false
     return label
   }()
   
   let nameTextField: UITextField = {
     let textField = UITextField()
     textField.becomeFirstResponder()
     textField.placeholder = "Enter name"
     textField.translatesAutoresizingMaskIntoConstraints = false
     return textField
   }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigationStyle(title: "Create Employee")
    
    setupCancelButtonInNavigationBar()
    
    setupUI()
    
    setupSaveButtonNavigationBar(action: #selector(handleSave))
    
    view.backgroundColor = .chinaRose
  }
  
  @objc private func handleSave() {
    
    guard let employeeError = nameTextField.text else { return }
    
    let error = CoreDataManager.shared.createEmployee(setValue: employeeError)
    
    if let error = error {
      // present an error modal
      print(error)
    } else {
      dismiss(animated: true, completion: nil)
    }
    
    
  }
  
  
  @objc private func handleCancel() {
    dismiss(animated: true, completion: nil)
  }
  
  private func setupUI() {
    
    let lightBlueBackgroundView = setupLightBlueBackground(withHeight: 50)
    lightBlueBackgroundView.addSubview(nameLabel)
    nameLabel.topAnchor.constraint(equalTo: lightBlueBackgroundView.topAnchor).isActive = true
    nameLabel.leadingAnchor.constraint(equalTo: lightBlueBackgroundView.leadingAnchor, constant: 16).isActive = true
    nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
    nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    lightBlueBackgroundView.addSubview(nameTextField)
    nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
    nameTextField.trailingAnchor.constraint(equalTo: lightBlueBackgroundView.trailingAnchor).isActive = true
    nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    nameTextField.topAnchor.constraint(equalTo: lightBlueBackgroundView.topAnchor).isActive = true
    
    
  }
  
}

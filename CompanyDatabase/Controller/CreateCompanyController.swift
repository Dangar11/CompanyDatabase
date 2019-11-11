//
//  CreateCompanyController.swift
//  CompanyDatabase
//
//  Created by Igor Tkach on 11.11.2019.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


//Custom Delegation

protocol CreateCompanyControllerDelegate {
  func didAddCompany(company: Company)
}

class CreateCompanyController: UIViewController {
  
  
  var delegate: CreateCompanyControllerDelegate?
  
  
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
    
    setupUI()
    
    view.backgroundColor = .lusciousLavender
    
    setupNavigationStyle(title: "Create Company")
    
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    navigationItem.leftBarButtonItem?.tintColor = .white
    navigationItem.rightBarButtonItem?.tintColor = .white
  }
  
  
  
  
  
  @objc private func handleCancel() {
    dismiss(animated: true)
  }
  
  @objc private func handleSave() {
    print("save")
    
    dismiss(animated: true) { [weak self] in 
      guard let name = self?.nameTextField.text else { return }
      
      let company = Company(name: name, founded: Date())
      
      self?.delegate?.didAddCompany(company: company)
    }

    
  }
  
  
  private func setupUI() {
    
    let lightBlueBackgroundView = UIView()
    lightBlueBackgroundView.backgroundColor = UIColor.plum
    view.addSubview(lightBlueBackgroundView)
    
    lightBlueBackgroundView.translatesAutoresizingMaskIntoConstraints = false
    lightBlueBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    lightBlueBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    lightBlueBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    lightBlueBackgroundView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    
    lightBlueBackgroundView.addSubview(nameLabel)
    nameLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
    nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
    nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    lightBlueBackgroundView.addSubview(nameTextField)
    nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
    nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    nameTextField.topAnchor.constraint(equalTo: view.topAnchor).isActive = true

  }
  
  
  
}

//
//  CreateEmployee.swift
//  CompanyDatabase
//
//  Created by Igor Tkach on 14.11.2019.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit

protocol CreateEmployeeControllerDelegate {
  
  func didAddEmployee(employee: Employee)
}


class CreateEmployeeController: UIViewController {
  
  var company: Company?
  
  var delegate: CreateEmployeeControllerDelegate?
  
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
  
  let birthdayLabel: UILabel = {
    let label = UILabel()
    label.text = "Birthday"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let birthdayTextField: UITextField = {
    let textField = UITextField()
    textField.becomeFirstResponder()
    textField.placeholder = "dd.MM.yy"
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
  
  
  let employeeTypeSegmentedControl: UISegmentedControl = {
    let types = ["TechLead", "Senior", "Employee"]
    let segmentControl = UISegmentedControl(items: types)
    segmentControl.selectedSegmentIndex = 0
    segmentControl.translatesAutoresizingMaskIntoConstraints = false
    segmentControl.backgroundColor = UIColor.aqueous
    segmentControl.selectedSegmentTintColor = UIColor.plum
    return segmentControl
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
    
    guard let employeeName = nameTextField.text,
      let companyName = company,
      let birthayText = birthdayTextField.text else { return }
    
    //Validation
    
    if birthayText.isEmpty {
      showError(title: "Birthday field is empty", message: "Please enter birthday date")
      return
    } else if employeeName.isEmpty {
      showError(title: "You don't enter the name", message: "Please enter the name of a person")
      return
    }

       //save birthday into data object
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yy"
    
    let birthdayDate = dateFormatter.date(from: birthayText)
    guard let bornDate = birthdayDate else {
     showError(title: "The date isn't vali  d", message: "Please enter valid date format")
      return }
    
    guard let employeeType = employeeTypeSegmentedControl.titleForSegment(at: employeeTypeSegmentedControl.selectedSegmentIndex) else { return }
  
    
    let employeeData = CoreDataManager.shared.createEmployee(employeeName: employeeName, birthday: bornDate, employeeType: employeeType, company: companyName)
    
    let (employee, error) = employeeData
    
    if let error = error {
      // present an error modal
      print(error)
    } else {
      //creation success
      dismiss(animated: true, completion: {
        //delegate
        guard let employeeData = employee else { return }
        self.delegate?.didAddEmployee(employee: employeeData)
      })
    }
    
    
  }
  
  
  @objc private func handleCancel() {
    dismiss(animated: true, completion: nil)
  }
  
  
  private func showError(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default))
         present(alert, animated: true, completion: nil)
  }
  
  private func setupUI() {
    
    let lightBlueBackgroundView = setupLightBlueBackground(withHeight: 150)
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
    
    lightBlueBackgroundView.addSubview(birthdayLabel)
    birthdayLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
    birthdayLabel.leadingAnchor.constraint(equalTo: lightBlueBackgroundView.leadingAnchor, constant: 16).isActive = true
    birthdayLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
    birthdayLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    lightBlueBackgroundView.addSubview(birthdayTextField)
    birthdayTextField.leadingAnchor.constraint(equalTo: birthdayLabel.trailingAnchor).isActive = true
    birthdayTextField.trailingAnchor.constraint(equalTo: lightBlueBackgroundView.trailingAnchor).isActive = true
    birthdayTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    birthdayTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
    
    lightBlueBackgroundView.addSubview(employeeTypeSegmentedControl)
    employeeTypeSegmentedControl.leadingAnchor.constraint(equalTo: lightBlueBackgroundView.leadingAnchor, constant: 16).isActive = true
    employeeTypeSegmentedControl.trailingAnchor.constraint(equalTo: lightBlueBackgroundView.trailingAnchor, constant: -16).isActive = true
    employeeTypeSegmentedControl.heightAnchor.constraint(equalToConstant: 44).isActive = true
    employeeTypeSegmentedControl.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor).isActive = true
    
    
  }
  
}

//
//  CreateCompanyController.swift
//  CompanyDatabase
//
//  Created by Igor Tkach on 11.11.2019.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit
import CoreData


//MARK: - Custom Delegate

protocol CreateCompanyControllerDelegate {
  func didAddCompany(company: Company)
  func didEditCompany(company: Company)
}

//MARK: - Controller

class CreateCompanyController: UIViewController {
  
  // MARK: - Properties
  var company: Company? {
    didSet {
      nameTextField.text = company?.name
      
      guard let founded = company?.founded else { return }
      datePicker.date = founded
    }
  }
  
  var delegate: CreateCompanyControllerDelegate?
  
  
  lazy var companyImageView: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.isUserInteractionEnabled = true // interect with view
    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
    return imageView
  }()
  
  
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
  
  let datePicker: UIDatePicker = {
    let dp = UIDatePicker()
    dp.datePickerMode = .date
    dp.translatesAutoresizingMaskIntoConstraints = false
    return dp
  }()
  
  
  //MARK: - View Lifecycle
  
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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    
    navigationItem.title = company == nil ? "Create Company" : "Edit Company"
  }
  
  
  // MARK: - Interaction Func
  @objc private func handleSelectPhoto() {
    print("Select photo")
    
    let alert = UIAlertController(title: "Choose the photo", message: nil, preferredStyle: .actionSheet)
    let libraryAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
      self.getImage(fromSourceType: .photoLibrary)
    }
    let photoAction = UIAlertAction(title: "Make Photo", style: .default) { (action) in
      
      self.getImage(fromSourceType: .camera)
    }
    
    alert.addAction(libraryAction)
    alert.addAction(photoAction)
    
    self.present(alert, animated: true, completion: nil)
    
  }
  
  
  @objc private func handleCancel() {
    dismiss(animated: true)
  }
  
  @objc private func handleSave() {
    
    
    switch company?.name {
    case .none: createCompany()
    default: saveCompanyChanges()
    }
    
  
  }
  
  
  
  // MARK: - Functionality
  
  func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {

      //Check is source type available
      if UIImagePickerController.isSourceTypeAvailable(sourceType) {

          let imagePickerController = UIImagePickerController()
          imagePickerController.delegate = self
          imagePickerController.allowsEditing = true
          imagePickerController.sourceType = sourceType
          self.present(imagePickerController, animated: true, completion: nil)
      }
  }
  func saveCompanyChanges() {
    
    
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    company?.name = nameTextField.text
    company?.founded = datePicker.date
    
    do {
      try context.save()
      
      //save succeded
      dismiss(animated: true, completion: { [weak self] in
        guard let company = self?.company else { return }
        self?.delegate?.didEditCompany(company: company)
      })
    } catch let error {
      print("Error occur during editing end persistance: ", error.localizedDescription )
    }
    
    
  }
  
  
  private func createCompany() {
    
    //initalization of our Core Data stack
    
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
    
    company.setValue(self.nameTextField.text, forKey: "name")
    company.setValue(datePicker.date, forKey: "founded")
    
    // perform the save
    
    do {
      try context.save()
      
      //success
      dismiss(animated: true) { [weak self] in
        
        self?.delegate?.didAddCompany(company: company as! Company)
        
      }
    } catch let error {
      print("Failed to save company:", error.localizedDescription)
    }
  }
  
  
  //MARK: - SETUP UI
  
  private func setupUI() {
    
    let lightBlueBackgroundView = UIView()
    lightBlueBackgroundView.backgroundColor = UIColor.plum
    view.addSubview(lightBlueBackgroundView)
    
    lightBlueBackgroundView.translatesAutoresizingMaskIntoConstraints = false
    lightBlueBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    lightBlueBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    lightBlueBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    lightBlueBackgroundView.heightAnchor.constraint(equalToConstant: 400).isActive = true
    
    
    lightBlueBackgroundView.addSubview(companyImageView)
    companyImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
    companyImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    companyImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    companyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
    lightBlueBackgroundView.addSubview(nameLabel)
    nameLabel.topAnchor.constraint(equalTo: companyImageView.bottomAnchor).isActive = true
    nameLabel.leadingAnchor.constraint(equalTo: lightBlueBackgroundView.leadingAnchor, constant: 16).isActive = true
    nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
    nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    lightBlueBackgroundView.addSubview(nameTextField)
    nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
    nameTextField.trailingAnchor.constraint(equalTo: lightBlueBackgroundView.trailingAnchor).isActive = true
    nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    nameTextField.topAnchor.constraint(equalTo: companyImageView.bottomAnchor).isActive = true
    
    lightBlueBackgroundView.addSubview(datePicker)
    datePicker.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
    datePicker.leadingAnchor.constraint(equalTo: lightBlueBackgroundView.leadingAnchor).isActive = true
    datePicker.trailingAnchor.constraint(equalTo: lightBlueBackgroundView.trailingAnchor).isActive = true
    datePicker.bottomAnchor.constraint(equalTo: lightBlueBackgroundView.bottomAnchor).isActive = true
    
  }
  
  
  
}


//MARK: - ImagePicker
extension CreateCompanyController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
  
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
      companyImageView.image = editedImage
    } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      companyImageView.image = originalImage
    }
    
    dismiss(animated: true, completion: nil)
  }
  
  
}

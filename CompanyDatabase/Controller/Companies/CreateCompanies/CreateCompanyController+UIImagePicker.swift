//
//  CreateCompanyController+UIImagePicker.swift
//  CompanyDatabase
//
//  Created by Igor Tkach on 14.11.2019.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit

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
    
    imageRoundsToBounds(imageView: companyImageView)
    
    
    dismiss(animated: true, completion: nil)
  }
  
   func imageRoundsToBounds(imageView: UIImageView) {
   imageView.layer.cornerRadius = imageView.frame.width / 2
   imageView.clipsToBounds = true
   imageView.layer.borderColor = UIColor.lusciousLavender.cgColor
   imageView.layer.borderWidth = 2
  }
  
  
  @objc func handleSelectPhoto() {
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
  
  
  
}

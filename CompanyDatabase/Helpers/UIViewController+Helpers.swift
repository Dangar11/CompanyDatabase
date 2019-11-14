//
//  Utility.swift
//  CompanyDatabase
//
//  Created by Igor Tkach on 14.11.2019.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit

extension UIViewController {
  
  //Helper Methods
  
  func setupPlusButtonInNavigationBar(action: Selector?) {
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: action)
  }
  
  func setupCancelButtonInNavigationBar() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    navigationItem.leftBarButtonItem?.tintColor = .white
  }
  
  
  @objc private func handleCancel() {
    dismiss(animated: true)
  }
  
}


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
  
  func setupSaveButtonNavigationBar(action: Selector?) {
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: action)
    navigationItem.rightBarButtonItem?.tintColor = .white
  }
  
  
  @objc private func handleCancel() {
    dismiss(animated: true)
  }
  
  
  func setupLightBlueBackground(withHeight: CGFloat) -> UIView {
    
    let lightBlueBackgroundView = UIView()
    lightBlueBackgroundView.backgroundColor = UIColor.plum
    view.addSubview(lightBlueBackgroundView)
    
    lightBlueBackgroundView.translatesAutoresizingMaskIntoConstraints = false
    lightBlueBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    lightBlueBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    lightBlueBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    lightBlueBackgroundView.heightAnchor.constraint(equalToConstant: withHeight).isActive = true
    
    return lightBlueBackgroundView
    
  }
  
}


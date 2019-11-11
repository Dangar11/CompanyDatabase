//
//  UIViewController+NavigationStyle.swift
//  CompanyDatabase
//
//  Created by Igor Tkach on 11.11.2019.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit


extension UIViewController {
  
  
  func setupNavigationStyle(title: String) {
    
        navigationItem.title = title
    
    navigationController?.navigationBar.isTranslucent = false
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.view.backgroundColor = .chinaRose
    navigationController?.navigationBar.barTintColor = .chinaRose
    
    navigationController?.navigationBar.titleTextAttributes =
      [NSAttributedString.Key.foregroundColor: UIColor.white]
    navigationController?.navigationBar.largeTitleTextAttributes =
      [NSAttributedString.Key.foregroundColor: UIColor.white]
    
  }
  
}

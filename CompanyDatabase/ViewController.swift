//
//  ViewController.swift
//  CompanyDatabase
//
//  Created by Igor Tkach on 10.11.2019.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    view.backgroundColor = .white
    
    navigationItem.title = "Companies"
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleCompany))
    
    setupNavigationStyle()
    
    
  }
  
  
  // MARK: - Set Navigation Style
  func setupNavigationStyle() {
    
    navigationController?.navigationBar.isTranslucent = false
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.view.backgroundColor = UIColor.chinaRose
    
    navigationController?.navigationBar.largeTitleTextAttributes =
      [NSAttributedString.Key.foregroundColor: UIColor.white]
    
  }

  
  @objc func handleCompany() {
    
  }
  
  
  

}





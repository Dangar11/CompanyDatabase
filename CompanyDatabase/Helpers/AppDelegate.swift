//
//  AppDelegate.swift
//  CompanyDatabase
//
//  Created by Igor Tkach on 10.11.2019.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    window = UIWindow()
    window?.makeKeyAndVisible()
    
    let companiesController = CompaniesAutoUpdateController()
    let navController = CustomNavigationController(rootViewController: companiesController)
    window?.rootViewController = navController
    
    return true
  }


}


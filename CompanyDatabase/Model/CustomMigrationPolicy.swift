//
//  CustomMigrationPolicy.swift
//  CompanyDatabase
//
//  Created by Igor Tkach on 23.11.2019.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import CoreData

class CustomMigrationPolicy: NSEntityMigrationPolicy {
  
  // transformation function here
  
  
  @objc func transformNumEmployeesForNum(forNum: NSNumber) -> String {
    if forNum.intValue < 150 {
      return "small"
    } else {
    return "very large"
    }
  }
  
}

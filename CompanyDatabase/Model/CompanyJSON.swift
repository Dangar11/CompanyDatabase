//
//  CompanyJSON.swift
//  CompanyDatabase
//
//  Created by Igor Tkach on 22.11.2019.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import Foundation

// Model for JSON Parsing

struct CompanyJSON: Decodable {
  
  let name: String
  let founded: String
  let photoUrl: URL
  let employees: [EmployeeJSON]?
  
}


struct EmployeeJSON: Decodable {
  let name: String
  let birthday: String
  let type: String
}

//
//  Service.swift
//  CompanyDatabase
//
//  Created by Igor Tkach on 22.11.2019.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import Foundation
import CoreData


struct JSONService {
  
  static let shared = JSONService()
  
  let urlString = "https://api.letsbuildthatapp.com/intermediate_training/companies"
  
  func downloadCompaniesFromServer() {
    print("Attempting to download companies")
    
    guard let url = URL(string: urlString) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      
      if let error = error {
        print("Failed to download data from JSON", error)
        return
      }
      
      guard let data = data else { return }
      let jsonDecoder = JSONDecoder()
      
      do {
        let jsonCompanies = try jsonDecoder.decode([CompanyJSON].self, from: data)
        
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        privateContext.parent = CoreDataManager.shared.persistentContainer.viewContext
        
        jsonCompanies.forEach { (jsonCompany) in
          
          print(jsonCompany.name)
          
          let company  = Company(context: privateContext)
          company.name = jsonCompany.name
          
          // Date formatter
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "MM/dd/yyyy"
          let foundedDate = dateFormatter.date(from: jsonCompany.founded)
          
          company.founded = foundedDate
          
          // employee fetching
          
          jsonCompany.employees?.forEach({ (jsonEmployee) in
            print("\(jsonEmployee.name)")
            let employee = Employee(context: privateContext)
            
            employee.name = jsonEmployee.name
            employee.type = jsonEmployee.type
            let birthdayDate = dateFormatter.date(from: jsonEmployee.birthday)
            employee.birthday = birthdayDate
            employee.company = company
            
          })
          
          // save to the context
          do {
            try privateContext.save()
            try privateContext.parent?.save()
          } catch let error {
            print("Failed to save companies to CoreData: ", error.localizedDescription)
          }
          
        }
        
      } catch let error {
        print("Failed to decode JSON: ", error.localizedDescription)
      }
      
    }.resume()
  }
  
}

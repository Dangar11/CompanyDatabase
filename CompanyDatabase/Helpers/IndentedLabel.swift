//
//  File.swift
//  CompanyDatabase
//
//  Created by Igor Tkach on 16.11.2019.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit

class IndentedLabel: UILabel {
  
  
  override func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)))
  }
  
  

}

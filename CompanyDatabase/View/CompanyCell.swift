//
//  CompanyCell.swift
//  CompanyDatabase
//
//  Created by Igor Tkach on 14.11.2019.
//  Copyright © 2019 Igor Tkach. All rights reserved.
//

import UIKit

class CompanyCell: UITableViewCell {
  
  
  var company: Company? {
    didSet {
      if let name = company?.name, let founded = company?.founded {

        
        //Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        let dateFounded = dateFormatter.string(from: founded)

        let dateString = "\(name) - Founded : \(dateFounded)"
        nameFoundedLabel.text = dateString

      } else {
        nameFoundedLabel.text = company?.name
      }
      
      if let companyImage = company?.imageData {
        companyImageView.image = UIImage(data: companyImage)
      }
    }
  }
  
  let companyImageView: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
    imageView.contentMode = .scaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.cornerRadius = 20
    imageView.clipsToBounds = true
    imageView.layer.borderColor = UIColor.lusciousLavender.cgColor
    imageView.layer.borderWidth = 2
    return imageView
  }()
  
  let nameFoundedLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textColor = .white
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
      setupUI()
     backgroundColor = .aqueous
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    addSubview(companyImageView)
    companyImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    companyImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
    companyImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
    companyImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    
    
    addSubview(nameFoundedLabel)
    nameFoundedLabel.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: 10).isActive = true
    nameFoundedLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    nameFoundedLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
  }
  
}

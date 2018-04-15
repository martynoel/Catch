//
//  ItemCell.swift
//  Catch
//
//  Created by Mimi Chenyao on 4/12/18.
//  Copyright © 2018 Mimi Chenyao. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    // MARK: Properties
    
    var itemImage: UIImage!
    var itemImageView: UIImageView!
    var itemNameLabel: UILabel!
    var dateLastWornLabel: UILabel!
    
    // MARK: Initialization
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
    }
    
    // MARK: View setup
    
    func setUpViews() {
        
        // Item image
        itemImage = UIImage(named: "catchLogo")
        itemImageView = UIImageView(image: itemImage!)
        
        contentView.addSubview(itemImageView)
        
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        
        itemImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 9).isActive = true
        itemImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 9).isActive = true
        itemImageView.widthAnchor.constraint(equalToConstant: 73).isActive = true
        itemImageView.heightAnchor.constraint(equalToConstant: 73).isActive = true
        
        // Item name label
        itemNameLabel = UILabel()
        itemNameLabel.text = "Item name"
        itemNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        itemNameLabel.lineBreakMode = .byWordWrapping
        itemNameLabel.numberOfLines = 0
        
        contentView.addSubview(itemNameLabel)
        
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        itemNameLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10).isActive = true
        itemNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        // Date last worn label
        dateLastWornLabel = UILabel()
        dateLastWornLabel.text = "Date last worn"
        dateLastWornLabel.lineBreakMode = .byWordWrapping
        dateLastWornLabel.numberOfLines = 0
        
        contentView.addSubview(dateLastWornLabel)
        
        dateLastWornLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLastWornLabel.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 5).isActive = true
        dateLastWornLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10).isActive = true
    }
}

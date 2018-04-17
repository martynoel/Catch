//
//  Item.swift
//  Catch
//
//  Created by Mimi Chenyao on 4/12/18.
//  Copyright © 2018 Mimi Chenyao. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
    
    // MARK: Properties
    
    var image: UIImage
    var name: String
    var dateLastWorn: Date
    var dateLastWornString: String
    let dateAddedString: String
    
    // MARK: Initialization
    
    init(called name: String, with image: UIImage) {
        
        self.image = image
        self.name = name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "en_US")
        
        let dateAdded = Date()
        self.dateLastWorn = Date()
        
        self.dateAddedString = dateFormatter.string(from: dateAdded)
        self.dateLastWornString = dateFormatter.string(from: dateLastWorn)
        
        super.init()
    }
    
    // MARK: Methods
    
    func updateDateLastWorn() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "en_US")
        
        self.dateLastWorn = Date()
        self.dateLastWornString = dateFormatter.string(from: dateLastWorn)
    }
    
    // MARK: NSCoding methods
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(image, forKey: "image")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(dateLastWorn, forKey: "dateLastWorn")
        aCoder.encode(dateLastWornString, forKey: "dateLastWornString")
        aCoder.encode(dateAddedString, forKey: "dateAddedString")
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        image = aDecoder.decodeObject(forKey: "image") as! UIImage
        name = aDecoder.decodeObject(forKey: "name") as! String
        dateLastWorn = aDecoder.decodeObject(forKey: "dateLastWorn") as! Date
        dateLastWornString = aDecoder.decodeObject(forKey: "dateLastWornString") as! String
        dateAddedString = aDecoder.decodeObject(forKey: "dateAddedString") as! String
        
        super.init()
    }
}

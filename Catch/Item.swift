//
//  Item.swift
//  Catch
//
//  Created by Mimi Chenyao on 4/12/18.
//  Copyright © 2018 Mimi Chenyao. All rights reserved.
//

import UIKit

class Item: NSObject {
    
    var image: UIImage
    var name: String
    let dateAddedString: String
    var dateLastWorn: Date
    var dateLastWornString: String
    
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
    
    convenience init(random: Bool = false) {
        
        let image = UIImage(named: "catchLogo")
        
        if random {
            
            let colors = ["White", "Pink", "Red", "Orange", "Yellow", "Green", "Aqua", "Blue", "Navy", "Light Purple", "Violet", "Gray", "Black", "Patterned"]
            let brands = ["Abercrombie", "Lilly Pulitzer", "H&M"]
            
            // Selects random color from colors array
            var randomIndex = arc4random_uniform(UInt32(colors.count))
            let randomColor = colors[Int(randomIndex)]
            
            // Selects random brand from brands array
            randomIndex = arc4random_uniform(UInt32(brands.count))
            let randomBrand = brands[Int(randomIndex)]
            
            // Creates random dress name from color and brand
            let randomName = "\(randomColor) \(randomBrand) dress"
            
            //            let name = "Hello, my name is Mimi and I'm looking for a super long string of text. Haha hey."
            
            self.init(called: randomName, with: image!)
        }
            
        else {
            self.init(called: "", with: image!)
        }
    }
    
    func updateDateLastWorn() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "en_US")
        
        self.dateLastWorn = Date()
        self.dateLastWornString = dateFormatter.string(from: dateLastWorn)
    }
}

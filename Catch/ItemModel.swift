//
//  ItemModelController.swift
//  Catch
//
//  Created by Mimi Chenyao on 4/12/18.
//  Copyright © 2018 Mimi Chenyao. All rights reserved.
//

import UIKit

// Singleton database for items
class ItemModelController {
    
    // MARK: Properties
    
    var allItems = [Item]()
    
    // Create URL to save data to
    let itemArchiveURL: URL = {
        
        // Look for URL in filesystem that matches given requirements
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent("items.archive")
    }()
    
    // MARK: Initialization
    
    init() {
        
        // Unarchive all archived Items and put them in allItems array
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Item] {
            allItems = archivedItems
        }
    }
    
    // MARK: Methods
    
    @discardableResult func createItem(called name: String, with image: UIImage) -> Item {
        let newItem = Item(called: name, with: image)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    func removeItem(_ item: Item) {
        // Remove item at certain index in "allItems" array
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    // Goes along with tableView(_:moveRowAt:to:) in ItemVC
    func moveItem(from oldIndex: Int, to newIndex: Int) {
        
        if oldIndex == newIndex {
            return
        }
        
        // Get the item being moved in order to reinsert it into the array
        let movedItem = allItems[oldIndex]
        
        // Remove and re-insert
        allItems.remove(at: oldIndex)
        allItems.insert(movedItem, at: newIndex)
    }
    
    func saveChanges() -> Bool {
        
        print("Saving items to: \(itemArchiveURL.path)")
        
        // Saves all Items in allItems to the itemArchiveURL
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path)
    }
}

//
//  ItemTableViewDelegate.swift
//  Catch
//
//  Created by Mimi Chenyao on 4/16/18.
//  Copyright © 2018 Mimi Chenyao. All rights reserved.
//

import UIKit

class ItemTableViewDelegate: NSObject {
    
    let itemModelController: ItemModelController
    let navigationController: UINavigationController
    
    init(tableView: UITableView, itemModelController: ItemModelController, navigationController: UINavigationController) {
        
        self.itemModelController = itemModelController
        self.navigationController = navigationController
        
        super.init()
        
        tableView.delegate = self
    }
}

extension ItemTableViewDelegate: UITableViewDelegate {
    // Select an item row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Figure out which row was just tapped
        if let row = tableView.indexPathForSelectedRow?.row {
            
            // Get item associated with this row and pass it along
            let item = itemModelController.allItems[row]
            
            let destination = ItemDetailViewController()
            destination.item = item // getting the item and give it to ItemDetailVC. Dependency injection woohoo!
            self.navigationController.pushViewController(destination, animated: true)
        }
    }
}

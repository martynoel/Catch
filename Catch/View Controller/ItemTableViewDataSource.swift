//
//  ItemTableViewDataSource.swift
//  Catch
//
//  Created by Mimi Chenyao on 4/16/18.
//  Copyright © 2018 Mimi Chenyao. All rights reserved.
//

import UIKit

class ItemTableViewDataSource: NSObject {
    
    // MARK: Properties
    
    let itemModelController: ItemModelController
    let tableViewController: UITableViewController
    let navigationController = UINavigationController()
    
    // MARK: Initialization
    
    init(tableView: UITableView, itemModelController: ItemModelController, tableViewController: UITableViewController) {
        
        self.itemModelController = itemModelController
        
        self.tableViewController = tableViewController // needed to present delete alert controller
        
        super.init()
        
        tableView.dataSource = self
    }
}

extension ItemTableViewDataSource: UITableViewDataSource {
    
    // "How many rows should I display in this section?"
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemModelController.allItems.count
    }
    
    // "What should I display in this row?"
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Reusing cells to save memz: GOTTA REGISTER TABLE VIEW TYPE (inc. custom classes) FIRST
        tableView.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        let item = itemModelController.allItems[indexPath.row]
        
        cell.itemImageView.image = item.image
        cell.itemNameLabel?.text = item.name
        cell.dateLastWornLabel?.text = "Last worn: \(item.dateLastWornString)"
        cell.dateLastWornLabel?.textColor = UIColor.darkGray
        
        return cell
    }
    
    
    // Asks data source to commit to insertion/deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // If table view asks to commit a delete command, find and remove the item from the data store, and remove the row from the table with an animation
        if editingStyle == .delete {
            
            // Add alert before deleting!
            let deleteAlert = UIAlertController(title: "Delete Item?", message: "Are you sure you want to delete this item? You'll have to add it again if you want it back.", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                
                // Deleting the item
                let item = self.itemModelController.allItems[indexPath.row]
                self.itemModelController.removeItem(item)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (clickCancel) in
                
                self.navigationController.popViewController(animated: true)
            }
            
            deleteAlert.addAction(deleteAction)
            deleteAlert.addAction(cancelAction)
            
            tableViewController.present(deleteAlert, animated: true, completion: nil)
        }
    }
    
    // Table view moves a row and reports it to its data source.
    // Works with moveItem() in item store backend
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemModelController.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
}

//
//  ItemTableViewController.swift
//  Catch
//
//  Created by Mimi Chenyao on 4/12/18.
//  Copyright © 2018 Mimi Chenyao. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var itemModel: ItemModelController! // set in App Delegate
    
    // MARK: View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 90
        
        setUpNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: View setup
    
    func setUpNavBar() {
        self.navigationItem.title = "My Items"
        
        // Use view controller's built-in edit bar button item
        self.navigationItem.leftBarButtonItem = editButtonItem
        
        // Create and set right bar button item to "add"
        let addItemButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addItem))
        self.navigationItem.rightBarButtonItem = addItemButton
    }
    
    // MARK: Selectors
    
    @objc func addRandomItem(_ sender: UIBarButtonItem) {
        
        // Create a new item and add it to the store first
        let newItem = itemModel.createItem(called: "New Item", with: UIImage(named: "fadedCatchLogo_frame")!)
        
        // Figure out where that new item is in the store's array of items
        if let index = itemModel.allItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            
            // And then insert this new item into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @objc func addItem(_ sender: UIBarButtonItem) {
        
        let destination = AddItemViewController()
        destination.itemModel = itemModel // getting the item model and give it to AddItemVC. Dependency injection woohoo!
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: Table view delegate methods
    
    // "How many rows should I display in this section?"
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemModel.allItems.count
    }
    
    // Select an item row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Figure out which row was just tapped
        if let row = tableView.indexPathForSelectedRow?.row {
            
            // Get item associated with this row and pass it along
            let item = itemModel.allItems[row]
            
            let destination = ItemDetailViewController()
            destination.item = item // getting the item and give it to ItemDetailVC. Dependency injection woohoo!
            self.navigationController?.pushViewController(destination, animated: true)
        }
    }
    
    // MARK: Table View data source methods
    
    // "What should I display in this row?"
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Reusing cells to save memz: GOTTA REGISTER TABLE VIEW TYPE (inc. custom classes) FIRST
        self.tableView.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        let item = itemModel.allItems[indexPath.row]
        
        cell.itemImageView.image = item.image
        cell.itemNameLabel?.text = item.name
        cell.dateLastWornLabel?.text = "Last worn: \(item.dateLastWornString)"
        cell.dateLastWornLabel?.textColor = UIColor.darkGray
        
        return cell
    }
    
    // Asks data source to commit to insertion/deletion
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // If table view asks to commit a delete command, find and remove the item from the data store, and remove the row from the table with an animation
        if editingStyle == .delete {
            let item = itemModel.allItems[indexPath.row]
            itemModel.removeItem(item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // Table view moves a row and reports it to its data source.
    // Works with moveItem() in item store backend
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemModel.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
}

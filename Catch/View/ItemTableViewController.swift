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
    
    var itemModelController: ItemModelController! // set in App Delegate
    var itemTableViewDataSource: ItemTableViewDataSource?
    var itemTableViewDelegate: ItemTableViewDelegate?
    
    // MARK: View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 90
        
        setUpNavBar()
        
        // Set up data source and delegate in separate classes
        if let itemModelController = itemModelController {
            
            itemTableViewDataSource = ItemTableViewDataSource(tableView: tableView, itemModelController: itemModelController, tableViewController: self)
            itemTableViewDelegate = ItemTableViewDelegate(tableView: tableView, itemModelController: itemModelController, navigationController: self.navigationController!)
        }
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
        let newItem = itemModelController.createItem(called: "New Item", with: UIImage(named: "fadedCatchLogo_frame")!)
        
        // Figure out where that new item is in the store's array of items
        if let index = itemModelController.allItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            
            // And then insert this new item into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @objc func addItem(_ sender: UIBarButtonItem) {
        
        let destination = AddItemViewController()
        destination.itemModelController = itemModelController // getting the item model and give it to AddItemVC. Dependency injection woohoo!
        self.navigationController?.pushViewController(destination, animated: true)
    }
}

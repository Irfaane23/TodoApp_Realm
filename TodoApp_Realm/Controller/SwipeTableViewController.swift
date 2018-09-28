//
//  SwipeTableViewController.swift
//  TodoApp_Realm
//
//  Created by Irfaane Ousseny on 16/09/2018.
//  Copyright © 2018 Irfaane. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    let rowHeight : CGFloat = 80.0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = rowHeight
        
        tableView.separatorStyle = .none
    }
    
    
    //-----------------------------------------------------------------------------------------------------------
    //MARK: - Swipe TableView Delegate Methods
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            //this method here is to catch the reference of the Category and Item VC
            self.updateModel(at: indexPath)
            
            // self.tableView.reloadData()
            
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        return [deleteAction]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    func updateModel(at : IndexPath) {
        //update the data model
    }
}

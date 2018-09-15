//
//  ViewController.swift
//  TodoApp_Realm
//
//  Created by Irfaane Ousseny on 15/09/2018.
//  Copyright © 2018 Irfaane. All rights reserved.
//


import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    
   // let realm = try! Realm()
    var itemArray : [Item] = [Item]()
    
    var selectedCategory : Category? {
        didSet {
       //     loadDataItems()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // loadDataItems()
    }
    
    //TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    //TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //Add new item in the TableView
    @IBAction func addPressedButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        //Add a pop-up alert
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        //button that we're going to pressed after we have written our new item
        let alertAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user have pressed the button
            // -> we add at the end of the itemArray the new item we create
            
            let newItem = Item()
            newItem.title = textField.text!
            newItem.done = false // we have to specify this field because in the DataModel, we set the done attributes as not an optionnal
            //newItem.parentCategory = self.selectedCategory
            
            self.itemArray.append(newItem)
            
            
            //self.save(dataItem: newItem)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(alertAction)
        
        //show the alert
        present(alert,animated: true, completion: nil)
    }
    
    
    //Model manipulation data
    
/*    private func save(dataItem : Item) {
        //CRUD Version : Here we Create Data
        do {
            try realm.write {
                realm.add(dataItem)
            }
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    
/*    func loadDataItems(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        //CRUD Version : Here we Read Data from the database
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        //        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        }
        else {
            request.predicate = categoryPredicate
            
        }
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context : \(error)")
        }
        tableView.reloadData()
    }
    */
    // Edit a row cell of the tableView in order to delete an item in the itemArray
    /*   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     return true
     }
     
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     itemArray.remove(at: indexPath.row)
     tableView.reloadData()
     }
     }
     */
    
}
/*
// MARK: - Search Bar methods
extension TodoListViewController : UISearchBarDelegate {
    
    // Query the database
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadDataItems(with: request, predicate: predicate)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadDataItems()
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadDataItems()
            
            //ask to the main thread to perform the going back to the original list
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
 
}

*/

 */

 }

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
    
    let realm = try! Realm()
    var todoItems : Results<Item>?
    
    var selectedCategory : Category? {
        didSet {
            loadDataItems()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDataItems()
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = (todoItems?[indexPath.row].done)! ? .checkmark : .none
        }
        else {
            cell.textLabel?.text = "No Item added yet"
          //  cell.accessoryType = (todoItems?[indexPath.row].done)! ? .checkmark : .none
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //CRUD : Update Data from the Realm Database
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                    
                    //CRUD : Delete Data from the Realm DB
                    //realm.delete(item)
                }
            } catch {
                print("Error updating done status : \(error)")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add new item in the TableView
    @IBAction func addPressedButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        //Add a pop-up alert
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        //button that we're going to pressed after we have written our new item
        let alertAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user have pressed the button
            // -> we add at the end of the itemResults the new item we create
            
            if let currentCategory = self.selectedCategory {
                //CRUD Version : Here we Create Data in our Realm Database
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving items : \(error)")
                }
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(alertAction)
        
        //show the alert
        present(alert,animated: true, completion: nil)
    }
    
    
    //MARK: - Model manipulation data
    
    func loadDataItems() {
        //CRUD : Read Data from the Realm Database
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    // Edit a row cell of the tableView in order to delete an item in the itemResults
    /*   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     return true
     }
     
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     itemResults.remove(at: indexPath.row)
     tableView.reloadData()
     }
     }
     */
    
}

// MARK: - Search Bar methods
extension TodoListViewController : UISearchBarDelegate {
    
    // Query the Realm database
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
     
        // let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        //Option 1:
        //todoItems = todoItems?.filter(predicate).sorted(byKeyPath: "dateCreated", ascending: true)
        
        //Option 2:
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        /*
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
         */
        tableView.reloadData()
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


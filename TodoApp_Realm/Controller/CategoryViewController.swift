//
//  CategoryViewController.swift
//  TodoApp_Realm
//
//  Created by Irfaane Ousseny on 15/09/2018.
//  Copyright © 2018 Irfaane. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryTableViewController: SwipeTableViewController {
    
    //Init the realm database
    let realm = try! Realm()
    // container for realm object queries : Collection of results that our category objects
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }
    
    //-----------------------------------------------------------------------------------------------------------
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomFlat.hexValue()
            //self.categories.append(newCategory) //-> we don't need this line anymore because the Results<Category> object is auto-updating the change 
            
            self.save(category: newCategory)
    
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
    //-----------------------------------------------------------------------------------------------------------
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No category added yet"
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].color ?? "FFFFFF")
            
        return cell
    }
    
    //-----------------------------------------------------------------------------------------------------------
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // go the TodoListViewController but before that call the prepareForSegue method
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationItem.backBarButtonItem = backButton
        
        //this method is usefull to catch a reference in the selectedCategory
        //attribute of the TodoListViewController class
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }

    }
    
    //-----------------------------------------------------------------------------------------------------------
    //MARK: - Data Manipulation Methods
    func save(category : Category) {
        do {
            // Write into our Realm Database a new category
            try realm.write {
                realm.add(category)
                
            }
        } catch let error as NSError {
            print("Error saving context : \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategory() {
        //we set the categories collection to look inside our DB
        //and fetch all of the objects that belongs to our data type
        categories = realm.objects(Category.self)
        tableView.reloadData() // calls all of the TableView Datasource Methods
    }
    
    override func updateModel(at indexPath : IndexPath) {
        super.updateModel(at : indexPath)
        if let deletionCategory = self.categories?[indexPath.row]{
            do {
                try self.realm.write {
                    self.realm.delete(deletionCategory)
                }
            } catch {
                print("Error deleting items : \(error)")
            }
        }
    }
}







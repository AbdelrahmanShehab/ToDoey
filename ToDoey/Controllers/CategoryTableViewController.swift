//
//  CategoryTableViewController.swift
//  ToDoey
//
//  Created by Abdelrahman Shehab on 06/07/2023.
//

import UIKit
import RealmSwift
import SwipeCellKit

class CategoryTableViewController: SwipeTableViewController {

    var categories: Results<Category>?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 80.0
        loadCategories()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
        return cell
    }

    // MARK: -  Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToItems", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController  
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    // MARK: -  Data Manipulation Methods (CRUD)
    
    // MARK: -  Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New ToDoey Category", message: "", preferredStyle: .alert)
        let actionAlert = UIAlertAction(title: "Add Category", style: .default) { action in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            self.save(category: newCategory)
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Add a new category"
            textField = alertTextField
        }
        
        alert.addAction(actionAlert)
        present(alert, animated: true)
    }
    
    // MARK: -  Save New Category
    func save(category: Category) {
        do {
            try realm.write({
                realm.add(category)
            })
        } catch {
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    // MARK: -  Load Categories From Data
    func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    // MARK: -  Delete A Selected Category By Swiping Cell
    override func updateModel(at indexPath: IndexPath) {
        if let deletedCategory = self.categories?[indexPath.row] {
            do {
                try self.realm.write({
                    self.realm.delete(deletedCategory)
                })
            } catch {
                print("Error in deleting category, \(error)")
            }
        }
    }
    
}

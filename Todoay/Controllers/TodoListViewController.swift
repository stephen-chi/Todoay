//
//  ViewController.swift
//  Todoay
//
//  Created by Linus Zheng on 7/2/18.
//  Copyright © 2018 Linus Zheng. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

    let realm = try! Realm()
    
    var itemArray: Results<Item>!
    
    @IBOutlet var searchBar: UISearchBar!
    
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if searchBar.isFirstResponder {
            tableView.cellForRow(at: indexPath)?.selectionStyle = .none
        } else {
            tableView.cellForRow(at: indexPath)?.selectionStyle = .default
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if searchBar.isFirstResponder {
            dismissSearchBar()
        } else {
            let item = itemArray[indexPath.row]
            do {
                try realm.write {
                    item.done = !item.done
                    //realm.delete(item)
                }
            } catch {
                print("Error saving checked state \(error)")
            }
            
            tableView.reloadData()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add new Todoay Item", message: "", preferredStyle: .alert)
        
        var textField = UITextField()
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            if textField.text!.trimmingCharacters(in: NSCharacterSet.whitespaces) != "" {
                
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        self.selectedCategory!.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items \(error)")
                }
                
                self.tableView.reloadData()
            }
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Load Items Method
    
    func loadItems() {
        
        itemArray = selectedCategory!.items.sorted(byKeyPath: "dateCreated", ascending: false)
        
        tableView.reloadData()
    }

}

//MARK: - Search Bar Methods

extension TodoListViewController: UISearchBarDelegate {
    
    func dismissSearchBar() {
        DispatchQueue.main.async {
            self.searchBar.resignFirstResponder()
        }
    }
    
    func findItemsMatchingSearch(text: String) {
        loadItems()
        itemArray = itemArray.filter("title CONTAINS[cd] %@", text)
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        findItemsMatchingSearch(text: searchBar.text!)
        dismissSearchBar()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            loadItems()
            dismissSearchBar()
        } else {
            findItemsMatchingSearch(text: searchText)
        }
    }
    
}


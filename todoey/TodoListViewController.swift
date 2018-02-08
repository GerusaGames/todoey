//
//  ViewController.swift
//  todoey
//
//  Created by Gerardo Torres  on 06/02/18.
//  Copyright © 2018 Gerardo Torres . All rights reserved.
//

import UIKit

class ToDolistViewController: UITableViewController {
    
    var itemArray = ["Comer patatas","Ir al cine","Ir a la escuela","Bailar Tango"]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "ToDoArray") as? [String]{
            itemArray = items
        }
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Nuevo recordatorio", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Guardar", style: .default) { (action) in
            print("success")
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
            self.defaults.set(self.itemArray, forKey: "ToDoArray")
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}


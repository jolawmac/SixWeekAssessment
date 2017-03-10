//
//  NameListTableViewController.swift
//  SixWeeksChallenge
//
//  Created by Josh "Musculo Grande" McDonald on 3/10/17.
//  Copyright © 2017 Josh McDonald. All rights reserved.
//


// Finished in three and a half hours


import UIKit

class NameListTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var names: [Name] = []
    
    // MARK: - Outlets/Actions
    
    @IBAction func addButtonTapped(_ sender: Any) {
        presentNewNameAlert()
    }
    
    @IBAction func randomButtonTapped(_ sender: Any) {
        names.randomizer()
        //(sender as! UIButton).backgroundColor = UIColor.green
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        names = NameController.sharedController.names
        title = "Pair Randomizer"
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \([section + 1][0])"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return NameController.sharedController.sections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if names.count % 2 != 0 && section == NameController.sharedController.sections - 1
        {
            return  1
        }
        return NameController.sharedController.namesPerSection
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        
        let row = indexPath.row + (NameController.sharedController.namesPerSection * indexPath.section)
        let name = names[row]
        cell.textLabel?.text = name.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let name = names[indexPath.row]
            NameController.sharedController.deleteNames(name: name)
            self.names = NameController.sharedController.names
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
        
    }
}

// MARK: - alertController

extension NameListTableViewController {
    
    func presentNewNameAlert() {
        var inputTextField: UITextField?
        let alertController = UIAlertController(title: "Add Person", message: "Add someone new to the list.", preferredStyle: .alert)
        alertController.addTextField { (textField) -> Void in
            inputTextField = textField
            textField.placeholder = "Full Name"
        }
        
        let add = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let typeText = inputTextField?.text else {return}
            let newName = NameController.sharedController.addNames(name: typeText)
            self.names.append(newName)
            
            self.tableView.reloadData()
            print("\(typeText)")
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in }
        
        alertController.addAction(add)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }
    
}

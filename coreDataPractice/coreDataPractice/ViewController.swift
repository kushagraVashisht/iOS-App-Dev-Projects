//
//  ViewController.swift
//  test2
//
//  Created by ritu sharma on 22/01/2018.
//  Copyright © 2018 Kush. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController
{
    var listItems = [NSManagedObject]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: Selector("addItem"))
        
    }
    
    func addItem()
    {
        let alertController = UIAlertController(title: "Type Something", message: "Type...", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler: ({
            (_) in
            if let field = alertController.textFields![0] as? UITextField
            {
                self.saveItem(itemToSave: field.text!)
                self.tableView.reloadData()
            }
        }))
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addTextField(configurationHandler: {
            (textField) in
            textField.placeholder = "type in something!"
        })
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController,animated : true, completion :  nil)

    }
    
    func saveItem(itemToSave : String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ListEntity", in : managedContext)
        let item = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        item.setValue(itemToSave, forKey : "item")
        do
        {
            try(managedContext.save())
            listItems.append(item)
        }
        catch
        {
            print("error")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        <#code#>
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //counts the number of items in the list
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int) -> Int
    {
        return listItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath : NSIndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as UITableViewCell
        let item = listItems[indexPath.row]
        cell.textLabel?.text = item.value(forKey: "item") as! String
        return cell
    }
}

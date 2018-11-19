//
//  CollectorTableViewController.swift
//  Collector
//
//  Created by tester on 11/18/18.
//  Copyright © 2018 Tepo Labs. All rights reserved.
//

import UIKit

class CollectorTableViewController: UITableViewController {

    var items : [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        getItems()
    }
    
    func getItems() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataStuff = try? context.fetch(Item.fetchRequest()) as? [Item] {
                if let coreDataItems = coreDataStuff {
                    items = coreDataItems
                    tableView.reloadData()
                    
                }
            }
        }
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        //copy-paste reuseIdentifier to storyboard table view cell identifier field
        // here we work on / configure the cell...

        let item = items[indexPath.row] // grab the item for this row from items array we got from core data
        cell.textLabel?.text = item.title
        if let imageData = item.image {
             cell.imageView?.image = UIImage(data: imageData) //use UIImage to conver from data to image type then fill cell imageview so cells display an image too
        }
        
        return cell
    }
    

    //uncomment these to allow swipe delete of rows.
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true //returning true so all rows are editable
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            // tableView.deleteRows(at: [indexPath], with: .fade)
            
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let item = items[indexPath.row]
                context.delete(item)
                getItems()  //get items from core data into our local array so the deleted item is gone from array too.  BTW getItems does a reloadData so no need to add another here.
                
            }
            print("ask to delete")
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

  

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

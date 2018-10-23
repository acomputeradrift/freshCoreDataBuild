//
//  SubCategoryTableViewController.swift
//  freshCoreDataBuild
//
//  Created by Jamie on 2018-10-22.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit
import CoreData

class SubCategoryTableViewController: UITableViewController {
    
    var subCategories: [SubCategory] = []
    var selectedCategoryName = String()
    var selectedCategory = Category()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedCategoryName
        //this updates the local array
        //retrieveSubCategories()

    }
    
    func createSubCategory(subCategoryName: String){
        let context = AppDelegate.viewContext
        let subCategory = SubCategory(context:context)
        subCategory.name = subCategoryName
        selectedCategory.children = [subCategory]
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save subCategory. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveSubCategories(){
        let context = AppDelegate.viewContext
        let request =
            NSFetchRequest<NSManagedObject>(entityName: "Category")
        request.sortDescriptors = [NSSortDescriptor(key: "children", ascending: true)]
        subCategories = try! context.fetch(request) as! [SubCategory]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subCategories.count
    }
    
    @IBAction func addSubCategory(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New SubCategory",
                                      message: "Add a new sub category",
                                      preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            
            guard let textField = alert.textFields?.first,
                let subCategoryName = textField.text else {
                    return
            }
            self.createSubCategory(subCategoryName: subCategoryName)
            self.retrieveSubCategories()
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subCategoryTableViewCell", for: indexPath)
        let subCategory = subCategories[indexPath.row]
        cell.textLabel!.text = subCategory.name
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

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

//
//  CategoryTableViewController.swift
//  freshCoreDataBuild
//
//  Created by Jamie on 2018-10-22.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    //var subCategoryTableViewController: SubCategoryTableViewController? = nil
    var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Categories"
        //this updates the local array
        retrieveCategories()
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryTableViewCell", for: indexPath)
        let category = categories[indexPath.row]
        cell.textLabel!.text = category.name
        return cell
    }
    
    func createCategory(categoryName: String){
        let context = AppDelegate.viewContext
        let category = Category(context:context)
        category.name = categoryName
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveCategories(){
        let context = AppDelegate.viewContext
        let request =
            NSFetchRequest<NSManagedObject>(entityName: "Category")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        categories = try! context.fetch(request) as! [Category]
    }
    
    
    func updateCategory(){
        // let context = AppDelegate.viewContext
    }
    
    func deleteCategory(category: Category){
        let context = AppDelegate.viewContext
        context.delete(category)
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save deletion. \(error), \(error.userInfo)")
        }
        //this updates the local array
        retrieveCategories()
    }
    
    @IBAction func addName(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Category",
                                      message: "Add a new category",
                                      preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            
            guard let textField = alert.textFields?.first,
                let categoryName = textField.text else {
                    return
            }
            self.createCategory(categoryName: categoryName)
            self.retrieveCategories()
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let categoryToDelete = categories[indexPath.row]
            deleteCategory(category: categoryToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSubCategories" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! SubCategoryTableViewController
                controller.selectedCategoryName = self.categories[indexPath.row].name ?? "Default"
                controller.selectedCategory = self.categories[indexPath.row]
            }
        }
    }
    
    
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

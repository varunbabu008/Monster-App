//
//  ViewMonsterController.swift
//  MonsterApp
//
//  Created by Varun Babu on 8/3/17.
//  Copyright © 2017 Varun Babu. All rights reserved.
//

import UIKit
import CoreData

class ViewMonsterController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var countMonsters: UILabel!
    
    
    var controller: NSFetchedResultsController<Monsters>!
    
   // var filteredController: NSFetchedResultsController<Monsters>!
    
    //var monsters = [Monsters]()
    //var fileteredMonsters = [Monsters]()
    
    var inSearchMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let topItem = self.navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
    
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        // Do any additional setup after loading the view.
        
        attemptFetch()
    
    }
    
    // Search function
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        
//        if searchBar.text == nil || searchBar.text == "" {
//            
//            inSearchMode = false
//            tableView.reloadData()
//        }
//        else{
//            
//            inSearchMode = true
//            let lower = searchBar.text!.lowercased()
//            fileteredMonsters = monsters.filter({$0.name?.range(of: lower) != nil})
//            tableView.reloadData()
//            
//        }
//        
//        
//    }
//    // Gets the current monsters in the database
//    func getMonsters() -> [Monsters]{
//        
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
//        
//        do{
//            monsters = try context.fetch(request) as! [Monsters]
//        }
//        catch{
//        }
//        
//        return monsters
//    }
    
    
    // START Table view functions
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    
    // Use use this to configure the table view cell which is of type Item Cell
    func configureCell(cell:ItemCell,indexPath: NSIndexPath){
        
        // update cell
        
      
            let item = controller.object(at: indexPath as IndexPath)
            cell.configureCell(monster: item)
        
        
    }
    
    // This function is called when we click on a row in the tableView. We segue to the itemDetails View which shows the full details of the clicked Monster
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let objs = controller.fetchedObjects , objs.count > 0 {
            
            let item = objs[indexPath.row]
            performSegue(withIdentifier: "ItemDetailsVC", sender: item)
            
        }
        
    }
    // We also pass in the Current Monster obect when the row is clicked
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "ItemDetailsVC"{
            if let destination = segue.destination as? ItemDetailsVCViewController{
                
                if let item = sender as? Monsters {
                    destination.monsterToEdit = item
                }
            }
        }
    }
    
    // Gives us the number of sections in the table View. We also set the label which diplays the count of monsters in here.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = controller.sections{
            let sectionInfo = sections[section]
            countMonsters.text = "Number of Monsters: " + String(sectionInfo.numberOfObjects)
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    // Gives us the number of rows in a secion
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let sections = controller.sections{
            return sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func attemptFetch(){
        
        let fetchRequest: NSFetchRequest<Monsters> = Monsters.fetchRequest()
        // sorting by name
        let nameSort = NSSortDescriptor(key:"name",ascending: true)
        fetchRequest.sortDescriptors = [nameSort]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        
        controller.delegate = self
        
        self.controller = controller
        
        do{
            try controller.performFetch()
        }
        catch{
            let error = error as NSError
            print("\(error)")
        }
        
    }
    
    // Updates to core data are handled using the tableView
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
    // All the insert,delete,update and move are handled by the tableView. We do not make use of move here
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch(type){
        case.insert:
            if let indexPath = newIndexPath{
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = newIndexPath{
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell
                // update the cell data
                
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
                
            }
            break
        case.move:
            if let indexPath = indexPath{
            tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath{
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
    }
    
    
    
    
    
    
}


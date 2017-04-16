//
//  ViewController.swift
//  MonsterApp
//
//  Created by Varun Babu on 7/3/17.
//  Copyright © 2017 Varun Babu. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var newMonster: Monster?
    
    @IBOutlet var MonsterName: UITextField!

    @IBOutlet var MonsterAge: UITextField!
    
    @IBOutlet var MonsterSpecies: UITextField!
    

    @IBOutlet weak var MonsterAttack: UITextField!
    
    @IBOutlet weak var MonsterHealth: UITextField!

    
    @IBOutlet var displayLabel: UILabel!
   
    
    @IBAction func UpdateButton(_ sender: Any) {
        if(MonsterName.text != nil){
            newMonster?.name = MonsterName.text!
        }
        else if(MonsterAge.text != nil ){
            newMonster?.age = Int(MonsterAge.text!)
        }
        else if(MonsterSpecies.text != nil){
           newMonster?.species = MonsterSpecies.text!
        }
        else if(MonsterHealth.text != nil){
            newMonster?.health = Int(MonsterHealth.text!)
        }
        else{
            newMonster?.attack = Int(MonsterAttack.text!)
        }
        
        displayLabel.text = "Monster has been updated"
    }
   
    @IBAction func SaveButton(_ sender: Any) {
        
        
        if(MonsterAge.text != "" && MonsterHealth.text != "" && MonsterAttack.text != "" && MonsterName.text! != "" && MonsterSpecies.text! != "" ){
            
            if(isStringAnInt(string: MonsterAge.text!) && isStringAnInt(string: MonsterHealth.text!) && isStringAnInt(string: MonsterAttack.text!)){

            
            
            
                let monAge:Int = Int(MonsterAge.text!)!
                let monHealth:Int = Int(MonsterHealth.text!)!
                let monAttack:Int = Int(MonsterAttack.text!)!
                let monName:String = MonsterName.text!
                let monSpecies:String = MonsterSpecies.text!
                newMonster = Monster(name: monName, age:monAge, species: monSpecies, attack: monAttack, health: monHealth)
            
                displayLabel.text = "Monster Created with \("\n")Name : \(monName)\("\n")Age : \(monAge)\("\n")Species : \(monSpecies) \("\n")Attack power : \(monAttack) \("\n")Health : \(monHealth)"

                //displayLabel.text = "Monster saved"
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
            
                let newMonsterD = NSEntityDescription.insertNewObject(forEntityName: "Monsters", into: context)
                newMonsterD.setValue(monAge, forKey:"age")
                newMonsterD.setValue(MonsterName.text, forKey:"name")
                newMonsterD.setValue(MonsterSpecies.text, forKey:"species")
                newMonsterD.setValue(monHealth, forKey:"health")
                newMonsterD.setValue(monAttack, forKey:"attack")
            
                do{
                    try context.save()
                
                }
                catch{
                    print("There was an error saving object")
                }
            
                let request  = NSFetchRequest<NSFetchRequestResult>(entityName: "Monsters")
                request.returnsObjectsAsFaults = false
                do{
                    let results = try context.fetch(request)
                    if results.count > 0 {
                    
                        for result in results as! [NSManagedObject]{
                        
                            if let name = result.value(forKey: "name") as? String{
                                print(name)
                            }
                        }
                    
                    }
                    else{
                        print("No results")
                    }
                
                }
            
                catch{
                    print("Coudnt fetch results")
                }
            }
            else{
                displayLabel.text = "Please enter an integer value for age, health and attack power"
            }
           
            
        }
        
    
        else{
             displayLabel.text = "You did not enter value for atleast one field"
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue,sender: Any?){
        if(segue.identifier == "createMonsterSegue"){
       
            
            
        }
    }
    //To check if an entered String is a number
    func isStringAnInt(string: String) -> Bool {
        return Int(string) != nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.navigationItem.title = "Darwins Encyclopedia";
        //self.navigationController?.navigationBar.topItem?.title = "Darwins Encyclopedia"
        
        
       
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


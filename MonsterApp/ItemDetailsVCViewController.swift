//
//  ItemDetailsVCViewController.swift
//  MonsterApp
//
//  Created by Varun Babu on 9/4/17.
//  Copyright © 2017 Varun Babu. All rights reserved.
//

import UIKit


// ItemDetailsVCViewController controller handles the update and delete.
class ItemDetailsVCViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var speciesField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var healthField: UITextField!
    @IBOutlet weak var attackField: UITextField!
    
    
    @IBOutlet weak var displayLabel: UILabel!
    
    // used to check if a new monster is to be created or an existing one to be  updated
    var monsterToEdit:  Monsters?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        if monsterToEdit != nil {
            loadMonsterData()
        }
        
    }
    
    func isStringAnInt(string: String) -> Bool {
        return Int(string) != nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        //let monster = Monsters(context:context)
        var monster: Monsters!
        
        // If we press the plus button on top of the search view. We can add a new monster. 
        // There is no monster to edit because we did not select any row from the tableview
        if monsterToEdit == nil{
            
            //we get the current context core data
            monster = Monsters(context:context)
            
        }
        else{
            monster = monsterToEdit
        }
        // Validation -- Checking if one or more of the text fields are empty. If yes we display a custome error message
        if(ageField.text != "" && healthField.text != "" && attackField.text != "" && nameField.text! != "" && speciesField.text! != "" ){
            
            // If the value entered in the textbox is not a number 
            if(isStringAnInt(string: ageField.text!) && isStringAnInt(string: healthField.text!) && isStringAnInt(string: attackField.text!)){
                
                if let name = nameField.text{
                    monster.name = name
                }
                if let species = speciesField.text{
                    monster.species = species
                }
                
                if let age = Int16(ageField.text!){
                    monster.age = age
                }
                
                if let health = Int16(healthField.text!){
                    monster.health = health
                }
                
                if let attack = Int16(attackField.text!){
                    monster.attack = attack
                }
                
                // ad is a variable in appDelegate file that we created
                ad.saveContext()
                
                // Will take us back to the previous view after an update or delete is pressed
                navigationController?.popViewController(animated: true)
            }
            else{
               displayLabel.text = "health, age, attack Power should be an integer"
            }
        }
        else{
            
             displayLabel.text = "Please fill all fields and try again"
        }

        
       
        
        
        
    }
    
    // populate the textfields
    func loadMonsterData(){
        
        if let monster = monsterToEdit{
            nameField.text = monster.name
            speciesField.text = monster.species
            ageField.text = String(monster.age)
            healthField.text = String(monster.health)
            attackField.text = String(monster.attack)
        }
        
        
    }
    
    
     // Called when the recycler delete button is pressed.
    @IBAction func deletePressed(_ sender: Any) {
        
        if monsterToEdit != nil {
            
            context.delete(monsterToEdit!)
            ad.saveContext()
        }
        
        // Will take us back to the previous view after an update or delete is pressed
        _ = navigationController?.popViewController(animated: true)
        
        
        
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

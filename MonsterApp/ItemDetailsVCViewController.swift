//
//  ItemDetailsVCViewController.swift
//  MonsterApp
//
//  Created by Varun Babu on 9/4/17.
//  Copyright © 2017 Varun Babu. All rights reserved.
//

import UIKit

class ItemDetailsVCViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var speciesField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var healthField: UITextField!
    @IBOutlet weak var attackField: UITextField!
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        let monster = Monsters(context:context)
        
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
        
        ad.saveContext()
        // Will take us back to the previous view
        navigationController?.popViewController(animated: true)
        
        
        
    }
    
    func loadMonsterData(){
        
        if let monster = monsterToEdit{
            nameField.text = monster.name
            speciesField.text = monster.species
            ageField.text = String(monster.age)
            healthField.text = String(monster.health)
            attackField.text = String(monster.attack)
        }
        
        
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

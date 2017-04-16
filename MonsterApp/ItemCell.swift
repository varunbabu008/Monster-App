//
//  ItemCell.swift
//  MonsterApp
//
//  Created by Varun Babu on 9/4/17.
//  Copyright © 2017 Varun Babu. All rights reserved.
//

import UIKit


//Display the contents of the tableView
class ItemCell: UITableViewCell {
    

    @IBOutlet weak var monsterName: UILabel!
    
    @IBOutlet weak var monsterSpecies: UILabel!
  
    func configureCell(monster: Monsters){
        monsterName.text = monster.name
        monsterSpecies.text = monster.species
    }
}

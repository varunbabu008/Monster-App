//
//  ItemCell.swift
//  MonsterApp
//
//  Created by Varun Babu on 9/4/17.
//  Copyright © 2017 Varun Babu. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var monsterName: UILabel!
    
  
    func configureCell(monster: Monsters){
        monsterName.text = monster.name
    }
}

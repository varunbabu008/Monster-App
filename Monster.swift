//
//  Monster.swift
//  MonsterApp
//
//  Created by Varun Babu on 7/3/17.
//  Copyright © 2017 Varun Babu. All rights reserved.
//

import UIKit

class Monster: NSObject {
    
    // Attributes
    private var _name:String
    private var _age:Int
    private var _species:String
    private var _health:Int
    private var _attack:Int
    
    // START Accessors and Mutators
    var name:String?{
        get{
            //return self.name
            return _name
        }
        set(newname){
            _name = newname!
        }
    }
    var age:Int?{
        get{
            //return self.age
            return _age
        }
        set(newage){
            _age = newage!
        }
    }
    var species:String?{
        get{
            //return self.species
            return _species
        }
        set(newSpecies){
            _species = newSpecies!
        }
    }
    
    var health:Int?{
        get{
            //return self.health
            return _health
        }
        set(newHealth){
            _health = newHealth!
        }
    }
    var attack:Int?{
        get{
            //return self.attack
            return _attack
        }
        set(newAttack){
            _attack = newAttack!
        }
    }
   // End Accessors and Mutuators
    

    // START Constructors
    
    override init(){
       
        _name = "Unknown"
        _age = 0
        _species = "Unknown"
        _attack = 0
        _health = 0
    }
    

    init(name:String, age:Int, species:String, attack:Int, health:Int) {
       
        _name = name
        _age = age
        _species = species
        _attack = attack
        _health = health
    }
    
    // END Consutrucotrs
}





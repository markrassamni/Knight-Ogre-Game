//
//  Character.swift
//  Exercise 2
//
//  Created by Mark Rassamni on 7/20/16.
//  Copyright © 2016 markrassamni. All rights reserved.
//

import Foundation

class Character {
    private var _hp: Int
    private var _ap: Int
    
    var hp: Int {
        get{
            return _hp
        }
    }
    
    var ap: Int {
        get{
            return _ap
        }
    }
    
    var type: String {
        return "Unset"
    }
    
    init (hp: Int, ap: Int){
        self._hp = hp
        self._ap = ap
    }
    
    func isAlive() -> Bool{
        if _hp <= 0{
            return false
        } else{
            return true
        }
    }
    
    func attacked (ap: Int) -> Bool {
        self._hp -= ap
        return true
    }
    
}







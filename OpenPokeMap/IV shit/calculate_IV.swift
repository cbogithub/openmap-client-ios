//
//  calculate_IV.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 04/09/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

import SwiftyJSON

class CalculateIV {
    
    
    //MARK: Grabs base values and subsitutes into equation
    func GetBase(BaseAttack: Double, BaseDefense: Double, BaseStamina: Double) {
        
        let BaseAtk = BaseAttack
        let BaseDef = BaseDefense
        let BaseSta = BaseStamina
        
    }
    
    func doEquation(Pokemon: String?, CP: Int?, HP: Int?, DustPrice: Int?, PoweredUp: Bool ) {
        
        BaseStats().GetBaseStats(Pokemon!)
        print("Pokemon: \(Pokemon), CP: \(CP), HP: \(HP), DustPrice: \(DustPrice), Is powered up? \(PoweredUp)")

    }
    
}
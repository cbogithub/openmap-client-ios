//
//  calculate_IV.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 04/09/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

class CalculateIV {
    
    // MARK: Grabs base values and subsitutes into equation
    
    func getBase(with baseAttack: Double, baseDefense: Double, baseStamina: Double) {
        // TODO: Do something
        /*let baseAtk = baseAttack
        let baseDef = baseDefense
        let baseSta = baseStamina*/
    }
    
    func doEquation(for pokemon: String?, CP: Int?, HP: Int?, dustPrice: Int?, poweredUp: Bool ) {
        BaseStats().getBaseStats(pokemon!)
        print("Pokemon: \(pokemon), CP: \(CP), HP: \(HP), DustPrice: \(dustPrice), Is powered up? \(poweredUp)")
    }
    
}

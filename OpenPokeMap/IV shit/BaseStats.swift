//
//  iv_calculator.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 04/09/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaseStats {
    
    func getBaseStats(_ pokemon: String){
        let jsonFilePath = Bundle.main.url(forResource: "base_stats", withExtension: "json")!
        let jsonData = try? Data(contentsOf: jsonFilePath)
        let json = JSON(data: jsonData!)
        
        func validatePokemon(_ pokemon: String) {
            for _ in json {
                if json["name"].string == pokemon {
                    let pokemonJSON = json["name"]
                    print("Pokemon name is \(pokemonJSON)")
                    let baseAttack = json[pokemon]["BaseAttack"].double
                    let baseDefense = json[pokemon]["BaseDefense"].double
                    let baseStamina = json[pokemon]["BaseStamina"].double
                    
                    parseBaseStats(true, baseAttack: baseAttack!, baseDefense: baseDefense!, baseStamina: baseStamina!)
                    
                } else {
                    print("Could not find pokemon; aborting")
                    parseBaseStats(false, baseAttack: 0, baseDefense: 0, baseStamina: 0)
                    break
                }
            }
        }
        
        
        func parseBaseStats(_ pokemonIsValid: Bool, baseAttack: Double, baseDefense: Double, baseStamina: Double) {
            if pokemonIsValid {
                
                print("Base stats for \(pokemon)BaseAttack: \(baseAttack), BaseDefense \(baseDefense), BaseStamina \(baseStamina)")
                
                CalculateIV().getBase(with: baseAttack, baseDefense: baseDefense, baseStamina: baseStamina)
                
            } else {
            }
        }

        validatePokemon(pokemon)
    }
        
}

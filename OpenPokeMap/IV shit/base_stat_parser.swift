//
//  iv_calculator.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 04/09/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

import UIKit

class BaseStats {
    
    func GetBaseStats(Pokemon: String){
        
        let jsonFilePath:NSString = NSBundle.mainBundle().pathForResource("base_stats", ofType: "json")! //JSON variables
        let jsonData:NSData = NSData.dataWithContentsOfMappedFile(jsonFilePath as String) as! NSData
        let json = JSON(data: jsonData)
        
        
        func ValidatePokemon(Pokemon: String) {
            for key in json {
                if json["name"].string == Pokemon {
                    let PokemonJSON = json["name"]
                    print("Pokemon name is \(PokemonJSON)")
                    let BaseAttack = json[Pokemon]["BaseAttack"].double
                    let BaseDefense = json[Pokemon]["BaseDefense"].double
                    let BaseStamina = json[Pokemon]["BaseStamina"].double
                    
                    ParseBaseStats(true, BaseAttack: BaseAttack!, BaseDefense: BaseDefense!, BaseStamina: BaseStamina!)
                    
                } else {
                    print("Could not find pokemon: aborting")
                    ParseBaseStats(false, BaseAttack: 0, BaseDefense: 0, BaseStamina: 0)
                    break
                }
            }
        }
        
        
    func ParseBaseStats(PokemonIsValid: Bool, BaseAttack: Double, BaseDefense: Double, BaseStamina: Double) {
            
            if PokemonIsValid {
                
                print("Base stats for \(Pokemon)BaseAttack: \(BaseAttack), BaseDefense \(BaseDefense), BaseStamina \(BaseStamina)")
                
                CalculateIV().GetBase(BaseAttack, BaseDefense: BaseDefense, BaseStamina: BaseStamina)
                
            } else {
            }
                
        }
        
        ValidatePokemon(Pokemon)
        
    }
    
        
}
    

//
//  iv_calculator.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 04/09/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

import SwiftyJSON
import UIKit

class BaseStats {
    
    func GetBaseStats(Pokemon: String){
        
        let jsonFilePath:NSString = NSBundle.mainBundle().pathForResource("base_stats", ofType: "json")! //JSON variables
        let jsonData:NSData = NSData.dataWithContentsOfMappedFile(jsonFilePath as String) as! NSData
        let json = JSON(data: jsonData)
        
        for pokemon in json {
            
            let PokemonNameJSON = json["name"].string
            print("Pokemon Name: \(PokemonNameJSON)")
            
            if PokemonNameJSON == Pokemon {
                
                let BaseAttack = json[Pokemon]["BaseAttack"].double
                let BaseDefense = json[Pokemon]["BaseDefense"].double
                let BaseStamina = json[Pokemon]["BaseStamina"].double
                
                print("BaseAttack: \(BaseAttack), BaseDefense \(BaseDefense), BaseStamina \(BaseStamina)")
                
                CalculateIV().GetBase(BaseAttack!, BaseDefense: BaseDefense!, BaseStamina: BaseStamina!)
        
            } else {
                
                let PokemonNotFound = true
    
            }
        }
        
        
        
    }
    
}
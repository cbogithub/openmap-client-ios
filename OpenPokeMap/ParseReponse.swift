//
//  ParseReponse.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 19/09/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

import Foundation
import SwiftyJSON

class ParseResponse {
    func parseResponse(json: Data) {
        let parsed = JSON(data: json)
        if let ok = parsed["Ok"].bool, ok, let pokemons = parsed["Response"].array {
            // TODO: Temporary, from my understanding:
            let rarePokemonIDs = [2,3,4,5,6,8,9,24,26,28,31,34,38,45,51,55,57,59,67,68,75,76,77,78,83,85,87,89,94,101,103,105,107,113,114,125,126,130,131,134,135,136,137,139,141
                ,142,143,144,145,146,147,148,149,150,151]
            for pokemon in pokemons {
                // TODO: Take out the stuff not needed later
                if let type = pokemon["Type"].int, let pokemonID = pokemon["PokemonId"].int, let id = pokemon["Id"].string, let latitude = pokemon["Lat"].float, let longitude = pokemon["Lng"].float, let expiry = pokemon["Expiry"].int, let lured = pokemon["Lured"].bool, let team = pokemon["Team"].int {
                    // Valid shit
                    //if rarePokemonIDs.contains(pokemonID) { SKIP CHECKS BECAUSE NO RARE ONES IN SAMPLE DATA
                        // OOOH WE GOT OURSELVES A RARE ONE OVER HERE
                    if let name = PokemonInfo.shared.pokemonName(for: pokemonID) {
                        // It has a name
                        debugPrint("SEND NOTIFICATION FOR \(name)")
                        // TODO: THE CODE IS SO FAST YOU WONT ALWAYS GET A NOTIFICATION BECAUSE THE APP WONT BE FULLY IN BACKGROUND BY THE TIME SYSTEM SENDS IT, AND THE SYSTEM WILL JUST IGNORE IT *sigh*
                        NotificationFactory.sendNotification(for: name)
                    }
                    //}
                }
            }
        }
    }
    
    //To @applebetas: I need to check the ID from the response from the API, compare it to the ID's in pokemonID.json, and send the result of that to MakeNotification.swift.
    //You can find a example reponse here: https://ghostbin.com/paste/o3hg6 
}

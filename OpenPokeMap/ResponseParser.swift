//
//  ResponseParser.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 19/09/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

import Foundation
import SwiftyJSON

class ResponseParser {
    static let shared = ResponseParser()
    
    private var sentIDs = [String]()
    private let rarePokemonIDs = [2,3,4,5,6,8,9,24,26,28,31,34,38,45,51,55,57,59,67,68,75,76,77,78,83,85,87,89,94,101,103,105,107,113,114,125,126,130,131,134,135,136,137,139,141
        ,142,143,144,145,146,147,148,149,150,151]
    
    // Ease of use:
    static func parseResponse(json parsed: JSON) {
        ResponseParser.shared.parseResponse(json: parsed)
    }
    
    func parseResponse(json parsed: JSON) {
        print("Parsing")
        debugPrint(parsed["Ok"].bool)
        if let ok = parsed["Ok"].bool, ok, let pokemons = parsed["MapObjects"].array {
            for pokemon in pokemons {
                // TODO: Take out the stuff not needed later
                if let type = pokemon["Type"].int, let pokemonID = pokemon["PokemonId"].int, let id = pokemon["Id"].string, let latitude = pokemon["Lat"].float, let longitude = pokemon["Lng"].float, let expiry = pokemon["Expiry"].int, let lured = pokemon["Lured"].bool, let team = pokemon["Team"].int, !sentIDs.contains(id) {
                    // Valid shit
                    print("Pokemon found")
                    //if rarePokemonIDs.contains(pokemonID) {
                    // OOOH WE GOT OURSELVES A RARE ONE OVER HERE
                    if let name = PokemonInfo.shared.pokemonName(for: pokemonID) {
                        // It has a name
                        debugPrint("Send notification for #\(pokemonID): \(name) (ID: \(id))")
                        NotificationFactory.send(for: name, pokemonID: pokemonID, uniqueID: id)
                        sentIDs.append(id)
                    }
                    //}
                }
            }
        }
    }
    
    func restartNotifications() {
        sentIDs = [String]()
    }
}

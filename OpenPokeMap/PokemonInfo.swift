//
//  PokemonInfo.swift
//  OpenPokeMap
//
//  Created by AppleBetas on 2016-09-19.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

import Foundation
import SwiftyJSON

class PokemonInfo {
    static let infoURL = Bundle.main.url(forResource: "PokemonID", withExtension: "json")!
    private var infoData: Data? = nil
    private var parsedData: [Int: String]? = nil
    
    static var shared = PokemonInfo()
    
    func pokemonName(for id: Int) -> String? {
        guard let parsedData = parsedData else { parseInfo(); return pokemonName(for: id) }
        if parsedData.keys.contains(id) {
            let name = parsedData[id]
            return name
        }
        return nil
    }
    
    private func refreshInfo() {
        infoData = try? Data(contentsOf: PokemonInfo.infoURL)
    }
    
    private func parseInfo() {
        // Parse for quick future access
        let json = getInfoJSON()
        var pokemonIDs = [Int: String]()
        if let allIDs = json.array {
            for group in allIDs {
                if let id = group["id"].int, let name = group["name"].string {
                    pokemonIDs[id] = name
                }
            }
        }
        parsedData = pokemonIDs
    }
    
    private func getInfoJSON() -> JSON {
        guard let infoData = infoData else { refreshInfo(); return getInfoJSON() }
        return JSON(data: infoData)
    }
}

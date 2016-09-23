//
//  MakeRequest.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 19/09/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class MakeRequest {

    func makeRequest(lat: Double, lng: Double) {
        let url = "https://api.openpokemap.pw/c"
        let parameters: Parameters = [
            "lat": lat,
            "lng": lng,
            "p": "1"
        ]
        
        request(url, method: .post, parameters: parameters)
            .responseJSON { response in
                if let value = response.result.value {
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                    ParseResponse().parseResponse(json: json)
                }

//        let json = try! Data(contentsOf: Bundle.main.url(forResource: "test_resp", withExtension: "json")!)
                //}
        }
    }
}



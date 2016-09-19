//
//  MakeRequest.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 19/09/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

import Foundation
import Alamofire

class MakeRequest {

    func makeRequest(lat: Double, lng: Double) {
        let url:String = "Your url"
        let parameters: Parameters = [
            "lat": lat,
            "lng": lng
            ]
        request(url, method: .post, parameters: parameters)
            .responseJSON { response in
                print("Response JSON: \(response.result.value)")
                let json = response.result.value
                ParseResponse().ParseResponse(json: json as! String)
            }

        }
    }




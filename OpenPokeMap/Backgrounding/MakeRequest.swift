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
    
    var url:String = "Your url"
    url += "user/login"
    var param = ["email": self.txtmail.text, "password":self.txtpassword.text]
    request(.POST, url, parameters: param)
    .responseJSON { (_, _, JSON, _) in
    //println(JSON)
    if let gData = JSON as? NSDictionary {
    println(gData)
    } else {
    let alert=UIAlertView()
    alert.title="Alert"
    alert.message=gData.valueForKey("message")as? String
    alert.addButtonWithTitle("OK")
    alert.show()
    }
    }
}


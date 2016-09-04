//
//  ViewController.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 26/08/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

import UIKit
import SwiftyJSON
//import Quark

class ViewController: UIViewController {

    let socket = WebSocket("ws://localhost:8080/websocket")
    
    @IBOutlet weak var webView: UIWebView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "https://openpokemap.pw/mobile.html")
        let request = NSURLRequest(URL: url!)
        webView.scrollView.maximumZoomScale = 1.0;
        webView.scrollView.minimumZoomScale = 1.0;
        webView.loadRequest(request)
        
    //MARK: Connect to WebSocket
        connectToSocket()
    }
    
    // MARK: Websocket Delegate Methods.
    
    func connectToSocket(){
        socket.event.open = {
            print("Connected to socket")
        }
        socket.event.close = { code, reason, clean in
            print("Websocket closed")
            self.connectToSocket()
        }
        
        socket.event.error = { error in
            print("error \(error)")
            self.connectToSocket()
        }
        
        socket.event.message = { message in
            if let text = message as? String {
                print("recv: \(text)")
                let challenge = text
                self.respondToChallenge(challenge)
            }
        }
    }

    func respondToChallenge(challenge: String) {
        print("Challenge passed successfully \(challenge)")
        let json = JSON(challenge)
        print(json) 

        
//        struct Request : MapInitializable {
//            let method: String
//            let contentType: String
//            let userAgent: String
//            let data: String
//            
//            init(map: Map) throws {
//                method = try map.get("meth")
//                contentType = try map.get("cont")
//                userAgent = try map.get("user")
//                data = try map.get("data")
//            }
//        }
//        
//        let wsServer = WebSocketServer { req, ws in
//            ws.onBinary { data in
//                let request = try map(from: data, to: Request.self, using: JSONParser.self)
//                try Client.request(
//                    method: request.method,
//                    headers: ["user-agent": request.userAgent],
//                    contentType: request.contentType,
//                    content: ["data": request.data]
//                )
//            }
//        }
//        
//        try Server(responder: wsServer).start()

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

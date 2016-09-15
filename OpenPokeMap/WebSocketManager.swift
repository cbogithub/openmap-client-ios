//
//  WebSocketManager.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 01/09/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

import Starscream

class WebSocketManager: WebSocketDelegate {
    
    func connectSocket(urlSocket: String) {
        
        var socket = WebSocket(url: NSURL(string: urlSocket)!)
        
        socket.delegate = self
        socket.connect()
        
    }
    
    // MARK: Websocket Delegate Methods.
    
    func websocketDidConnect(ws: WebSocket) {
        print("websocket is connected")
    }
    
    func websocketDidDisconnect(ws: WebSocket, error: NSError?) {
        if let e = error {
            print("websocket is disconnected: \(e.localizedDescription)")
        } else {
            print("websocket disconnected")
        }
    }
    
    func websocketDidReceiveMessage(ws: WebSocket, text: String) {
        print("Received text: \(text)")
        let challenge = text
        respondToChallenge(challenge)
    }
    
    func websocketDidReceiveData(ws: WebSocket, data: NSData) {
        print("Received data: \(data.length)")
    }
    
    func respondToChallenge(challenge: String) {
        //        socket.writeString(JSON(challenge).rawString()!)
    }

}

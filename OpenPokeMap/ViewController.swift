//
//  ViewController.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 26/08/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

import UIKit
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

extension UIAlertController {
    
    func show() {
        present(true, completion: nil)
    }
    
    func present(animated: Bool, completion: (() -> Void)?) {
        if let rootVC = UIApplication.sharedApplication().keyWindow?.rootViewController {
            presentFromController(rootVC, animated: animated, completion: completion)
        }
    }
    
    private func presentFromController(controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if let navVC = controller as? UINavigationController,
            let visibleVC = navVC.visibleViewController {
            presentFromController(visibleVC, animated: animated, completion: completion)
        } else
            if let tabVC = controller as? UITabBarController,
                let selectedVC = tabVC.selectedViewController {
                presentFromController(selectedVC, animated: animated, completion: completion)
            } else {
                controller.presentViewController(self, animated: animated, completion: completion);
        }
    }
}
// Add anywhere in your app
extension UIImage {
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()! as CGContextRef
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, .Normal)
        
        let rect = CGRectMake(0, 0, self.size.width, self.size.height) as CGRect
        CGContextClipToMask(context, rect, self.CGImage)
        tintColor.setFill()
        CGContextFillRect(context, rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

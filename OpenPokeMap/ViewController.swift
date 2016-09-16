//
//  ViewController.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 26/08/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    let debug = true
    var timer = NSTimer()
    let internetCheckInterval = Double(5)
    var successfulTimes = 0
    
    func checkInternet() {
        let status = Reach().connectionStatus()
        
        switch status {
        case .Unknown, .Offline:
            print("Not connected")
            displayFailAlert(true)
        case .Online(.WWAN):
            print("Connected via WWAN")
        case .Online(.WiFi):
            print("Connected via WiFi")
        }
        
    }
    
    func reloadWebview() {
        let url = NSURL(string: "https://openpokemap.pw/mobile.html")
        let request = NSURLRequest(URL: url!)
        webView.scrollView.maximumZoomScale = 1.0;
        webView.scrollView.minimumZoomScale = 1.0;
        webView.loadRequest(request)
    }
   
    func networkStatusChanged(notification: NSNotification) {
        let userInfo = notification.userInfo
        print(userInfo)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "checkInternet", userInfo: nil, repeats: true)
        
        reloadWebview()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("networkStatusChanged:"), name: ReachabilityStatusChangedNotification, object: nil)
        Reach().monitorReachabilityChanges()
    }
    
    
    // MARK: Websocket Delegate Methods.
    
    func displayFailAlert(network: Bool) {
        if network {
            print("Displaying no internet alert")
            let alertController = UIAlertController(title: "No Internet.", message: "Dangit. You need the internet to use this app.", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
                timer.invalidate()
                self.reloadWebview()
                self.checkInternet()
                NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "checkInternet", userInfo: nil, repeats: true)
                })
            
            alertController.show()
        }
    }
    
//    func connectToWS(socketURL: WebSocket) {
//        var i = 1
//        let ws = socketURL
//        ws.event.open = {
//            print("Connected to socket \(ws)")
//        }
//        ws.event.close = { code, reason, clean in
//
//            if self.debug {
//                print("Couldn't connect to websocket. Start it, scrub.")
//            } else {
//                
//                if i == 5 {
//                    self.displayFailAlert(false)
//                    i = i + 1
//                } else {
//                    print("Could not connect. Retrying the \(i)'st time.")
//                    ws.open()
//                    i = i + 1
//                }
//            }
//            
//        }
//        
//        ws.event.error = { error in
//            print("error \(error)")
//        }
//        ws.event.message = { message in
//            if let text = message as? String {
//                print("recv: \(text)")
//                self.respondToChallenge(text)
//            }
//        }
//    }
//    
    
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

extension UIImage {
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()! as CGContextRef
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, .Normal)
        
        let rect = CGRectMake(0, 0, self.size.width, self.size.height) as CGRect
        CGContextClipToMask(context, rect, self.CGImage!)
        tintColor.setFill()
        CGContextFillRect(context, rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

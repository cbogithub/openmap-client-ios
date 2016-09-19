//
//  ViewController.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 26/08/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//
import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    private static var __once: () = {
                print("Connected via WWAN")
            }()
    
    @IBOutlet weak var webView: UIWebView!
    
    let debug = true
    var timer = Timer()
    let internetCheckInterval = Double(5)
    var successfulTimes = 0
    
    struct Static {
        static var dispatchOnceToken: Int = 0
    }
    
    lazy var locationManager: CLLocationManager! = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        return manager
    }()
    
    func checkInternet() {
        let status = Reach().connectionStatus()
        
        switch status {
        case .unknown, .offline:
            print("Not connected")
            displayFailAlert(true)
        case .online(.wwan):
            _ = ViewController.__once
        case .online(.wiFi):
            // Migrator FIXME: multiple dispatch_once calls using the same dispatch_once_t token cannot be automatically migrated
            dispatch_once(&Static.dispatchOnceToken) {
                print("Connected via WiFI")
            }
        }
        
    }
    
    func reloadWebview() {
        let url = URL(string: "https://openpokemap.pw/mobile.html")
        let request = URLRequest(url: url!)
        webView.scrollView.maximumZoomScale = 1.0;
        webView.scrollView.minimumZoomScale = 1.0;
        webView.loadRequest(request)
    }
   
    func networkStatusChanged(_ notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo
        print(userInfo)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingLocation()
        var timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(ViewController.checkInternet), userInfo: nil, repeats: true)
        
        reloadWebview()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()
    }
    
    
    // MARK: Websocket Delegate Methods.
    
    func displayFailAlert(_ network: Bool) {
        if network {
            print("Displaying no internet alert")
            timer.invalidate()
            let alertController = UIAlertController(title: "No Internet.", message: "Dangit. You need the internet to use this app.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                self.reloadWebview()
                self.checkInternet()
                })
            
            alertController.show()
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        
        let location = newLocation.coordinate
        
        if UIApplication.shared.applicationState == .active {
            print("App is active")
        } else {
            print("App is backgrounded. New location is \(location)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}

extension UIAlertController {
    
    func show() {
        present(true, completion: nil)
    }
    
    func present(_ animated: Bool, completion: (() -> Void)?) {
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            presentFromController(rootVC, animated: animated, completion: completion)
        }
    }
    
    fileprivate func presentFromController(_ controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if let navVC = controller as? UINavigationController,
            let visibleVC = navVC.visibleViewController {
            presentFromController(visibleVC, animated: animated, completion: completion)
        } else
            if let tabVC = controller as? UITabBarController,
                let selectedVC = tabVC.selectedViewController {
                presentFromController(selectedVC, animated: animated, completion: completion)
            } else {
                controller.present(self, animated: animated, completion: completion);
        }
    }
}

extension UIImage {
    func imageWithColor(_ tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()! as CGContext
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
        context.clip(to: rect, mask: self.cgImage!)
        tintColor.setFill()
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

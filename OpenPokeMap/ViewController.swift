//
//  ViewController.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 26/08/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//
import UIKit
import WebKit

class ViewController: UIViewController {
    
    private static var __once: () = {
                print("Connected via WWAN")
            }()
    
    var webView: WKWebView!
    
    let debug = true
    var timer = Timer()
    let internetCheckInterval = Double(5)
    var successfulTimes = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ =  Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(ViewController.checkInternet), userInfo: nil, repeats: true)
        
        setupWebView()
        reloadWebview()
        
        let notificationCenter = NotificationCenter.default
    }
    
    private func setupWebView() {
        webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        webView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    struct Static {
        static var dispatchOnceToken: Int = 0
    }
    
    func checkInternet() {
        let reachability = Reachability()!
        
        reachability.whenReachable = { reachability in
            DispatchQueue.main.async() {
                if reachability.isReachableViaWiFi {
                    print("Reachable via Wi-Fi")
                } else {
                    print("Reachable via Cellular")
                }
            }
        }
        reachability.whenUnreachable = { reachability in
            DispatchQueue.main.async() {
                print("Not reachable")
                self.displayFailAlert(true)
            }
        }
        
    }
    
    func reloadWebview() {
//        let url = URL(string: "https://openpokemap.pw")
        let url = URL(string: "https://ios.openpokemap.pw")
        let request = URLRequest(url: url!)
        webView.scrollView.maximumZoomScale = 1.0
        webView.scrollView.minimumZoomScale = 1.0
        webView.load(request)
    }
   
    func networkStatusChanged(_ notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo
        print(userInfo)
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

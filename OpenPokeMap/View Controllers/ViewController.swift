//
//  ViewController.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 26/08/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//
import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    
    let debug = true
    var timer = Timer()
    let internetCheckInterval = Double(5)
    var successfulTimes = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingLocation()
        _ =  Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(ViewController.checkInternet), userInfo: nil, repeats: true)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
    //MARK: Location Manager
    
    lazy var locationManager: CLLocationManager! = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        return manager
    }()
    
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]){
        let locationArray = locations
        if let locationObj = locationArray.last {
            let coord = locationObj.coordinate
            
            if UIApplication.shared.applicationState == .active {
                print("App is active")
            } else {
                print("App is backgrounded. Latitude: \(coord.latitude)")
                MakeRequest().makeRequest(lat: coord.latitude, lng: coord.longitude)
            }
        }
    }
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    // MARK: Error Handling & network
    
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
    
    func networkStatusChanged(_ notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo
        print(userInfo)
    }
    
    func displayFailAlert(_ network: Bool) {
        if network {
            print("Displaying no internet alert")
            timer.invalidate()
            let alertController = UIAlertController(title: "No Internet.", message: "Dangit. You need the internet to use this app.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                self.checkInternet()
                })
            
            alertController.show()
        }
    }
    
    //MARK: Misc.
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    func appMovedToBackground() {
        print("App moved to background!")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
}

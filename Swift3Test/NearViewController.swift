//
//  NearViewController.swift
//  Swift3Test
//
//  Created by Miaoz on 17/1/9.
//  Copyright © 2017年 Miaoz. All rights reserved.
//

import UIKit
import MapKit
import SnapKit
import CoreLocation
class NearViewController: BaseViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var mapView: MKMapView?
    //1. create locationManager
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MKMapView.init()
        self.view.addSubview(mapView!)
        mapView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        })
        
        // 2. setup locationManager
        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // 3. setup mapView
        mapView?.delegate = self
        mapView?.showsUserLocation = true
        mapView?.userTrackingMode = .follow
        
        // 4. setup test data
        setupData()
        // Do any additional setup after loading the view.
    }

    func setupData() {
        // 1. check if system can monitor regions
        
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            // 2. region data
            let title = "Lorrenzillo' s"
            let coordinate = CLLocationCoordinate2DMake(31.703026, 121.759735)
            let regionRadius = 300.0
            
            // 3. setup region
            let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude,longitude: coordinate.longitude), radius: regionRadius, identifier: title)
            
            // 4. setup annotation
            let restaurantAnnotation = MKPointAnnotation()
            restaurantAnnotation.coordinate = coordinate;
            restaurantAnnotation.title = "\(title)";
            self.mapView?.addAnnotation(restaurantAnnotation)
            
            // 5. setup circle
            let circle = MKCircle(center: coordinate, radius: regionRadius)
            self.mapView?.add(circle)
        }
        else {
            print("System can't track regions")
        }
        
        // 6. draw circle
        func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
            let circleRenderer = MKCircleRenderer(overlay: overlay)
            circleRenderer.strokeColor = UIColor.red
            circleRenderer.lineWidth = 1.0
            return circleRenderer
        }
    }
    var monitoredRegions: Dictionary<String, NSDate> = [:]
    
    // 1. user enter region
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
//        Tool.confirm(title: "erroe", message: region.identifier, controller: self)
        // 2.1 Add entrance time
        monitoredRegions[region.identifier] = NSDate()
        
    }
    // 2. user exit region
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
//         Tool.confirm(title: "exit", message: region.identifier, controller: self)
        // 2.2 Remove entrance time
        monitoredRegions.removeValue(forKey: region.identifier)
    }
    
    // 3. Update resions logic
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        updateRegions()
    }
    
    func updateRegions() {
        // 1.
        let regionMaxVisiting = 10.0
        var regionsToDelete: [String] = []
        //2.
        for regionIdentifier in monitoredRegions.keys {
            //3.
            if NSDate().timeIntervalSince(monitoredRegions[restorationIdentifier!]! as Date) > regionMaxVisiting {
                //showAlert("Thanks for visiting our restaurant")
                regionsToDelete.append((regionIdentifier))
            }
            // 4.
            for regionIdentifier in regionsToDelete {
                monitoredRegions.removeValue(forKey: regionIdentifier)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 1. status is not determined
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
            // 2. authorization were denied
        else if CLLocationManager.authorizationStatus() == .denied {
            //showAlert("Location services were previously denied, please enable loaction services")
        }
            // 3. we do have authorization
        else if CLLocationManager.authorizationStatus() == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

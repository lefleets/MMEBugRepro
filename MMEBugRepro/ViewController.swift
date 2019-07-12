//
//  ViewController.swift
//  MMEBugRepro
//
//  Created by Eric Lightfoot on 2019-07-12.
//  Copyright © 2019 Eric Lightfoot. All rights reserved.
//

import UIKit
import CoreLocation
import Mapbox
import os

class ViewController: UIViewController, MGLMapViewDelegate {
    var mapView: MGLMapView!
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mapView = MGLMapView(frame: view.bounds)
        mapView.userTrackingMode = .follow
        view.addSubview(mapView)
        
        locationManager = CLLocationManager()
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = CLActivityType.otherNavigation
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 49.746310600283195, longitude: -123.1081521233339), radius: 200.0, identifier: "TEST")
        region.notifyOnEntry = true
        region.notifyOnExit = true
        locationManager.startMonitoring(for: region)
        
//        stopMonitoringMMELMRI()
    }
    
    func stopMonitoringMMELMRI () {
        for region in locationManager.monitoredRegions {
            if region.identifier == "MMELocationManagerRegionIdentifier.fence.center" {
                locationManager.stopMonitoring(for: region)
                os_log("Called stopMonitoring(MMELocationManagerRegionIdentifier.fence.center)")
            }
        }
    }

}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locations = locations.map({ $0.coordinate })
        var locationStrings = [String]()
        
        for location in locations {
            locationStrings.append("[\(location.latitude),\(location.longitude)]")
        }
        
        os_log("didUpdateLocations with %@", locationStrings.joined(separator: ","))
        os_log("monitoring regions %@", locationManager.monitoredRegions.map({ $0.identifier }).joined(separator: ", "))
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        
        os_log("\n<-- ISSUE ON REAL DEVICE -->\n<-- Did start monitoring region %@\n-->", region.identifier)
        
    }
    
}


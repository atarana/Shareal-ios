//
//  MapController.swift
//  hackmit
//
//  Created by Kunal Sahni on 15/09/2019.
//  Copyright © 2019 Kunal Sahni. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class MapController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: GMSCameraPosition())
    
    override func viewDidLoad(){
        let filter = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self, action: nil)
        filter.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = filter
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 10.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let camera = GMSCameraPosition.camera(withLatitude: center.latitude, longitude: center.longitude, zoom: 12.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = center
        marker.title = "Current location"
        marker.map = mapView
        locationManager.stopUpdatingLocation()
    }
}

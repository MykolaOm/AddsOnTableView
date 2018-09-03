//
//  MapVC.swift
//  testApp
//
//  Created by Nikolas Omelianov on 02.09.2018.
//  Copyright © 2018 Nikolas Omelianov. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController {
    var mapView = MKMapView()
    let locationManager = CLLocationManager()
    let spanVar : Double = 0.5
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        checkLocationServices()
        
    }
    func setupMap() {
        mapView = MKMapView(frame: self.view.frame)
        self.view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.pinToEdges(view: self.view)
        
        
    }
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let span = MKCoordinateSpanMake(spanVar, spanVar)
            let region = MKCoordinateRegion.init(center: location, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // showAlert()
        }
    }
//    func showAlert(){
//        let alert = UIAlertController(title: "Permission", message: "can't get location", preferredStyle: .alert)
//    }
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            break
        }
    }
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}



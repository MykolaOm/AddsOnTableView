//
//  MapVCExtensions.swift
//  testApp
//
//  Created by Nikolas Omelianov on 03.09.2018.
//  Copyright © 2018 Nikolas Omelianov. All rights reserved.
//

import MapKit

extension MapVC : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(center ) { [weak self] (placemarks, error) in
            //            guard  self = self else { return }
            if self == nil {return}
            if let _ = error {
                print("fail on map")
                return
            }
            //            guard let placemark = placemarks?.first else { print("mark fails");return }
        }
    }
}

extension MapVC : CLLocationManagerDelegate {
    //    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //        guard let location = locations.last else { return }
    //        let region = MKCoordinateRegion.init(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: spanVar, longitudeDelta: spanVar))
    //        mapView.setRegion(region, animated: true)
    //    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

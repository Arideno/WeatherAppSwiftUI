//
//  LocationService.swift
//  WeatherApp
//
//  Created by Andrii Moisol on 29.03.2021.
//

import Foundation
import CoreLocation
import Combine

class LocationService: NSObject {
    
    private let locationManager = CLLocationManager()
    
    var cityName = PassthroughSubject<String?, Never>()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
}

extension LocationService: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let placemark = placemarks?[0] {
                self.cityName.send(placemark.locality)
            }
        }
    }

}

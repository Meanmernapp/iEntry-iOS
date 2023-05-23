//
//  LocationManager.swift
//  iEntry
//
//  Created by ZAFAR on 13/08/2021.
//

import Foundation
import CoreLocation
class LocationManager:NSObject,CLLocationManagerDelegate {
    static var share = LocationManager()
    var Manager: CLLocationManager!
    var passLatLong : ((_ lat:Double, _ Long:Double) -> (Void))? = nil

    func requestForLocation() {
        if (CLLocationManager.locationServicesEnabled())
        {
            Manager = CLLocationManager()
            Manager.delegate = self
            Manager.desiredAccuracy = kCLLocationAccuracyBest
            Manager.requestAlwaysAuthorization()
            Manager.startUpdatingLocation()
        }
    }
    
    func stopUpdating() {
        Manager.stopUpdatingLocation()
    }
    
}
extension LocationManager {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
       {

           let location = locations.last! as CLLocation
//           let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
             
        passLatLong?(location.coordinate.latitude, location.coordinate.longitude)
          
       }
}

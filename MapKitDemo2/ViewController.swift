//
//  ViewController.swift
//  MapKitDemo2
//
//  Created by Sunil Developer on 27/01/23.
//

import UIKit
//import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblLongitude: UILabel!
    @IBOutlet weak var lblLatitude: UILabel!
    var locationManager = CLLocationManager()
   
    override func viewDidLoad() {
        super.viewDidLoad()
       locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkPermision()
    }
    
    func checkPermision()  {
        
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            requestForLocation()
        case .restricted:
            requestForLocation()
        case .denied:
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            break
        case .authorizedAlways:
            //it will start updating the location
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            //it will start updating the location
            locationManager.startUpdatingLocation()

        }
    }
    
    func requestForLocation()  {
        //Foreground - application open and user is using
        //background - when application is not open n is in the backgroud
        //if you need location updates when app is running in the backgroud
  locationManager.requestAlwaysAuthorization()
        //it will provide locaiton update when user is using application
//locationManager.requestWhenInUseAuthorization()
        // Request a user’s location once
   locationManager.requestLocation()
    }
    
    // MARK: - location delegate method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
               
        guard  let userLocation: CLLocation = locations.first  else {
                return
                }
        let region = MKCoordinateRegion(center: userLocation.coordinate, span: span)
        
        self.lblLatitude.text = "\(userLocation.coordinate.latitude)"
        self.lblLongitude.text = "\(userLocation.coordinate.longitude)"
        print("latitude : \(userLocation.coordinate.latitude)")
        print("longitude : \(userLocation.coordinate.longitude)")
        
         mapView.setRegion(region, animated: true)
      //  mapView.showsUserLocation = true
        
        let annonation = MKPointAnnotation()
        annonation.coordinate = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
       mapView.addAnnotation(annonation)
        
        let pin = PinAnnonation(title: "hello", subtitle: "sagar", coordinate: annonation.coordinate)
        mapView.addAnnotation(pin)
        
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(userLocation) { placemark, error in
//            if let placeMarks = placemark as? [CLPlacemark] {
                if !(placemark?.isEmpty ?? false) {
                    let addess = "\(placemark?.first?.locality ?? ""), \(placemark?.first?.administrativeArea ?? ""), \(placemark?.first?.country ?? "")"
                  
                    self.lblAddress.text = addess
                    print("address : \(addess)")
                    
                }
            }
       // }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:",error.localizedDescription)
    }
    
//    func addAnnotation() {
//        let annonation = MKPointAnnotation()
//        annonation.coordinate = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: 0.05)
//        mapView.addAnnotation(annonation)
//
////        let region = MKCoordinateRegion(center: annonation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
////        mapView.setRegion(region, animated: true)
//
//        let pin = PinAnnonation(title: "hello", subtitle: "sagar", coordinate: annonation.coordinate)
//        mapView.addAnnotation(pin)
//
//    }
}




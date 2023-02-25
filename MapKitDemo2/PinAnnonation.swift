//
//  PinAnnonation.swift
//  MarkerOnMap
//
//  Created by Sunil Developer on 26/01/23.
//

import Foundation
import MapKit
class PinAnnonation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
     init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}

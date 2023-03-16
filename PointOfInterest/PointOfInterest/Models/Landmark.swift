//
//  Landmark.swift
//  PointOfInterest
//
//  Created by Aleksandar Karamirev on 19/02/2023.
//

import Foundation
import MapKit

struct Landmark: Identifiable {
    let id = UUID()
    let name: String
    let title: String
    let coordinate: CLLocationCoordinate2D
    
    init() {
        self.name = ""
        self.title = ""
        self.coordinate = CLLocationCoordinate2D()
    }
    
    init(placemark: MKPlacemark) {
        self.name = placemark.name ?? ""
        self.title = placemark.title ?? ""
        self.coordinate = placemark.coordinate
    }
}


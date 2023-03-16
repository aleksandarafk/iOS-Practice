//
//  MapView.swift
//  PointOfInterest
//
//  Created by Aleksandar Karamirev on 18/02/2023.
//


import Foundation
import SwiftUI
import MapKit

class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var control: MapView
    let locationManager = CLLocationManager()
    
    init(_ control: MapView) {
        self.control = control
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
        if let annotationView = views.first {
            if let annotation = annotationView.annotation {
                if annotation is MKUserLocation {
                    
                    if let userLocation = locationManager.location?.coordinate {
                        let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 500, longitudinalMeters: 500)
                        mapView.setRegion(region, animated: true)
                    }
                    
                }
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.first?.coordinate {
            let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 500, longitudinalMeters: 500)
            control.mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

struct MapView: UIViewRepresentable {
    
    let landmarks: [Landmark]
    
    var mapView = MKMapView()
       
       func makeUIView(context: Context) -> MKMapView {
           mapView.showsUserLocation = true
           mapView.delegate = context.coordinator
           return mapView
       }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        //
        updateAnnotations(from: uiView)
    }
    
    private func updateAnnotations(from mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        let annotations = self.landmarks.map(LandmarkAnnotation.init)
        mapView.addAnnotations(annotations)
    }
    
}

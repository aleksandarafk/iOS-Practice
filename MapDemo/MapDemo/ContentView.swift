//
//  ContentView.swift
//  MapDemo
//
//  Created by Aleksandar Karamirev on 18/02/2023.
//

import SwiftUI
import MapKit
struct ContentView: View {
    @State private var directions: [String] = []
    @State private var showDirections = false
    
    var body: some View {
        VStack {
            MapView(directions: $directions)
            
            Button(action: { self.showDirections.toggle()
            }, label: {
                Text("Show directions")
            })
            .disabled(directions.isEmpty)
            .padding()
        }.sheet(isPresented: $showDirections, content: {
            VStack(spacing: 0) {
                Text("Directions")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Divider().background(Color.gray)
                
                List(0..<self.directions.count, id:\.self) { i in
                    Text(self.directions[i]).padding()
                }
            }
        })
        .ignoresSafeArea()
    }
}

struct MapView: UIViewRepresentable {
    @Binding var directions: [String]
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    typealias UIViewType = MKMapView
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 42.7, longitude: 25.48),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        mapView.setRegion(region, animated: true)
        
        let pin1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 42.69, longitude: 23.32), addressDictionary: nil)
        let pin1Annotation = MKPointAnnotation()
        pin1Annotation.coordinate = pin1.coordinate
        pin1Annotation.title = "Sofia"
        
        let pin2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 43.21, longitude: 27.91), addressDictionary: nil)
        let pin2Annotation = MKPointAnnotation()
        pin2Annotation.coordinate = pin2.coordinate
        pin2Annotation.title = "Varna"
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: pin1)
        request.destination = MKMapItem(placemark: pin2)
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate{response, error in
            guard let route = response?.routes.first else {return}
            mapView.addAnnotations([pin1Annotation, pin2Annotation])
            mapView.addOverlay(route.polyline)
            mapView.setVisibleMapRect(
                route.polyline.boundingMapRect,
                edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated:true)
            self.directions = route.steps.map {$0.instructions}.filter {!$0.isEmpty}
        }
        
        return mapView
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 5
            return renderer
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

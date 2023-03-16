3//
//  Landmark.swift
//  Landmarks
//
//  Created by Aleksandar Karamirev on 10/02/2023.
//

import Foundation
import SwiftUI
import CoreLocation

//landmark details taken from the .json file
struct Landmark: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
    var isFavorite: Bool
    var isFeatured: Bool
    
    //categories in wich the landmarks are seperated
    var category: Category
    enum Category: String, CaseIterable, Codable{
        case lakes = "Lakes"
        case rivers = "Rivers"
        case mountains = "Mountains"
    }
    
    //unique images
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    var featureImage: Image? {
        isFeatured ? Image(imageName + "_feature") : nil
    }
    //the coordinats of the map
    private var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D{
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
    }
    //coordinates struct
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}

//
//  ModelData.swift
//  Landmarks
//
//  Created by Aleksandar Karamirev on 10/02/2023.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
    @Published var landmarks: [Landmark] = load("landmarkData.json")
    var hikes: [Hike] = load("hikeData.json")
    @Published var profile = Profile.default
    
    var features: [Landmark]{
        landmarks.filter { $0.isFeatured }
    }
    
    var categories: [String: [Landmark]]{
        Dictionary(
            grouping: landmarks,
            by: {$0.category.rawValue}
            )
    }
}

var landmarks: [Landmark] = load("landmarkData.json")

func load<T: Decodable>(_ filename: String) -> T{
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else{
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do{
        data = try Data(contentsOf: file)
    } catch{
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do{
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }catch{
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error).")
    }
}
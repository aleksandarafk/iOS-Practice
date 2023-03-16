//
//  Hike.swift
//  Landmarks
//
//  Created by Aleksandar Karamirev on 10/02/2023.
//

import Foundation

//the hike's information taken from the .json file
struct Hike: Codable, Hashable, Identifiable {
    var id: Int
    var name: String
    var distance: Double
    var difficulty: Int
    var observations: [Observation]
    
    static var formatter = LengthFormatter()
    
    var distanceText: String{
        Hike.formatter
            .string(fromValue: distance, unit: .kilometer)
    }
    
    //the observation view for the elevation, pace and heart rate
    struct Observation: Codable, Hashable {
        var distanceFromStart: Double
        
        var elevation: Range<Double>
        var pace: Range<Double>
        var heartRate: Range<Double>
    }
}

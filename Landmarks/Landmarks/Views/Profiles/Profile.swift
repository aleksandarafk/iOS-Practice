//
//  Profile.swift
//  Landmarks
//
//  Created by Aleksandar Karamirev on 11/02/2023.
//

import Foundation

//variables for what the profile page incldes
struct Profile {
    var username: String
    var prefersNotifications = true
    var seasonalPhoto = Season.winter
    var goalDate = Date()
    
    //default username - can be changed by the user, however it won't be saved
    //since there is no database involved
    static let `default` = Profile(username: "g_kumar")
    
    //cases for the seasons that can be changed by the usr
    enum Season: String, CaseIterable, Identifiable {
        case spring = "🌷"
        case summer = "🌞"
        case autumn = "🍂"
        case winter = "☃️"
        
        var id: String { rawValue }
    }
}

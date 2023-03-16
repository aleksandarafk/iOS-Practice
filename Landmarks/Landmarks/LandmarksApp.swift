//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by Aleksandar Karamirev on 10/02/2023.
//

import SwiftUI

@main
struct LandmarksApp: App {
    //state to use the modelData from all views
    @StateObject private var modelData = ModelData()
    var body: some Scene {
        WindowGroup {
            //adding the ability to read the modelData from all views
            ContentView()
                .environmentObject(modelData)
        }
    }
}

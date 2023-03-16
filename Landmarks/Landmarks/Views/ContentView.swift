//
//  ContentView.swift
//  Landmarks
//
//  Created by Aleksandar Karamirev on 10/02/2023.
//

import SwiftUI

struct ContentView: View {
    //state for the featured tab
    //and enum for the included things in the featured tab
    @State private var selection: Tab = .featured
    enum Tab{
        case featured
        case list
    }
    
    //the homepage of the website + bottom navigation menu and profile page
    var body: some View {
        TabView(selection: $selection){
            CategoryHome()
                .tabItem{
                    Label("Featured", systemImage: "star")
                }
                .tag(Tab.featured)
            
            LandmarkList()
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
                .tag(Tab.list)
        }
    }
}
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .environmentObject(ModelData())
        }
    }


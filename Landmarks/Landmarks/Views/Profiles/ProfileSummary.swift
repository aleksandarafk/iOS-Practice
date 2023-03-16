//
//  ProfileSummary.swift
//  Landmarks
//
//  Created by Aleksandar Karamirev on 11/02/2023.
//

import SwiftUI

struct ProfileSummary: View {
    //enviromental object for the modelData
    //variable for the profile view
    @EnvironmentObject var modelData: ModelData
    var profile: Profile
    
    //body design of the whole profile page
    //including the hikes
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 10){
                Text(profile.username)
                    .bold()
                    .font(.title)
                
                Text("Notifications: \(profile.prefersNotifications ? "On": "Off" )")
                Text("Seasonal Photos: \(profile.seasonalPhoto.rawValue)")
                Text("Goal Date: ") + Text(profile.goalDate, style: .date)
                Divider()
                
                VStack(alignment: .leading){
                    Text("Completed Badges")
                        .font(.headline)
                    
                    ScrollView(.horizontal){
                        HStack{
                            HikeBadge(name: "First Hike")
                            HikeBadge(name: "Earth Day")
                                .hueRotation(Angle(degrees:90))
                            HikeBadge(name: "Tenth Hike")
                                .grayscale(0.5)
                                .hueRotation(Angle(degrees: 45))
                        }
                        .padding(.bottom)
                    }
                }
                Divider()
                
                VStack(alignment: .leading){
                    Text("Recent Hikes")
                        .font(.headline)
                    HikeView(hike: modelData.hikes[0])
                }
            }
        }
    }
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary(profile: Profile.default)
            .environmentObject(ModelData())
    }
}

//
//  ProfileHost.swift
//  Landmarks
//
//  Created by Aleksandar Karamirev on 11/02/2023.
//

import SwiftUI

struct ProfileHost: View {
    //allowing the user to edit the profile page
    //adding the option to control the modelData across all views
    //Adding a profile state
    @Environment(\.editMode) var editMode
    @EnvironmentObject var modelData: ModelData
    @State private var draftProfile = Profile.default
    
    var body: some View {
        //if statement for the appearance of the edit mode and cancel button + the vertical and horizontal stacks
        VStack(alignment: .leading, spacing: 10){
            HStack{
                if editMode?.wrappedValue == .active {
                    Button("Cancel", role: .cancel){
                        draftProfile = modelData.profile
                        editMode?.animation().wrappedValue = .inactive
                    }
                }
                Spacer()
                EditButton()
            }
            if editMode?.wrappedValue == .inactive{
                ProfileSummary(profile: modelData.profile)
            }
            else {
                ProfileEditor(profile: $draftProfile)
                    .onAppear{
                        draftProfile = modelData.profile
                    }
                    .onDisappear{
                        modelData.profile = draftProfile
                    }
            }
        }
        .padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
            .environmentObject(ModelData())
    }
}

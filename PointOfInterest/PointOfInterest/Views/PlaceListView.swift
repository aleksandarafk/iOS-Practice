//
//  PlaceListView.swift
//  PointOfInterest
//
//  Created by Aleksandar Karamirev on 19/02/2023.
//
import SwiftUI
import MapKit

struct PlaceListView: View {
    
    let landmarks: [Landmark]
    var onTap: () -> ()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                EmptyView()
            }.frame(width: UIScreen.main.bounds.size.width, height: 60)
                .background(Color.gray)
                .gesture(TapGesture()
                    .onEnded(self.onTap)
            )
            
            List {
                
                ForEach(self.landmarks, id: \.id) { landmark in
                    
                    VStack(alignment: .leading) {
                        Text(landmark.name)
                            .fontWeight(.bold)
                        
                        Text(landmark.title)
                    }
                }
                
            }.animation(nil)
            
        }.cornerRadius(10)
    }
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView(landmarks: [Landmark()], onTap: {})

    }
}

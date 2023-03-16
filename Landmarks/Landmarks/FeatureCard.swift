//
//  FeatureCard.swift
//  Landmarks
//
//  Created by Aleksandar Karamirev on 11/02/2023.
//

import SwiftUI

//the featured card initial design
struct FeatureCard: View {
    var landmark: Landmark
    var body: some View {
        landmark.featureImage?
            .resizable()
            .aspectRatio(3 / 2, contentMode: .fit)
            .overlay {
                TextOverlay(landmark: landmark)
            }
    }
}

//the text overlay style
struct TextOverlay: View{
    var landmark: Landmark
    //coloring the text
    var gradient: LinearGradient{
        .linearGradient(
            Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }
    //allignment of the text view
    var body: some View{
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading){
                Text(landmark.name)
                    .font(.title)
                    .bold()
                Text(landmark.park)
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}

struct FeatureCard_Previews: PreviewProvider {
    static var previews: some View {
        FeatureCard(landmark: ModelData().features[0])
    }
}

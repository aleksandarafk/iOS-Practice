//
//  CircleImage.swift
//  Landmarks
//
//  Created by Aleksandar Karamirev on 10/02/2023.
//

import SwiftUI

//how the image should appear for each landmark
struct CircleImage: View {
    var image: Image
    var body: some View{
        image
            .clipShape(Circle())
            .overlay{
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("turtlerock"))
    }
}

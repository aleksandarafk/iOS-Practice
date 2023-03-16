//
//  RotatedBadgeSymbol.swift
//  Landmarks
//
//  Created by Aleksandar Karamirev on 10/02/2023.
//

import SwiftUI

//the rotation of the badge symbol that is used later on for the badge 
struct RotatedBadgeSymbol: View {
    let angle: Angle
    var body: some View {
        BadgeSymbol()
            .padding(-60)
            .rotationEffect(angle, anchor: .bottom)
    }
}

struct RotatedBadgeSymbol_Previews: PreviewProvider {
    static var previews: some View {
        RotatedBadgeSymbol(angle: Angle(degrees: 5))
    }
}

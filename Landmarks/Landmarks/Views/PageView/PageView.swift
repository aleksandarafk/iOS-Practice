//
//  PageView.swift
//  Landmarks
//
//  Created by Aleksandar Karamirev on 11/02/2023.
//
//the swiping card in the homepage of the app
import SwiftUI

struct PageView<Page:View>: View {
    //variable for the changable pages
    var pages: [Page]
    //state declaring that the current page is "turtle rock" - it is taken from the .json file
    @State private var currentPage = 0
    
    //zstack view with a custom allignment for the PageViewController and PageControl responsible for the swiping interction on the card
    var body: some View{
        ZStack(alignment: .bottomTrailing) {
            PageViewController(pages: pages, currentPage: $currentPage)
            PageControl(numberOfPages: pages.count, currentPage: $currentPage)
                .frame(width: CGFloat(pages.count * 18))
                .padding(.trailing)
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        //loading the page view with the featured parts of the .json file and adding the aspect ratio + featured card start
        PageView(pages: ModelData().features.map{FeatureCard(landmark: $0) })
            .aspectRatio(3 / 2, contentMode: .fit)
    }
}

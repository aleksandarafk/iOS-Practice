//
//  PageControl.swift
//  Landmarks
//
//  Created by Aleksandar Karamirev on 11/02/2023.
//

import SwiftUI
import UIKit

//creating the ability to switch between featured pages
struct PageControl: UIViewRepresentable {
    //variable for the number of pages processed as an integer
    var numberOfPages: Int
    //property value that can write and read the current page as an integer
    @Binding var currentPage: Int
    
    //creating a coordinator with current instance
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    //function for the uiview and the control of the number of pages
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        control.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged)
        
        return control
    }
    //updating the view depending on the swiping of the user
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
    //coordinator class for the PageControl
    class Coordinator: NSObject {
            //declaring the struct as a parent variable
            var control: PageControl
            //initializing the PageControl for the current instance
            init(_ control: PageControl) {
                self.control = control
            }
            //function for updating the current page
            @objc
            func updateCurrentPage(sender: UIPageControl) {
                control.currentPage = sender.currentPage
            }
        }
    }


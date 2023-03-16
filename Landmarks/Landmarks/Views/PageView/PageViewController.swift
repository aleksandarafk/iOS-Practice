//
//  PageViewController.swift
//  Landmarks
//
//  Created by Aleksandar Karamirev on 11/02/2023.
//

import SwiftUI
import UIKit
//creating the ability to switch between featured pages
struct PageViewController<Page: View>: UIViewControllerRepresentable {
    //variable for the number of pages processed as an integer
    var pages: [Page]
    //property value that can write and read the current page as an integer
    @Binding var currentPage: Int
    
    //coordinator class for the PageViewController
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    //adding the transition style and navigation orientation to the ui depening on the scroll
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
            pageViewController.dataSource = context.coordinator
            pageViewController.delegate = context.coordinator

        return pageViewController
    }

    //updating the current view
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers(
            [context.coordinator.controllers[currentPage]], direction: .forward, animated: true)
    }
    
    //coordinator class for the PageViewController
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        //variables to use for the PageViewController and UIViewController
        var parent: PageViewController
        var controllers = [UIViewController]()
        
        init(_ pageViewController: PageViewController){
            parent = pageViewController
            controllers = parent.pages.map { UIHostingController(rootView: $0) }
        }
        
        //function for the navigation of the view
        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerBefore viewController: UIViewController) -> UIViewController?
        {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            //if statement that controlls the swipe and from where it should start
            //when going back from the last to the first
            if index == 0 {
                return controllers.last
            }
            return controllers[index - 1]
        }
        
        //function for the navigation of the view
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            //if statement that controlls the swipe and from where it should start
            //when starting from the first and going to the last
            if index + 1 == controllers.count {
                return controllers.first
            }
            return controllers[index + 1]
        }
        //function for the transitions of the views
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed,
               let visibleViewController = pageViewController.viewControllers?.first,
               let index = controllers.firstIndex(of: visibleViewController) {
                parent.currentPage = index
            }
        }
        
    }
}


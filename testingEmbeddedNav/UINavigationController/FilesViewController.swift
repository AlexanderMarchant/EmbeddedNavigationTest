//
//  FilesViewController.swift
//  testingEmbeddedNav
//
//  Created by Alex Marchant on 02/03/2022.
//

import Foundation
import SwiftUI

struct FilesViewController: UIViewControllerRepresentable {

    let navController: UINavigationController
    let parent: NestedView

    func makeUIViewController(context: Context) -> UINavigationController {
        navController.setNavigationBarHidden(true, animated: false)
        let viewController = UIViewController()
        navController.addChild(viewController)
        return navController
    }

    func updateUIViewController(_ pageViewController: UINavigationController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: FilesViewController

        init(_ filesViewController: FilesViewController) {
            self.parent = filesViewController
        }
    }

    func showNestedView() {
        
        // Handle the tap inside of me
        
//        if int <= 200 {
//            // Show this
//        } else if int > 200 && int <= 400 {
//            // Show this view
//        } else if int > 400 && int <= 600 {
//            // Show this view
//        } else if int > 600 && int <= 800 {
//            // Show this view
//        } else {
//            // Show this view
//        }
        
        let nestedView = NestedView(nest: Int.random(in: 0...1000))
        let view = UIHostingController(rootView: nestedView)
        
        let vc = navController.viewControllers.last
        vc?.view.isHidden = true
        
        navController.pushViewController(view, animated: true)
    }
    
    func popNestedView() {
        
        navController.popViewController(animated: true)
        
        let vc = navController.viewControllers.last
        vc?.view.isHidden = false
        
    }

}

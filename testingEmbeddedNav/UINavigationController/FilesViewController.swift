//
//  FilesViewController.swift
//  testingEmbeddedNav
//
//  Created by Alex Marchant on 02/03/2022.
//

import Foundation
import SwiftUI

struct FilesViewController: UIViewControllerRepresentable {

    let navController = UINavigationController()
    let parent: UIHostingController<NestedView>

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
        
        let nestedView = NestedView(nest: self.parent.rootView.nest + 1)
        let view = UIHostingController(rootView: nestedView)
        
        navController.pushViewController(view, animated: true)
    }
    
    func popNestedView() {
        
        navController.popViewController(animated: true)
        
    }
    
    // MARK: - Add SwiftUI View
    
    public func removeSwiftUIView() {
        self.parent.willMove(toParent: nil)
        self.parent.view.removeFromSuperview()
        self.parent.removeFromParent()
    }
    
//    public func add<V: View>(swiftUIView: V, parentViewController: UIViewController? = nil) {
//        guard let contentView = self.view.contentView else {
//            return
//        }
//        removeSwiftUIView()
//        let hostingController = UIHostingController(rootView: AnyView(swiftUIView))
//        self.hostingController = hostingController
//        let parent = parentViewController ?? self.controller
//        parent?.addChild(hostingController)
//        hostingController.view.frame = contentView.bounds
//        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        contentView.addSubview(hostingController.view)
//        hostingController.didMove(toParent: parent)
//    }

}

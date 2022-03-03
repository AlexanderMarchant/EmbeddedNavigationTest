//
//  NestedView.swift
//  testingEmbeddedNav
//
//  Created by Alex Marchant on 02/03/2022.
//

import SwiftUI
import UIKit

struct NestedView: View {
    
    @State var nest = 0
    
    var navController: UINavigationController = UINavigationController()
    
    var body: some View {
        
        let filesView = FilesViewController(navController: self.navController, parent: self)
        
        return VStack {

            ZStack {
                
                filesView
                
                VStack {
                    Spacer()
                    Text("Nest: \(self.nest)")
                    
                    Button(action: {
                        filesView.showNestedView()
                    } ) {
                        Text("Show Nested View")
                    }
                    
                    Button(action: {
                        filesView.popNestedView()
                    } ) {
                        Text("Pop Me")
                    }
                    Spacer()
                }
                .background(Color.green)
                
            }
            
            .background(Color.blue)
            .navigationBarHidden(true)
        }
    }
}

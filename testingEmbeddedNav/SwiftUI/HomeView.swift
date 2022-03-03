//
//  HomeView.swift
//  testingEmbeddedNav
//
//  Created by Alex Marchant on 03/03/2022.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var path: String
    
    @State private var showHome = true
    
    var body: some View {
        
        if self.showHome {
            VStack(spacing: 25) {
                
                Spacer()
                
                Text("This is my home view")
                
                Button(action: {
                    self.showHome = false
                }, label: {
                    Text("Tap me to go to nested views")
                })
                
                Spacer()
                
            }
        } else {
            NestedView_SwiftUI(currentPath: self.$path)
        }
        
        
    }
}

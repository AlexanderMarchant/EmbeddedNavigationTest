//
//  NestedView_SwiftUI.swift
//  testingEmbeddedNav
//
//  Created by Alex Marchant on 03/03/2022.
//

import SwiftUI

struct NestedView_SwiftUI: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var nest = 0
    @State private var isActive = false
    
    var body: some View {
        
        NavigationView {
            
            VStack(spacing: 25) {

                NavigationLink(destination: NestedView_SwiftUI(nest: self.nest + 1).navigationBarHidden(true), isActive: $isActive) {
                    
                    Button {
                        
                        // run your code
                        
                        // then set
                        isActive = true

                    } label: {
                        VStack(spacing: 15) {
                            Text("Nest: \(self.nest)")
                            Text("Go one nest deeper")
                        }
                    }
                    .background(Color.white)
                }
                
                    Button {
                        
                        self.isActive = false
                        self.mode.wrappedValue.dismiss()

                    } label: {
                        Text("Go back to parent nest")
                    }
                    .background(Color.white)
                
            }
            .padding()
            .background(Color.yellow)
            
            
        }
    }
    
}

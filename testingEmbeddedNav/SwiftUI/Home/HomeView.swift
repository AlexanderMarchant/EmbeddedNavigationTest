//
//  HomeView.swift
//  testingEmbeddedNav
//
//  Created by Alex Marchant on 03/03/2022.
//

import SwiftUI
import Combine

struct HomeView: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
    
    @Binding var path: String
    @Binding var didReachFile: Bool
    
    @State private var nest = 0
    @State private var showHome = true
    
    @State private var showingErrorAlert = false
    
    var body: some View {
        
        VStack {
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
                NestedView_SwiftUI(
                    gif: self.homeViewModel.gifs.first,
                    currentPath: self.$path,
                    didReachFile: self.$didReachFile
                )
                .onReceive(Just(self.nest), perform: { value in
                    
                })
                
    //            NestedView()
            }
        }
        .alert(isPresented: $showingErrorAlert) {
            return Alert(
                title: Text("Loading Failed"),
                message: Text("Something went wrong whilst loading the gifs, please try again"),
                dismissButton: .default(Text("OK"))
            )
        }
        
        
    }
    
}

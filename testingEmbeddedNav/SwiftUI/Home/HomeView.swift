//
//  HomeView.swift
//  testingEmbeddedNav
//
//  Created by Alex Marchant on 03/03/2022.
//

import SwiftUI
import Combine

struct HomeView: View {
    
    @EnvironmentObject var appState: AppState
    
    @ObservedObject var homeViewModel: HomeViewModel
    
    @Binding var pathComponents: [String]
    @Binding var didReachFile: Bool
    
    @State private var gif: Gif? = nil
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
                        self.pathComponents.append("0")
                    }, label: {
                        Text("Tap me to go to nested views")
                    })
                    
                    Spacer()
                    
                }
            } else {
                NestedView_SwiftUI(
                    gif: self.$gif,
                    pathComponents: self.$pathComponents,
                    nest: self.$nest,
                    didReachFile: self.$didReachFile
                )
                
    //            NestedView()
            }
        }
        .onChange(of: self.nest, perform: { [nest] newValue in
            
            if nest > newValue {
                
                if self.homeViewModel.gifs.count > 1 {
                    let dif = nest - newValue
                    
                    for _ in 0..<dif {
                        self.homeViewModel.gifs.removeLast()
                    }
                }
                
                self.gif = self.homeViewModel.gifs.last
                
            } else {
                
                homeViewModel.loadNextGifSet(onLoad: { gif in
                    DispatchQueue.main.async {
                        self.gif = gif
                    }
                })
                
            }
            
            
            
        })
        .onChange(of: appState.pathClicked, perform: { value in
            
            guard let newValue = value else {
                return
            }
            
            if self.nest > newValue {

                if self.pathComponents.count > 1 {
                    let dif = nest - newValue

                    for _ in 0..<dif {
                        self.pathComponents.removeLast()
                    }
                }

            }
            
            self.nest = newValue
            
        })
        .alert(isPresented: $showingErrorAlert) {
            return Alert(
                title: Text("Loading Failed"),
                message: Text("Something went wrong whilst loading the gifs, please try again"),
                dismissButton: .default(Text("OK"))
            )
        }
        
        
    }
    
}

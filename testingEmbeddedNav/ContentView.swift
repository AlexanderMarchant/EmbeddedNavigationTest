//
//  ContentView.swift
//  testingEmbeddedNav
//
//  Created by Alex Marchant on 02/03/2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var appState = AppState()
    
    let vc = HomeViewModel()
    
    @State var pathComponents = [String]()
    @State private var currentLocation = "Home"
    
    @State var didReachFile = false
    
    var body: some View {
        
        VStack {
            VStack(spacing: 10) {
                HStack {
                    Image(systemName: "clock")
                    Spacer()
                    Text("This is my header")
                        .background(Color.red)
                    Spacer()
                    Image(systemName: "clock")
                }
                if !pathComponents.isEmpty {
                    HStack(spacing: 5) {
                        Image(systemName: "house")
                            .onTapGesture {
                                appState.rootViewId = UUID()
                            }
                        
                        ForEach(self.pathComponents, id: \.self) { component in
                            Text(component)
                                .font(.subheadline)
                                .underline()
                                .foregroundColor(.yellow)
                                .onTapGesture {
                                    let clicked = Int(component.replacingOccurrences(of: " ", with: ""))
                                    appState.pathClicked = clicked
                                }
                            
                            Text(">")
                                .font(.subheadline)
                        }
                        
                        Spacer()
                    }
                }
                if !self.didReachFile {
                    HStack {
                        Text(self.currentLocation)
                            .font(.headline)
                        Spacer()
                    }
                }
            }
            .background(.blue)
            
            HomeView(
                homeViewModel: vc,
                pathComponents: self.$pathComponents,
                didReachFile: self.$didReachFile
            )
            
        }
        .environmentObject(self.appState)
        .id(appState.rootViewId) 
        .padding(.horizontal, 25)
        .onChange(of: self.pathComponents, perform: { newValue in
            
            if !newValue.isEmpty {
                self.currentLocation = newValue.last ?? ""
            } else {
                self.currentLocation = "Home"
                self.pathComponents = [String]()
            }
            
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

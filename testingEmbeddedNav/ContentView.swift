//
//  ContentView.swift
//  testingEmbeddedNav
//
//  Created by Alex Marchant on 02/03/2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var appState = AppState()
    
    @State var path = ""
    @State private var currentLocation = "Home"
    @State private var pathComponents = [String]()
    
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
                            
                            Text(">")
                                .font(.subheadline)
                        }
                        
                        Spacer()
                    }
                }
                HStack {
                    Text(self.currentLocation)
                        .font(.headline)
                    Spacer()
                }
            }
            .background(.blue)
            
            HomeView(path: self.$path)
            
        }
        .environmentObject(self.appState)
        .id(appState.rootViewId) 
        .padding(.horizontal, 25)
        .onChange(of: self.path, perform: { newValue in
            
            if !newValue.isEmpty {
                let split = newValue.split(separator: ">")
                
                var mutableSplit = split
                mutableSplit.removeLast()
                
                let mutablePath = mutableSplit.map({ String($0) })
                
                self.currentLocation = String(split.last ?? "")
                self.pathComponents = mutablePath
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

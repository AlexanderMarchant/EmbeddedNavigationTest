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
    @State private var currentLocation = ""
    @State private var currentPath = ""
    
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
                if !currentPath.isEmpty {
                    HStack {
                        Image(systemName: "house")
                            .frame(width: 12, height: 12)
                            .onTapGesture {
                                appState.rootViewId = UUID()
                            }
                        Text(self.currentPath)
                            .font(.subheadline)
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
            
            NestedView_SwiftUI(currentPath: self.$path)
            
//            NestedView()
            
        }
        .environmentObject(self.appState)
        .id(appState.rootViewId) 
        .padding(.horizontal, 25)
        .onChange(of: self.path, perform: { newValue in
            
            if !newValue.isEmpty {
                let split = newValue.split(separator: ">")
                
                var mutableSplit = split
                mutableSplit.removeLast()
                
                let mutablePath = mutableSplit.map({ String($0) }).joined(separator: " > ")
                
                self.currentLocation = String(split.last ?? "")
                self.currentPath = mutablePath
            } else {
                self.currentLocation = "Home"
                self.currentPath = ""
            }
            
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

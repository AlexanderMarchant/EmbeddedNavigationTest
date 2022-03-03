//
//  ContentView.swift
//  testingEmbeddedNav
//
//  Created by Alex Marchant on 02/03/2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        VStack {
            VStack {
                HStack {
                    Image(systemName: "clock")
                    Spacer()
                    Text("This is my header")
                        .background(Color.red)
                    Spacer()
                    Image(systemName: "clock")
                }
                Text("Second Row")
            }
            
            NestedView_SwiftUI()
//            NestedView()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

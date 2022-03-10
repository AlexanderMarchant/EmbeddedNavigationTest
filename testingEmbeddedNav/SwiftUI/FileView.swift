//
//  FileView.swift
//  testingEmbeddedNav
//
//  Created by Alex Marchant on 03/03/2022.
//

import SwiftUI

struct FileView: View {
    
    @EnvironmentObject var appState: AppState
    
    @Binding var pathComponents: [String]
    @Binding var didReachFile: Bool
    
    var fileType: String
    
    var body: some View {
        VStack {
            Text(fileType)
                .navigationBarHidden(false)
                .navigationTitle(fileType)
                .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear(perform: {
            self.pathComponents.append("\(self.fileType)")
            self.didReachFile = true
        })
        .onDisappear(perform: {
            self.pathComponents.removeLast()
            self.didReachFile = false
        })
    }
    
}

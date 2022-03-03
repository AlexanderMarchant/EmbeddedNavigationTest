//
//  FileView.swift
//  testingEmbeddedNav
//
//  Created by Alex Marchant on 03/03/2022.
//

import SwiftUI

struct FileView: View {
    
    @EnvironmentObject var appState: AppState
    
    @Binding var currentPath: String
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
            self.currentPath = "\(self.currentPath) > \(fileType)"
            self.didReachFile = true
        })
        .onDisappear(perform: {
            self.currentPath = self.currentPath.replacingOccurrences(of: " > \(fileType)", with: "")
            self.didReachFile = false
        })
    }
    
}

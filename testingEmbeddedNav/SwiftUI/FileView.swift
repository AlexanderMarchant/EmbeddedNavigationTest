//
//  FileView.swift
//  testingEmbeddedNav
//
//  Created by Alex Marchant on 03/03/2022.
//

import SwiftUI

struct FileView: View {
    
    @Binding var currentPath: String
    var fileType: String
    
    var body: some View {
        Text(fileType)
            .navigationBarHidden(false)
    }
    
}

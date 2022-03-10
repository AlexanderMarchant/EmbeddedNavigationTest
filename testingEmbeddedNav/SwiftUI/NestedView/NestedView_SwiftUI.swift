//
//  NestedView_SwiftUI.swift
//  testingEmbeddedNav
//
//  Created by Alex Marchant on 03/03/2022.
//

import SwiftUI

enum FileExtension: String, CaseIterable {
    case txt = "txt"
    case pdf = "pdf"
    case docx = "docx"
    case md = "md"
    case png = "png"
    case jpg = "jpg"
}

struct NestedView_SwiftUI: View {
    
    @EnvironmentObject var appState: AppState
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var gif: Gif?
    
    @State var nest = 0
    @State private var isActive = false
    
    @Binding var pathComponents: [String]
    @Binding var didReachFile: Bool
    
    var fileExtension: FileExtension? = nil
    
    var body: some View {
        
        NavigationView {
            
            HStack {
                
                Spacer()
                
                VStack(spacing: 25) {
                    
                    GiphyView(giphyRowViewModel: .init(gif: self.gif))

                    NavigationLink(destination: getDestination(from: self.fileExtension), isActive: $isActive) {
                        
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
                    
                    Spacer()
                    
                }
                
                Spacer()
                
            }
            .padding()
            .background(Color.yellow)
            
            
        }
        .onChange(of: appState.pathClicked, perform: { value in
            
            guard let newValue = value else {
                      return
                  }
            
            if self.nest == newValue {
                self.isActive = false
            }
            
        })
        .onAppear(perform: {
            self.pathComponents.append("\(self.nest)")
        })
        .onDisappear(perform: {
            self.pathComponents.removeLast()
        })
    }
    
    func getDestination(from fileExtension: FileExtension? = nil) -> AnyView {
        
        if let ext = fileExtension {
            
            return AnyView(
                FileView(
                    pathComponents: self.$pathComponents,
                    didReachFile: self.$didReachFile,
                    fileType: ext.rawValue
                )
                .navigationBarHidden(false)
            )
            
        } else {
            
            if self.nest == 2 {
                return AnyView(
                    NestedView_SwiftUI(
                        nest: self.nest + 1,
                        pathComponents: self.$pathComponents,
                        didReachFile: self.$didReachFile,
                        fileExtension: .jpg
                    )
                    .navigationBarHidden(true)
                )
            } else {
                return AnyView(
                    NestedView_SwiftUI(
                        nest: self.nest + 1,
                        pathComponents: self.$pathComponents,
                        didReachFile: self.$didReachFile,
                        fileExtension: nil
                    )
                    .navigationBarHidden(true)
                )
            }
        }
        
    }
    
}

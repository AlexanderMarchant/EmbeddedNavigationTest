//
//  GiphyView.swift
//  testingEmbeddedNav
//
//  Created by Alex Marchant on 10/03/2022.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI


struct GiphyView: View {
    
    @ObservedObject var giphyRowViewModel: GiphyRowViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 25) {
            HStack(alignment: .center, spacing: 15) {
                
                if let gifUrl = giphyRowViewModel.gif?.gifUrl {
                    
                    AnimatedImage(url: URL(string: gifUrl)!)
                        .resizable()
                        .placeholder(UIImage(named: "image-not-found"))
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding(.top)
                    
                } else {
                    Image(uiImage: UIImage(imageLiteralResourceName: "image-not-found"))
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding(.top)
                }
            }
        }
        .padding(.leading, 25)
        .padding(.trailing, 25)
    }
}

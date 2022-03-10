//
//  GiphyViewModel.swift
//  testingEmbeddedNav
//
//  Created by Alex Marchant on 10/03/2022.
//

import Foundation
import SwiftUI

public class GiphyRowViewModel: ObservableObject {
    
    let gif: Gif?
    let urlSessionService: UrlSessionServiceProtocol
    
    // Showing downloading of image myself and not through SDWebImageSwiftUI
    @Published var gifData = Data()
    
    init(
        gif: Gif?,
        _ urlSessionService: UrlSessionServiceProtocol = UrlSessionService()) {
        
        self.gif = gif
        self.urlSessionService = urlSessionService
        
        downloadGif()
    }
    
    func downloadGif() {
        
        // Showing downloading of image myself and not through SDWebImageSwiftUI
        guard let url = self.gif?.gifUrl else {
            return
        }
        
        urlSessionService.downloadImage(from: URL(string: url)!) { (data, response, error) in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.gifData = data
            }
        }
    }
}

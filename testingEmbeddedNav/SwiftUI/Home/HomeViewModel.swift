//
//  HomeViewModel.swift
//  testingEmbeddedNav
//
//  Created by Alex Marchant on 10/03/2022.
//

import Foundation
import SwiftUI

public class HomeViewModel: ObservableObject {
    
    let urlSessionService: UrlSessionServiceProtocol
    let giphyService: GiphyServiceProtocol
    
    @Published private (set) var showAlert = false
    @Published private (set) var isLoading = false
    
    @Published var gifs = [Gif]()
    
    private (set) var currentSearch: GiphySearch?
    private (set) var currentSearchTerm: String?
    
    init(_ giphyService: GiphyServiceProtocol = GiphyService(),
         _ urlSessionService: UrlSessionServiceProtocol = UrlSessionService()) {
    
        self.giphyService = giphyService
        self.urlSessionService = urlSessionService
        
        getGifs(by: .random, searchTerm: nil)
    }
    
    func resetAlert() {
        DispatchQueue.main.async {
            self.showAlert = false
        }
    }
    
    func isLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            self.isLoading = isLoading
        }
    }
    
    func getGifs(by searchType: GiphySearch, searchTerm: String? = nil) {
        
        resetAlert()
        
        self.gifs = [Gif]()
        self.giphyService.resetTrendingSearch()
        self.giphyService.resetSearchByTermSearch()
        
        switch searchType {
        case .trending:
            self.getTrendingGifs()
        case .bySearchTerm:
            self.getGifsBySearchTerm(userSearch: searchTerm)
        case .random:
            self.getRandomGif()
        }
    }
    
    func loadNextGifSet(onLoad: @escaping ((Gif?) -> Void)) {
        
        resetAlert()
        
        guard let currentSearch = currentSearch else {
            return
        }
        
        switch currentSearch {
        case .bySearchTerm:
            self.getGifsBySearchTerm(userSearch: currentSearchTerm!)
        case .trending:
            self.getTrendingGifs(onLoad: onLoad)
        case .random:
            self.getRandomGif(onLoad: onLoad)
        }
    }
    
    private func getGifsBySearchTerm(userSearch: String?) {
        
        guard var search = userSearch else {
            return
        }
        
        search = search.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(search.isEmpty) {
            return
        }
        
        isLoading(true)
        
        self.currentSearch = .bySearchTerm
        self.currentSearchTerm = search
        
        self.giphyService.getGifsBySearchTerm(search: search, limit: 15) { [weak self] (gifs, error) in
            
            self?.isLoading(false)
            
            if let gifs = gifs,
               error == nil {
                
                let gifs = gifs.data!.map({ x in
                    Gif(
                        gifUrl: x.images!.downsized!.url!,
                        title: x.title ?? "",
                        sourceUrl: x.source ?? "",
                        markedTrending: x.trending_datetime ?? "",
                        username: x.username ?? "")
                })
                
                DispatchQueue.main.async {
                    self?.gifs.append(contentsOf: gifs)
                }
                
            } else {
                // Log the error
                DispatchQueue.main.async {
                    self?.showAlert = true
                }
            }
            
        }
        
    }
    
    private func getTrendingGifs(onLoad: ((Gif) -> Void)? = nil) {
        
        self.currentSearch = .trending
        
        isLoading(true)
        
        self.giphyService.getTrendingGifs(limit: 1) { [weak self] (gifs, error) in
            
            self?.isLoading(false)
            
            if let gifs = gifs,
               error == nil {
                
                let gifs = gifs.data!.map({ x in
                    Gif(
                        gifUrl: x.images!.downsized!.url!,
                        title: x.title ?? "",
                        sourceUrl: x.source ?? "",
                        markedTrending: x.trending_datetime ?? "",
                        username: x.username ?? "")
                })
                
                DispatchQueue.main.async {
                    self?.gifs.append(contentsOf: gifs)
                    onLoad?(gifs.first!)
                }
                
            } else {
                // Log the error
                DispatchQueue.main.async {
                    self?.showAlert = true
                }
            }
        }
    }
        
    private func getRandomGif(onLoad: ((Gif) -> Void)? = nil) {
        
        self.currentSearch = .random
        
        isLoading(true)
        
        self.giphyService.getRandomGif() { [weak self] (gif, error) in
            
            self?.isLoading(false)
            
            if let gif = gif,
               error == nil {
                
                let randomGif = gif.data.map({ x in
                    Gif(
                        gifUrl: x.images!.downsized!.url!,
                        title: x.title ?? "",
                        sourceUrl: x.source ?? "",
                        markedTrending: x.trending_datetime ?? "",
                        username: x.username ?? "")
                })!
                
                DispatchQueue.main.async {
                    self?.gifs.append(randomGif)
                    onLoad?(randomGif)
                }
                
            } else {
                // Log the error
                DispatchQueue.main.async {
                    self?.showAlert = true
                }
            }
        }
    }
}

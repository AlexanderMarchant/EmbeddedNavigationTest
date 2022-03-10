//
//  Images.swift
//  testingEmbeddedNav
//
//  Created by Alex Marchant on 10/03/2022.
//

enum GiphySearch {
    case bySearchTerm
    case trending
}

protocol GiphyServiceProtocol {
    
    func resetTrendingSearch()
    
    func resetSearchByTermSearch()
    
    func getTrendingGifs(
        limit: Int,
        completion: @escaping (GifTrendModel?, Error?) -> Void)
    
    
    func getGifsBySearchTerm(
        search: String,
        limit: Int,
        completion: @escaping (GifSearchModel?, Error?) -> Void)
}

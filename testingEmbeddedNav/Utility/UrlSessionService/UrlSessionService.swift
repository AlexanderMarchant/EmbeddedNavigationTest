//
//  UrlSessionService.swift
//  testingEmbeddedNav
//
//  Created by Alex Marchant on 10/03/2022.
//

import Foundation

protocol UrlSessionServiceProtocol {
    func downloadImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
}

class UrlSessionService: UrlSessionServiceProtocol {
    
    init() {}
    
    func downloadImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}

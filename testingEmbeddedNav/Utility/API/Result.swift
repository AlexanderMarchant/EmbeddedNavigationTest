//
//  Result.swift
//  testingEmbeddedNav
//
//  Created by Alex Marchant on 10/03/2022.
//

import Foundation

struct CoreError: Error {
    var localizedDescription: String {
        return message
    }
    
    var message = "Something went wrong, please try again."
}

typealias Result<T> = Swift.Result<T, Error>

//
//  GifSearchModel.swift
//  testingEmbeddedNav
//
//  Created by Alex Marchant on 10/03/2022.
//

import Foundation

class GifSearchModel: Codable {
    var data: [DataModel]?
    var meta: MetaModel?
    var pagination: PaginationModel?
}

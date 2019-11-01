//
//  Entities.swift
//  TestAccedo
//
//  Created by MacBook Pro on 29/10/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation

struct DataComicResource: Decodable {
    let data: ComicResource
}

struct ComicResource: Decodable {
    let results: [Comic]
}

struct Comic: Decodable {
    let thumbnail: Thumbnail
}

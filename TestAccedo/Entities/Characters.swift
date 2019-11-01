//
//  Characters.swift
//  TestAccedo
//
//  Created by MacBook Pro on 31/10/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation

struct Characters: Decodable {
    let id: Int
    let name: String
    let thumbnail: Thumbnail
    let description: String
}

struct Thumbnail: Decodable {
    let path: String
    let imgExtension: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case imgExtension = "extension"
    }
}

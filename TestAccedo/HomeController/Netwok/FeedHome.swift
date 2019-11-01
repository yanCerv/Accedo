//
//  FeedHome.swift
//  TestAccedo
//
//  Created by MacBook Pro on 30/10/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation

enum FeedHome {
    case getCharacters
}

extension FeedHome: Endpoint {
    var base: String {
        switch self {
        case .getCharacters:
            return "http://gateway.marvel.com"
        }
    }
    
    var path: String {
        switch self {
        case .getCharacters:
            return "/v1/public/characters"
        }
    }
}

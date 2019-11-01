//
//  FeedDetail.swift
//  TestAccedo
//
//  Created by MacBook Pro on 31/10/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation

enum FeedDetail {
    case getDetails
}

extension FeedDetail: Endpoint {
    var base: String {
        switch self {
        case .getDetails:
            return "http://gateway.marvel.com"
        }
    }
    
    var path: String {
        switch self {
        case .getDetails:
            let id = UserDefaults.standard.object(forKey: "characterId") as? Int
            return "/v1/public/characters/\(id ?? 0)/comics"
        }
    }
}

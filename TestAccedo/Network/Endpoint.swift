//
//  Endpoint.swift
//  TestAccedo
//
//  Created by MacBook Pro on 30/10/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
}

extension Endpoint {
    var apiKey: URLQueryItem {
        return URLQueryItem(name: "apikey", value: ApiKeys.publicKey)
    }
    
    var hash: URLQueryItem {
        return URLQueryItem(name: "hash", value: Hashting.shared.setHash())
    }
    
    var limit: URLQueryItem {
        return URLQueryItem(name: "limit", value: "20")
    }
    
    var offset: URLQueryItem {
        return URLQueryItem(name: "offset", value: "100")
    }
    
    var ts: URLQueryItem {
        return URLQueryItem(name: "ts", value: ApiKeys.ts)
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = [ts, apiKey, hash, limit, offset]
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}

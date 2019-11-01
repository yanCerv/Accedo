//
//  NetworkHome.swift
//  TestAccedo
//
//  Created by MacBook Pro on 30/10/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation

class NetworkHomeController: ApiClient {
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getCharacter(feed: Feed, completion: @escaping (Result<DataResource?, ErrorHandler>) -> Void) {
        fetchData(request: feed.request, decode: { (json) -> DataResource? in
            guard let resources = json as? DataResource else { return nil }
            return resources
        }, completion: completion)
    }
}

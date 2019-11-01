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
    
    func getCharacter(feed: FeedHome, completion: @escaping (Result<DataCharacterResource?, ErrorHandler>) -> Void) {
        fetchData(request: feed.request, decode: { (json) -> DataCharacterResource? in
            guard let resources = json as? DataCharacterResource else { return nil }
            return resources
        }, completion: completion)
    }
}

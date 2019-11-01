//
//  NetworkDetail.swift
//  TestAccedo
//
//  Created by MacBook Pro on 31/10/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation

class NetworkDetail: ApiClient {
    var session: URLSession
    
    init(configuration: URLSessionConfiguration, id: String? = nil) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getDetails(feed: FeedDetail, completion: @escaping (Result<Resource<DataResources<Comic>>?, ErrorHandler>) -> Void) {
        fetchData(request: feed.request, decode: { (json) -> Resource<DataResources<Comic>>? in
            guard let resource = json as? Resource<DataResources<Comic>> else { return nil }
            return resource
        }, completion: completion)
    }
}

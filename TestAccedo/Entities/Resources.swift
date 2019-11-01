//
//  Resources.swift
//  TestAccedo
//
//  Created by MacBook Pro on 01/11/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation

struct Resource<T: Decodable>: Decodable {
    let data: T
}

struct DataResources<T: Decodable>: Decodable {
    let results: [T]
}

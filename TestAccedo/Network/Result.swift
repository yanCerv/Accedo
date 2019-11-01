//
//  Result.swift
//  TestAccedo
//
//  Created by MacBook Pro on 30/10/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation

 enum Result<T, E> where E: Error {
    case success(T)
    case error(E)
}

//
//  Hashting.swift
//  TestAccedo
//
//  Created by MacBook Pro on 29/10/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation
import CryptoKit

/// Encrip the string values.
///
///  - parameter: plus string values needed
///  - return: string in md5 key 

class Hashting {
    static var shared = Hashting()
    
    func toMd5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
    func setHash() -> String {
          let hash = Hashting.shared.toMd5(string: "\(ApiKeys.ts)\(ApiKeys.privateKey)\(ApiKeys.publicKey)")
          return hash
      }
}

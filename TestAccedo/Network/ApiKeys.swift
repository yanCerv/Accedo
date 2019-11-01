//
//  ApiKeys.swift
//  TestAccedo
//
//  Created by MacBook Pro on 29/10/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation
import UIKit

class ApiKeys {
    static var publicKey = "cb1c4b702d742584ab3e144af19f78c3"
    static var privateKey = "e01eafb23d07e04cf2061ca170f14d8370fba2fe"
    static var ts = "1"
    
    static var offSet: Int = 1
    
    static func getlimitByDevice() -> Int {
        if UIDevice.isIphone() {
            return 10
        } else if UIDevice.isIpad() {
            return 20
        }
        return 0
    }
}








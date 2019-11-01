//
//  DeviceCheck.swift
//  TestAccedo
//
//  Created by MacBook Pro on 31/10/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {
    static func isIpad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static func isIphone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    static func getFloatValue(phone: CGFloat, iPad: CGFloat) -> CGFloat {
        if UIDevice.isIphone() {
            return phone
        } else if UIDevice.isIpad() {
            return iPad
        }
        return 0
    }
}

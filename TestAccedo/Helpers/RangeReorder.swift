//
//  RangeReorder.swift
//  TestAccedo
//
//  Created by MacBook Pro on 31/10/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation

 extension Array {
   func filterDuplicate<T:Hashable>(_ keyValue:(Element)->T) -> [Element]
   {
      var uniqueKeys = Set<T>()
      return filter{uniqueKeys.insert(keyValue($0)).inserted}
   }

   func filterDuplicate<T>(_ keyValue:(Element)->T) -> [Element]
   {
      return filterDuplicate{"\(keyValue($0))"}
   }
}

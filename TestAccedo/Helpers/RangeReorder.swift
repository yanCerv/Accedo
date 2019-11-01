//
//  RangeReorder.swift
//  TestAccedo
//
//  Created by MacBook Pro on 31/10/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation

extension RangeReplaceableCollection where Element: Hashable {
    var orderedSet: Self {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
    mutating func removeDuplicates() {
        var set = Set<Element>()
        removeAll { !set.insert($0).inserted }
    }
}

extension Sequence {
    func distinct<T: Hashable>(by: (Element) -> T) -> [Element] {
        var seen: [T: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: by($0)) == nil }
    }
}

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

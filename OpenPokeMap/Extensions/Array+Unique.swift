//
//  Array+Unique.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 25/09/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    
    func arrayByAppendingContentsOf(elements: Array<Element>) -> Array<Element> {
        return self + elements
    }
    
    /// Returns only the unique elements out of an array
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            if !uniqueValues.contains(item) {
                uniqueValues += [item]
            }
        }
        return uniqueValues
    }
}

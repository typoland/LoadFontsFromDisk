//
//  Sequence  + Recurence.swift
//  FindFontFeatures
//
//  Created by Łukasz Dziedzic on 11/06/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation
//* Returns array from trees



public extension Sequence {
/**
Returns list from tree
     
- Parameter into: Type of array wich will be returned
- Parameter process: convert tree element to Array element. Colud be nil if type of tree element is ame as Array element.
- Parameter convert:
 */
    
    func recurence <T> (
        into: T,
        process: @escaping (_ index: Int, _ e:Element) -> Element = {_, e in return e},
        convert: @escaping (_ e: [Element]) -> T)
        -> Array<T> {
            
            var result = Array<T>()
            
            func deep (i: Int = 0, source :[Element] = []) {
                if i < self.underestimatedCount {
                    for element in self {
                        deep(
                            i: i + 1,
                            source: source + [process(i, element)]
                        )
                    }
                } else {
                    result.append( convert ( source ))
                }
            }
            deep ()
            return result
    }
}

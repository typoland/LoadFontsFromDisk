//
//  NSFont + initFromPath.swift
//  FindFontFeatures
//
//  Created by Łukasz Dziedzic on 11/06/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import AppKit

public extension NSFont {
    static func read(from path: String, size: CGFloat, matrix: UnsafePointer<CGAffineTransform>? = nil, desrcriptor:CTFontDescriptor? = nil) throws -> NSFont {
        guard let dataProvider = CGDataProvider(filename: path) else {
            throw NSError(domain: "file not found", code: 77, userInfo: ["fileName" : path])
        }
        guard let fontRef = CGFont ( dataProvider ) else {
            throw NSError(domain: "Not a font file", code: 77, userInfo: ["fileName" : path])
        }
        
        let font = CTFontCreateWithGraphicsFont(fontRef, size, matrix, desrcriptor) as NSFont
        print (font.fontDescriptor)
        return font
    }
}

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
    enum ReadFontError:Error {
        case fileNotFound (fileName:String)
        case notAFontFile(fileName:String)
    }
    
    static func read(from path: String, size: CGFloat, matrix: UnsafePointer<CGAffineTransform>? = nil, desrcriptor:CTFontDescriptor? = nil) throws -> NSFont {
        guard let dataProvider = CGDataProvider(filename: path) else {
            throw ReadFontError.fileNotFound(fileName: path)
        }
        guard let fontRef = CGFont ( dataProvider ) else {
            throw ReadFontError.notAFontFile(fileName: path)
        }
        return CTFontCreateWithGraphicsFont(fontRef, size, matrix, desrcriptor) as NSFont
    }
}

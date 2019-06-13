//
//  NSFont + initFromPath.swift
//  FindFontFeatures
//
//  Created by Łukasz Dziedzic on 11/06/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import AppKit
public extension CTFont {
    var familyName: CFString {
        print ("Taking CFont Family Name \(self)")
        //let fname = CTFontCopyFamilyName(self)
        //print ("Fname [\(fname)]")
        return CTFontCopyFamilyName(self)
    }
}

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
        let font = CTFontCreateWithGraphicsFont(fontRef, size, matrix, desrcriptor)
        
        //Some fonts explode here. Poynter explodes.
        print ("Family name: \(font.familyName)")
        return font as NSFont
    }
}


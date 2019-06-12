//
//  FilesInFolders.swift
//  LoadFontsFromDisk
//
//  Created by Łukasz Dziedzic on 12/06/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation

class FilesTree: TreeProtocol {
    typealias Branch = FilesTree
    typealias Leaf  = [URL]
    var branch: [Branch] = []
    var leaf: Leaf = []
    
    
    init (urls: [URL]) throws {
        
        var isDirectory: ObjCBool = ObjCBool(false)
        let fileManager = FileManager.default
        for url in urls {
            if fileManager.fileExists(atPath: url.path, isDirectory: &isDirectory),
                let fileNames = try? fileManager.contentsOfDirectory(atPath: url.path) {
                let urls = fileNames.map {URL(fileURLWithPath: url.path+"/"+$0)}
                if let ff = try? FilesTree(urls: urls) {
                    branch.append(ff)
                }
            } else {
                leaf.append(url)
            }
        }
    }
}

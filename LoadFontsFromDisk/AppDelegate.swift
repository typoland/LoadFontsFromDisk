//
//  AppDelegate.swift
//  LoadFontsFromDisk
//
//  Created by Łukasz Dziedzic on 12/06/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var fontsController: NSArrayController!

    @objc var fonts: [NSFont] = []
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func loadSystemFonts(_ sender: Any) {
        willChangeValue(for: \AppDelegate.fonts)
        let fontNames = NSFontManager.shared.availableFonts
        for fontName in fontNames {
            if let font = NSFont(name: fontName, size: 16) {
                fonts.append(font)
            }
        }
        didChangeValue(for: \AppDelegate.fonts)
    }
    
    @objc func openDocument(_ sender:Any) {
        
        fonts = []
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = true
        openPanel.canChooseDirectories = true
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.begin { (result) -> Void in
            
            if result == NSApplication.ModalResponse.OK {
                //var fonts: [NSFont] = []
                
                for url in openPanel.urls {
                    
                    var isDirectory: ObjCBool = ObjCBool(false)
                    
                    let fileManager = FileManager.default
                    self.willChangeValue(for: \AppDelegate.fonts)
                    if fileManager.fileExists(atPath: url.path, isDirectory: &isDirectory) {
                        //do {
                            if let fileNames = try? fileManager.contentsOfDirectory(atPath: url.path) {
                                for fileName in fileNames {
                                    let filePath = url.path + "/" + fileName
                                    if let font = try? NSFont.read(from: filePath, size: 12) {
                                        //print ("append \(font)")
                                        self.fonts.append(font)
                                        
                                    }
                                }
                            } else {
                                if let font = try? NSFont.read(from: url.path, size: 12) {
                                    //print ("one font but explodes immediately, even on print()")
                                    self.fonts.append(font)
                                }
                            
                        //}
                        
                    }
                    }
                    self.didChangeValue(for: \AppDelegate.fonts)
                }
                
            }
        }
        
        
        
    }

}


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
    @objc var fontSize: CGFloat = 20
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
            if let font = NSFont(name: fontName, size: fontSize) {
                fonts.append(font)
            }
        }
        didChangeValue(for: \AppDelegate.fonts)
    }
    
    @IBAction func changeSize(_ sender: NSControl) {
        willChangeValue(for: \AppDelegate.fontSize)
        fontSize = CGFloat(sender.floatValue)
        print (fontSize)
        didChangeValue(for: \AppDelegate.fontSize)
        
    }
    @objc func openDocument(_ sender:Any) {
        
        fonts = []
        
//        let fileNames = ["/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-Thin.otf",
//                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-LightSemiCondensed.ttf",
//                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-Light.otf",
////                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-LightSemiCondensed.otf",
////                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-ThinSemiCondensed.ttf",
////                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-RegularCondensed.otf",
////                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-BlackCondensed.ttf",
////                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-BlackSemiCondensed.ttf",
////                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-BlackNarrow.otf",
////                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-LightNarrow.ttf",
////                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-RegSemiCond.ttf",
////                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-ThinCondensed.ttf",
////                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-LightCondensed.ttf",
////                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-ThinNarrow.otf",
////                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-RegularNarrow.ttf",
////                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-BlackSemiCondensed.otf",
////                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-Black.otf",
////                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-ThinCondensed.otf",
////                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-RegSemiCond.otf",
////                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-BlackNarrow.ttf",
////                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-LightNarrow.otf",
////                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-ThinNarrow.ttf",
////                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-LightCondensed.otf",
////                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-RegularNarrow.otf",
////                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-ThinSemiCondensed.otf",
////                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-BlackCondensed.otf",
////                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-RegularCondensed.ttf",
////                        "/Users/lukasz/Library/Fonts/Lato Condensed/LatoExtra-Regular.otf"
//        ]
//
//        willChangeValue(for: \AppDelegate.fonts)
//        for fileName in fileNames {
//            //let filePath = url.path + "/" + fileName
//            if let font = try? NSFont.read(from: fileName, size: 20) {
//                self.fonts.append(font)
//
//            }
//        }
//        didChangeValue(for: \AppDelegate.fonts)
        
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
                                    if let font = try? NSFont.read(from: filePath, size: self.fontSize) {
                                        print ("\(filePath)")
                                        self.fonts.append(font)
                                        
                                    }
                                }
                            } else {
                                if let font = try? NSFont.read(from: url.path, size: self.fontSize) {
                                    print ("\(url.path)")
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


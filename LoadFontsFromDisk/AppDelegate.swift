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
    @objc var fontSize: CGFloat = 50
    
    @objc var something: NSFont? = nil
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        fontsController.addObserver(self, forKeyPath: "selection", options: [.old, .new], context: nil)
        // Insert code here to initialize your application
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        willChangeValue(for: \AppDelegate.something)
        print ("bbserve")
        didChangeValue(for: \AppDelegate.something)
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
        didChangeValue(for: \AppDelegate.fontSize)
    }
    
    @IBAction func setFontNameFilter(_ sender:NSTextField) {
        fontsController.willChangeValue(for: \NSArrayController.filterPredicate)
        willChangeValue(for: \AppDelegate.something)
        
        if sender.stringValue.isEmpty {
            fontsController.filterPredicate = nil
        } else {
            let predicate = NSPredicate(format: "familyName CONTAINS [c] \"\(sender.stringValue)\"")
            fontsController.filterPredicate = predicate
        }
        
        fontsController.didChangeValue(for: \NSArrayController.filterPredicate)
        didChangeValue(for: \AppDelegate.something)
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
                self.willChangeValue(for: \AppDelegate.fonts)
                if let fontsPaths = try? FilesTree(
                    paths: openPanel.urls.map{$0.path}).leafs.flatMap({$0}) {

                    fontsPaths.forEach { path in
                        if let font = try? NSFont.read(from: path, size: self.fontSize) {
                            self.fonts.append(font)
                        }
                    }
                }
                self.didChangeValue(for: \AppDelegate.fonts)
            }
        }
    }
    
}


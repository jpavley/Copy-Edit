//
//  AppDelegate.swift
//  Copy Edit
//
//  Created by John Pavley on 11/26/16.
//  Copyright © 2016 John Pavley. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var copyEditStatusItem: NSStatusItem?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        copyEditStatusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
        copyEditStatusItem?.title = "✂️"
        
        let copyEditMenu = NSMenu()
        
        copyEditMenu.addItem(NSMenuItem(title: "Plain Text", action: #selector(AppDelegate.plainText), keyEquivalent: ""))
        copyEditMenu.addItem(NSMenuItem.separator())
        copyEditMenu.addItem(NSMenuItem(title: "Markdown Paragraph", action: #selector(AppDelegate.plainText), keyEquivalent: ""))
        copyEditMenu.addItem(NSMenuItem(title: "Markdown Link", action: #selector(AppDelegate.plainText), keyEquivalent: ""))
        copyEditMenu.addItem(NSMenuItem.separator())
        copyEditMenu.addItem(NSMenuItem(title: "HTML Paragraph", action: #selector(AppDelegate.plainText), keyEquivalent: ""))
        copyEditMenu.addItem(NSMenuItem(title: "HTML Link", action: #selector(AppDelegate.plainText), keyEquivalent: ""))
        copyEditMenu.addItem(NSMenuItem(title: "HTML Escaped", action: #selector(AppDelegate.plainText), keyEquivalent: ""))
        
        copyEditStatusItem?.menu = copyEditMenu
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func getPlainText() -> String? {
        if let items = NSPasteboard.general().pasteboardItems {
            for item in items {
                for type in item.types {
                    if type == "public.utf8-plain-text" {
                        if let userText = item.string(forType: type) {
                            return userText
                        }
                    }
                }
            }
        }
        return nil
    }
    
    /// Removes all expressions of the text on the Pasteboard except for the plain text version.
    /// Trims whitespace and new line characters before and after the text.
    func plainText() {
        if let userText = getPlainText() {
            NSPasteboard.general().clearContents()
            
            let trimnedString = userText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
            NSPasteboard.general().setString(trimnedString, forType: "public.html")
            NSPasteboard.general().setString(trimnedString, forType: "public.utf8-plain-text")
        }
    }
    
    func markdownText() {
        
    }
    
    func markdownLink() {
        
    }
    
    func htmlText() {
        
    }
    
    func htmlLink() {
    
    }
    
    func htmlEscaped() {
        
    }
    
    func quit() {
        
    }


}


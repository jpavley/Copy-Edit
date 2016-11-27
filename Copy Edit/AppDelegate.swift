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
    var rootController: ViewController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        copyEditStatusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
        copyEditStatusItem?.title = "✂️"
        
        let copyEditMenu = NSMenu()
        
        copyEditMenu.addItem(NSMenuItem(title: "Current Pasteboard", action: #selector(AppDelegate.current), keyEquivalent: ""))
        copyEditMenu.addItem(NSMenuItem.separator())
        copyEditMenu.addItem(NSMenuItem(title: "Plain Text", action: #selector(AppDelegate.plainText), keyEquivalent: ""))
        copyEditMenu.addItem(NSMenuItem.separator())
        copyEditMenu.addItem(NSMenuItem(title: "Markdown Text", action: #selector(AppDelegate.markdownText), keyEquivalent: ""))
        copyEditMenu.addItem(NSMenuItem(title: "Markdown Link", action: #selector(AppDelegate.markdownLink), keyEquivalent: ""))
        copyEditMenu.addItem(NSMenuItem.separator())
        copyEditMenu.addItem(NSMenuItem(title: "HTML Text", action: #selector(AppDelegate.htmlText), keyEquivalent: ""))
        copyEditMenu.addItem(NSMenuItem(title: "HTML Link", action: #selector(AppDelegate.htmlLink), keyEquivalent: ""))
        copyEditMenu.addItem(NSMenuItem(title: "HTML Escaped", action: #selector(AppDelegate.htmlEscaped), keyEquivalent: ""))
        
        copyEditStatusItem?.menu = copyEditMenu
        
    }
    
    func applicationWillUpdate(_ notification: Notification) {
        // Only set the root controller if it isn't set already
        if rootController == nil {
            rootController = NSApplication.shared().mainWindow?.windowController?.contentViewController as? ViewController
        }
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
    
    /// Logs what is currently on Pasteboard.
    func current() {
        if let rootViewController = rootController {
            rootViewController.logger.textStorage?.mutableString.setString(logPasteboard())
        }
    }
    
    /// Removes all expressions of the text on the Pasteboard except for the plain text version.
    /// Trims whitespace and new line characters before and after the text.
    /// Logs the results.
    func plainText() {
        if let userText = getPlainText() {
            NSPasteboard.general().clearContents()
            
            let trimnedString = userText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
            // NSPasteboard.general().setString(trimnedString, forType: "public.html")
            NSPasteboard.general().setString(trimnedString, forType: "public.utf8-plain-text")
            
            if let rootViewController = rootController {
                rootViewController.logger.textStorage?.mutableString.setString(logPasteboard())
            }
        
        }
        
    }
    
    func markdownText() {
        
    }
    
    func markdownLink() {
        
    }
    
    func htmlText() {
        
    }
    
    func htmlLink() {
        
        if let userText = getPlainText() {
            
            if let _ = NSURL(string: userText) {
                NSPasteboard.general().clearContents()

                var finalURL = ""
                
                if userText.hasPrefix("http://") || userText.hasPrefix("https://") {
                    finalURL = userText
                } else {
                    finalURL = "http://\(userText)"
                }
                
                NSPasteboard.general().setString("<a href=\"\(finalURL)\">\(userText)</a>", forType: "public.html")
                NSPasteboard.general().setString(finalURL, forType: "public.utf8-plain-text")
                
                if let rootViewController = rootController {
                    rootViewController.logger.textStorage?.mutableString.setString(logPasteboard())
                }
            }
        }
    }
    
    func htmlEscaped() {
        
    }
    
    func quit() {
        NSApplication.shared().terminate(self)
    }


}


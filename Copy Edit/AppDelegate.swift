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
        copyEditMenu.addItem(NSMenuItem(title: "Markdown Text", action: #selector(AppDelegate.plainText), keyEquivalent: ""))
        copyEditMenu.addItem(NSMenuItem(title: "Markdown Link", action: #selector(AppDelegate.plainText), keyEquivalent: ""))
        copyEditMenu.addItem(NSMenuItem.separator())
        copyEditMenu.addItem(NSMenuItem(title: "HTML Text", action: #selector(AppDelegate.plainText), keyEquivalent: ""))
        copyEditMenu.addItem(NSMenuItem(title: "HTML Link", action: #selector(AppDelegate.plainText), keyEquivalent: ""))
        copyEditMenu.addItem(NSMenuItem(title: "HTML Escaped", action: #selector(AppDelegate.plainText), keyEquivalent: ""))
        
        copyEditStatusItem?.menu = copyEditMenu
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func plainText() {
        
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


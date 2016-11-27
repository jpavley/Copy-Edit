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
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}


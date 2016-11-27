//
//  SharedFunctions.swift
//  Copy Edit
//
//  Created by John Pavley on 11/27/16.
//  Copyright © 2016 John Pavley. All rights reserved.
//

import Cocoa

func logPasteboard() -> String {
    var results = ""
    if let items = NSPasteboard.general().pasteboardItems {
        results.append("Pasteboard \(NSDate())\n")
        results.append("\n")
        
        for item in items {
            for type in item.types {
                
                results.append("\(type)\n")
                
                if let str = item.string(forType: type) {
                    results.append("\(str)\n")
                } else {
                    results.append("value missing\n")
                }
                
                results.append("\n")
            }
        }
    }
    return results
}


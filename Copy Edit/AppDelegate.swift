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
    
    // Regex patterns source: https://regex101.com
    let markdownLinkPattern = "(\\[(.*?)\\])(\\((.*?)\\))"
    let htmlLinkPattern = "(^|\\s)((https?:\\/\\/)?[\\w-]+(\\.[a-z-]+)+\\.?(:\\d+)?(\\/\\S*)?)"
    let parenthesesPattern = "\\((.*?)\\)"

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        // TODO: Set minimum size of frame to 440 x 270
        
        copyEditStatusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
        copyEditStatusItem?.title = "✂️"
        
        let copyEditMenu = NSMenu()
        
        copyEditMenu.addItem(NSMenuItem(title: "Current Pasteboard", action: #selector(AppDelegate.current), keyEquivalent: ""))
        copyEditMenu.addItem(NSMenuItem.separator())
        copyEditMenu.addItem(NSMenuItem(title: "Plain Text", action: #selector(AppDelegate.plainText), keyEquivalent: ""))
//        copyEditMenu.addItem(NSMenuItem.separator())
//        copyEditMenu.addItem(NSMenuItem(title: "Markdown Text", action: #selector(AppDelegate.markdownText), keyEquivalent: ""))
        copyEditMenu.addItem(NSMenuItem(title: "Markdown Link", action: #selector(AppDelegate.markdownLink), keyEquivalent: ""))
//        copyEditMenu.addItem(NSMenuItem.separator())
//        copyEditMenu.addItem(NSMenuItem(title: "HTML Text", action: #selector(AppDelegate.htmlText), keyEquivalent: ""))
        copyEditMenu.addItem(NSMenuItem(title: "HTML Link", action: #selector(AppDelegate.htmlLink), keyEquivalent: ""))
        copyEditMenu.addItem(NSMenuItem(title: "Remove Param", action: #selector(AppDelegate.removeParam), keyEquivalent: ""))
//        copyEditMenu.addItem(NSMenuItem(title: "HTML Escaped", action: #selector(AppDelegate.htmlEscaped), keyEquivalent: ""))
        copyEditMenu.addItem(NSMenuItem.separator())
        copyEditMenu.addItem(NSMenuItem(title: "Quit", action: #selector(AppDelegate.quit), keyEquivalent: ""))

        
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
    
    /// Returns utf8 plain text item on Pasteboard.
    /// Trims off leading and training whitespace and new lines.
    func getPlainText() -> String? {
        if let items = NSPasteboard.general().pasteboardItems {
            for item in items {
                for type in item.types {
                    if type == "public.utf8-plain-text" {
                        if let userText = item.string(forType: type) {
                            let trimnedString = userText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                            return trimnedString
                        }
                    }
                }
            }
        }
        return nil
    }
    
    /// Returns true if the input string matches a regular expression.
    func validateURLString(urlString: String, pattern: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let matches = regex.matches(in: urlString, options: [], range: NSRange(location: 0, length: urlString.characters.count))
        
        if matches.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    /// Returns array of strings that match a regular expression pattern.
    /// Source: http://stackoverflow.com/questions/27880650/swift-extract-regex-matches
    func regexMatches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = text as NSString
            let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
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
            NSPasteboard.general().setString(userText, forType: "public.utf8-plain-text")
            
            if let rootViewController = rootController {
                rootViewController.logger.textStorage?.mutableString.setString(logPasteboard())
            }
        
        }
        
    }
    
    func markdownText() {
        
    }
    
    func markdownLink() {
        // [an example](http://example.com/)
        
        if let userText = getPlainText() {
            
            // NOTE: NSURL thinks that cat.com(cat.com) is a valid URL so I validate with a regular expression first
            
            if !validateURLString(urlString: userText, pattern: htmlLinkPattern) {
                return
            }
            
            if let _ = NSURL(string: userText) {
                NSPasteboard.general().clearContents()
                
                var finalURL = ""
                
                if userText.hasPrefix("http://") || userText.hasPrefix("https://") {
                    finalURL = userText
                } else {
                    finalURL = "http://\(userText)"
                }
                
                NSPasteboard.general().setString("[\(userText)](\(finalURL))", forType: "public.utf8-plain-text")
                
                if let rootViewController = rootController {
                    rootViewController.logger.textStorage?.mutableString.setString(logPasteboard())
                }
            }
        }
        
        
    }
    
    func htmlText() {
    }
    
    func htmlLink() {
        // <a href="http://example.com/">example.com</a>
        
        if let userText = getPlainText() {
            
            var candidateURL = ""
            
            // NOTE: if the userText is a valid Markdown link extract the link so it can be converted to an HTML link
            
            if validateURLString(urlString: userText, pattern: markdownLinkPattern) {
                let matches = regexMatches(for: parenthesesPattern, in: userText)
                if matches.count > 0 {
                    let matchedURL = matches[0]
                    candidateURL = matchedURL.trimmingCharacters(in: CharacterSet.punctuationCharacters)
                    // print(candidateURL)
                }
            }
            
            if candidateURL.characters.count == 0 {
                candidateURL = userText
            }
            
            // NOTE: NSURL thinks that cat.com(cat.com) is a valid URL so I validate with a regular expression first
            
            if !validateURLString(urlString: candidateURL, pattern: htmlLinkPattern) {
                return
            }
            
            if let _ = NSURL(string: candidateURL) {
                
                NSPasteboard.general().clearContents()

                var finalURL = ""
                
                if candidateURL.hasPrefix("http://") || candidateURL.hasPrefix("https://") {
                    finalURL = candidateURL
                } else {
                    finalURL = "http://\(candidateURL)"
                }
                
                NSPasteboard.general().setString("<a href=\"\(finalURL)\">\(candidateURL)</a>", forType: "public.html")
                NSPasteboard.general().setString(finalURL, forType: "public.utf8-plain-text")
                
                if let rootViewController = rootController {
                    rootViewController.logger.textStorage?.mutableString.setString(logPasteboard())
                }
            }
        }
    }
    
    func removeParam() {
        // <a href="http://example.com/">example.com</a>
        
        if let userText = getPlainText() {
            
            var candidateURL = ""
            
            // NOTE: if the userText is a valid Markdown link extract the link so it can be converted to an HTML link
            
            if validateURLString(urlString: userText, pattern: markdownLinkPattern) {
                let matches = regexMatches(for: parenthesesPattern, in: userText)
                if matches.count > 0 {
                    let matchedURL = matches[0]
                    candidateURL = matchedURL.trimmingCharacters(in: CharacterSet.punctuationCharacters)
                    // print(candidateURL)
                }
            }
            
            if candidateURL.characters.count == 0 {
                candidateURL = userText
            }
            
            // NOTE: NSURL thinks that cat.com(cat.com) is a valid URL so I validate with a regular expression first
            
            if !validateURLString(urlString: candidateURL, pattern: htmlLinkPattern) {
                return
            }
            
            if let _ = NSURL(string: candidateURL) {
                
                
                var finalURL = ""
                
                if candidateURL.hasPrefix("http://") || candidateURL.hasPrefix("https://") {
                    finalURL = candidateURL
                } else {
                    finalURL = "http://\(candidateURL)"
                }
                
                var urlComponents = finalURL.components(separatedBy: "?")
                
                if urlComponents.count > 1 {
                    NSPasteboard.general().clearContents()
                    let cleanURL = urlComponents[0]
                    NSPasteboard.general().setString("<a href=\"\(cleanURL)\">\(cleanURL)</a>", forType: "public.html")
                    NSPasteboard.general().setString(cleanURL, forType: "public.utf8-plain-text")
                    
                    if let rootViewController = rootController {
                        rootViewController.logger.textStorage?.mutableString.setString(logPasteboard())
                    }
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


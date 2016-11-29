# Copy Edit
A macOS Pasteboard Utility

## Overview
Copy Edit is a macOS app that solves problem with the Mac clipboard. Sometimes some apps have trouble with have 
rich text on the clipboard. Sometimes you want the plain text and not the rich text but not every app has a 
"paste values only" option. Some apps give you a "paste and match style" option which might lead to unexpected 
results with formatted text. Copy Edit give you a little menu in the status area of the Mac menubar. It works 
with any app--Copy Edit doesn't have to be the front-most app. Copy Edit lets you view the data on the
pasteboard (which is what the macOS calls the clipboard). Copy edit lets you convert that data to a "plain
text" representation. If the data is a URL Copy Edit lets you format that URL as a clickable Markdown or HTML
link.

## Commands
- Current Pasteboard: view the current data on the clipboard
- Plain Text: tranforms rich text data on the clipboard to plain text data
- Markdown Link: transforms a plain text URL or HTML formated link to a Markdown link
- HTML Link: transforms a plain text URL or Markdown formated link to an HTML link
- Quit: Terminates the app

## Impletementation details
- Written in Swift 3
- Only runs on macOS, only tested with macOS Sierra 10.12.2 Beta
- Uses regular expressions to validate URLs and links
- App doesn't have a regular menu bar or dock icon of it's own

## Installation Notes
- Download compile in Xcode 8
- A precompiled version of the can be found in the Copy Edit/Copy Edit 2016-11-28 23-47-45 directory
- To run the precompiled app you'll have to override your Mac's security settings--which you should never do!

## Thanks Yous
- https://regex101.com
- http://stackoverflow.com/questions/27880650/swift-extract-regex-matches
- https://daringfireball.net/projects/markdown/syntax


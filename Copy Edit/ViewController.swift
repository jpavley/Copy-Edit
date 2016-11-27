//
//  ViewController.swift
//  Copy Edit
//
//  Created by John Pavley on 11/26/16.
//  Copyright © 2016 John Pavley. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var logger: NSTextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        logger.isEditable = false
        
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}


//
//  Model.swift
//  CastiMenu
//
//  Created by Emily2 on 5/8/15.
//  Copyright (c) 2015 Emily L. All rights reserved.
//

import Foundation

// protocol => how you do things
// model is defining for the VC how it wants the VC to handle situations when the data has changed
// will allow the model and the ViewController to communicate
// modelDataChanged() will tell the view to update itself

class Singleton {
    
    var entreeString = "no"
    var grillString = "no"
    var soupString = "no"
    var dessertString = "no"
    
    class var sharedInstance: Singleton {
        struct Static {
            static var instance: Singleton?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = Singleton()
        }
        
        return Static.instance!
    }
}
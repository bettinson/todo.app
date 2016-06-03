//
//  Todo.swift
//  Todo
//
//  Created by Matt Bettinson on 2016-06-03.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//

import Foundation

class Todo : NSObject, NSCoding {
    var name : String
    var done : Bool
    
    init(name: String) {
        self.name = name
        self.done = false
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String
        done = aDecoder.decodeObjectForKey("done") as! Bool
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(done, forKey: "done")
    }
}
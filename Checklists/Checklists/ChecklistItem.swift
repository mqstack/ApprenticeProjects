//
//  ChecklistItem.swift
//  Checklists
//
//  Created by michael qian on 2017/3/3.
//  Copyright © 2017年 mqstack. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, NSCoding{
    var text = ""
    var checked = false
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        text = aDecoder.decodeObject(forKey: "Text") as! String
        checked = aDecoder.decodeBool(forKey: "Checked")
        super.init()
    }
    
    func toggleChecked(){
        checked = !checked
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(checked, forKey: "Checked")
    }
}

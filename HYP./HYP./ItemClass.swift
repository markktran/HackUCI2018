//
//  ItemClass.swift
//  HYP.
//
//  Created by Mark Tran on 2/3/18.
//  Copyright © 2018 Mark Tran. All rights reserved.
//

import Foundation

class Item {
    var id: Int
    var name: String
    var type: String
    var desc: String
    var price: Int
    
    init(id: Int, name: String, type: String, desc: String, price: Int) {
        self.id = id
        self.name = name
        self.type = type
        self.desc = desc
        self.price = price
    }
}

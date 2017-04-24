//
//  UpdateItem.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 24/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

class UpdateItem {
    // defines a data model for a stock update time, useful in stock fluctuation record
    
    var time: String
    var current: Int
    
    // initializer
    init(time: String, current: Int) {
        self.time = time
        self.current = current
    }
}

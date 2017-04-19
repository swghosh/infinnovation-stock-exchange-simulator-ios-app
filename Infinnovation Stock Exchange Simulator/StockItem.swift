//
//  StockItem.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 31/03/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

class StockItem {
    
    // defines a data model for a stock item
    
    var name: String
    var current: Int
    var difference: Int
    var percentage: Double
    var gain: Bool
    var sector: String
    var profile: String? // the profile of the stock is optional
    
    // initializer, initializes without defining the profile
    init(name: String, current: Int, difference: Int, percentage: Double, sector: String) {
        self.name = name
        self.current = current
        self.difference = difference
        self.percentage = percentage
        self.sector = sector
        
        // manipulates the stock item accordingly based on the difference and percentage being positive or negative
        // negative difference and negative percentage implies gain
        // positive difference and positive percentage implies loss / !gain
        if(difference < 0) {
            self.difference = 0 - self.difference
            self.percentage = 0 - self.percentage
            self.gain = true
        }
        else {
            self.gain = false
        }
        
    }
    
    // alternative initializer to define the profile as well
     convenience init(name: String, current: Int, difference: Int, percentage: Double, sector: String, profile: String) {
        self.init(name: name, current: current, difference: difference, percentage: percentage, sector: sector)
        self.profile = profile
    }
    
}

//
//  StockItem.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 31/03/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

class StockItem {
    
    var name: String
    var current: Int
    var difference: Int
    var percentage: Double
    var gain: Bool
    var sector: String
    var profile: String?
    
    init(name: String, current: Int, difference: Int, percentage: Double, sector: String) {
        self.name = name
        self.current = current
        self.difference = difference
        self.percentage = percentage
        self.sector = sector
        
        if(difference < 0) {
            self.difference = 0 - self.difference
            self.percentage = 0 - self.percentage
            self.gain = true
        }
        else {
            self.gain = false
        }
        
    }
    
     convenience init(name: String, current: Int, difference: Int, percentage: Double, sector: String, profile: String) {
        self.init(name: name, current: current, difference: difference, percentage: percentage, sector: sector)
        self.profile = profile
    }
    
}

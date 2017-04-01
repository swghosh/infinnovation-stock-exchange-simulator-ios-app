//
//  StockDataModel.swift
//  InfiSES
//
//  Created by SwG Ghosh on 31/03/17.
//  Copyright © 2017 codecrafts. All rights reserved.
//

class Stock {
    
    var name: String
    var current: Int
    var difference: Int
    var percentage: Double
    var gain: Bool
    var sector: String
    
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
    
}

//
//  FullStockItem.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 03/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

class FullStockItem: StockItem {
    
    // defines a data model for a stock item holds the full details of the stock
    // inherits capabailities of StockItem
    
    var pclose: Int
    var ovalue: Int
    var lcircuit: Int
    var ucircuit: Int
    var dividend: Int
    var bvalue: Int
    
    // initializer
    init(name: String, current: Int, difference: Int, percentage: Double, sector: String, profile: String, pclose: Int, ovalue: Int, lcircuit: Int, ucircuit: Int, dividend: Int, bvalue: Int) {
        self.pclose = pclose
        self.ovalue = ovalue
        self.lcircuit = lcircuit
        self.ucircuit = ucircuit
        self.dividend = dividend
        self.bvalue = bvalue
        super.init(name: name, current: current, difference: difference, percentage: percentage, sector: sector)
        self.profile = profile
    }
}

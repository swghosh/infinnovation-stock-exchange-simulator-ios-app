//
//  FullStockAPICall.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 17/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import Foundation

class FullStockAPICall {
    var url: URL?
    var stock: StockItem
    
    init(urlString:String, apiKey: String, stock: StockItem) {
        self.url = URL(string: "\(urlString)?key=\(apiKey)&name=\(stock.name)")
        self.stock = stock
    }
    
    var fullStock: FullStockItem?
    var time: String?
    
    func getFullStock(jsonData: Data) -> FullStockItem {
        do {
            let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions()) as? [String: Any]
            let result = json!["result"] as! [String: Any]
            time = json!["time"] as? String
            
            let name = result["name"] as! String
            let current = result["current"] as! Int
            let difference = result["difference"] as! Int
            let percentage = result["percentage"] as! Double
            let sector = result["sector"] as! String
            let profile = result["profile"] as! String
            let pclose = result["pclose"] as! Int
            let ovalue = result["ovalue"] as! Int
            let lcircuit = result["lcircuit"] as! Int
            let ucircuit = result["ucircuit"] as! Int
            let dividend = result["dividend"] as! Int
            let bvalue = result["bvalue"] as! Int
            
            
            fullStock = FullStockItem(name: name, current: current, difference: difference, percentage: percentage, sector: sector, profile: profile, pclose: pclose, ovalue: ovalue, lcircuit: lcircuit, ucircuit: ucircuit, dividend: dividend, bvalue: bvalue)
            
        }
        catch {
            print(error)
        }
        return fullStock!
    }
}

//
//  FullStockAPICall.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 17/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import Foundation

class FullStockAPICall: APICall {
    
    // the StockItem whose corresponding FullStockItem is to be fetched
    var stock: StockItem
    
    // initializer
    init(urlString:String, apiKey: String, stock: StockItem) {
        self.stock = stock
        super.init(urlString: urlString, apiKey: apiKey)
        
        // url escaping for white spaces
        let name = stock.name.replacingOccurrences(of: " ", with: "%20")
        self.url = URL(string: "\(urlString)?key=\(apiKey)&name=\(name)")
    }
    
    // a FullStockItem that will be JSON serialized/ casted from the JSON
    var fullStock: FullStockItem?
    
    func getFullStock() -> FullStockItem {
        do {
            // JSON Serialization is attempted on the received data
            let json = try JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions()) as? [String: Any]
            // type casting
            let result = json!["result"] as! [String: Any]
            
            // the date, time when the data was fetched from the API is also stored as a String
            time = json!["time"] as? String
            
            // casting all data to be finally produce a FullStockItem
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
        // the FullStockItem is returned
        return fullStock!
    }
}

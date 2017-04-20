//
//  StocksProfileListAPICall.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 16/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import Foundation

class StocksProfileListAPICall: APICall {
    
    // overriden initializer
    override init(urlString:String, apiKey: String) {
        super.init(urlString: urlString, apiKey: apiKey)
        self.url = URL(string: "\(urlString)?key=\(apiKey)&profile")
    }
    
    // an array of StockItem(s) that will be JSON serialised/casted from the JSON
    var stocks: [StockItem]?
    
    func getStocksList() -> [StockItem] {
        stocks = [StockItem]()
        do {
            // JSON Serialization is attempted on the received data
            let json = try JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions()) as? [String: Any]
            // type casting
            let list = json!["result"] as! [[String: Any]]
            
            // the date, time when the data was fetched from the API is also stored as a String
            time = json!["time"] as? String
            
            // casting all data to be finally produce a complete StockItem array
            for item in list {
                let name = item["name"] as! String
                let sector = item["sector"] as! String
                let current = item["current"] as! Int
                let difference = item["difference"] as! Int
                let percentage = item["percentage"] as! Double
                let profile = item["profile"] as! String
                
                let stock: StockItem = StockItem(name: name, current: current, difference: difference, percentage: percentage, sector: sector, profile: profile)
                stocks!.append(stock)
            }
        }
        catch {
            print(error)
        }
        // the StockItem array is returned
        return stocks!
    }
}

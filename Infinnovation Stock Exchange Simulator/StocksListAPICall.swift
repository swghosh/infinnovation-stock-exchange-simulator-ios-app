//
//  StocksListAPICall.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 16/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import Foundation

class StocksListAPICall {
    
    var url: URL?
    var jsonData: Data?
    
    init(urlString:String, apiKey: String) {
        self.url = URL(string: "\(urlString)?key=\(apiKey)")
    }
    
    var stocks: [StockItem]?
    var time: String?
    
    func performApiCall() -> Data? {
        
        let request = URLRequest(url: url!)
        let sharedSession = URLSession.shared
        
        var finished = false
        
        let task = sharedSession.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            self.jsonData = data
            
            finished = true
            
        })
        task.resume()
        
        while(!finished) {
            // blocks the code till async task completion handler finishes
        }
        
        return jsonData
    }
    
    func getStocksList() -> [StockItem] {
        stocks = [StockItem]()
        do {
            let json = try JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions()) as? [String: Any]
            let list = json!["result"] as! [[String: Any]]
            time = json!["time"] as? String
            
            for item in list {
                let name = item["name"] as! String
                let sector = item["sector"] as! String
                let current = item["current"] as! Int
                let difference = item["difference"] as! Int
                let percentage = item["percentage"] as! Double
                
                let stock: StockItem = StockItem(name: name, current: current, difference: difference, percentage: percentage, sector: sector)
                stocks!.append(stock)
            }
        }
        catch {
            print(error)
        }
        return stocks!
    }
    
    
}

//
//  UpdatesListAPICall.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 24/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import  Foundation

class UpdatesListAPICall: APICall {
    
    // the StockItem whose corresponding UpdateItem(s) list is to be fetched
    var stock: StockItem
    
    // initializer
    init(urlString: String, apiKey: String, stock: StockItem) {
        self.stock = stock
        super.init(urlString: urlString, apiKey: apiKey)
        
        // url escaping for white spaces
        let name = stock.name.replacingOccurrences(of: " ", with: "%20")
        self.url = URL(string: "\(urlString)?key=\(apiKey)&name=\(name)")
    }
    
    // an array of UpdateItem(s) that will be JSON serialised/casted from the JSON
    var updates: [UpdateItem]?
    
    func getUpdatesList() -> [UpdateItem] {
        updates = [UpdateItem]()
        do {
            // JSON Serialization is attempted on the received data
            let json = try JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions()) as? [String: Any]
            // type casting
            let list = json!["result"] as! [[String: Any]]
            
            // the date, time when the data was fetched from the API is also stored as a String
            time = json!["time"] as? String
            
            // casting all data to be finally produce a complete UpdateItem array
            for item in list {
                let updateTime = item["time"] as! String
                let updateCurrent = item["current"] as! Int
                
                let update: UpdateItem = UpdateItem(time: updateTime, current: updateCurrent)
                updates!.append(update)
            }
        }
        catch {
            print(error)
        }
        // the UpdateItem array is returned
        return updates!
    }
    
}

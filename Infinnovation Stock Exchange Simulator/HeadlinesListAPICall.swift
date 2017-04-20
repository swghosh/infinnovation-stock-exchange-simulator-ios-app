//
//  HeadlinesListAPICall.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 16/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import Foundation

class HeadlinesListAPICall: APICall {
    
    // overriden initializer
    override init(urlString:String, apiKey: String) {
        super.init(urlString: urlString, apiKey: apiKey)
        self.url = URL(string: "\(urlString)?key=\(apiKey)")
    }
    
    // an array of NewsItem(s) that will be JSON serialised/casted from the JSON
    var news: [NewsItem]?
    
    func getHeadlinesList() -> [NewsItem] {
        news = [NewsItem]()
        do {
            // JSON Serialization is attempted on the received data
            let json = try JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions()) as? [String: Any]
            // type casting
            let list = json!["result"] as! [[String: Any]]
            
            // the date, time when the data was fetched from the API is also stored as a String
            time = json!["time"] as? String
            
            // casting all data to be finally produce a complete NewsItem array
            for item in list {
                let newsTime = item["time"] as! String
                let content = item["content"] as! String
                
                let headline = NewsItem(time: newsTime, content: content)
                news!.append(headline)
            }
        }
        catch {
            print(error)
        }
        // the NewsItem array is returned
        return news!
    }
}

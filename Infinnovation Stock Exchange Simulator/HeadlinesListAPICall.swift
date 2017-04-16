//
//  HeadlinesListAPICall.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 16/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import Foundation

class HeadlinesListAPICall {
    var url: URL?
    
    init(urlString:String, apiKey: String) {
        self.url = URL(string: "\(urlString)?key=\(apiKey)")
    }
    
    var news: [NewsItem]?
    var time: String?
    
    func getHeadlinesList(jsonData: Data) -> [NewsItem] {
        news = [NewsItem]()
        do {
            let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions()) as? [String: Any]
            let list = json!["result"] as! [[String: Any]]
            time = json!["time"] as? String
            
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
        return news!
    }
}

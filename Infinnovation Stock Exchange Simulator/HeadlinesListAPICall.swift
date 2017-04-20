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
    var jsonData: Data?
    
    init(urlString:String, apiKey: String) {
        self.url = URL(string: "\(urlString)?key=\(apiKey)")
    }
    
    var news: [NewsItem]?
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
    
    func getHeadlinesList() -> [NewsItem] {
        news = [NewsItem]()
        do {
            let json = try JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions()) as? [String: Any]
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
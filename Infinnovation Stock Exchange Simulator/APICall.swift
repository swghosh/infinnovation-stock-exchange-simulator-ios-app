//
//  APICall.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 20/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import Foundation

class APICall {
    
    var url: URL?
    var jsonData: Data?
    
    init(urlString:String, apiKey: String) {
        self.url = URL(string: "\(urlString)?key=\(apiKey)")
    }
    
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
}

//
//  APICall.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 20/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import Foundation

class APICall {
    
    // data members to store the API URL and the JSON that is to be received
    var url: URL?
    var jsonData: Data?
    
    // initializer
    init(urlString:String, apiKey: String) {
        self.url = URL(string: "\(urlString)?key=\(apiKey)")
    }
    
    // a string that stores the date, time of fetching the data from the API that is JSON serialized/casted from JSON response
    var time: String?
    
    // function performs a data task and returns the HTTP response body which is supposed to contain a JSON
    func performApiCall() -> Data? {
        
        // url request
        let request = URLRequest(url: url!)
        let sharedSession = URLSession.shared
        
        // boolean variable holds false until data task finishes
        var finished = false
        
        // data task
        let task = sharedSession.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            self.jsonData = data
            
            // boolean variable will store true when data task finishes
            finished = true
            
        })
        task.resume()
        
        while(!finished) {
            // blocks the code till async task completion handler finishes
        }
        
        return jsonData
    }
}

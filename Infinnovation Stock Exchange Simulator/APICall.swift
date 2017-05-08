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
    var finished: Bool = false
    
    // initializer
    init(urlString:String, apiKey: String) {
        self.url = URL(string: "\(urlString)?key=\(apiKey)")
    }
    
    // a string that stores the date, time of fetching the data from the API that is JSON serialized/casted from JSON response
    var time: String?
    
    // function performs a data task and returns the HTTP response body which is supposed to contain a JSON
    func performApiCall() -> Data? {
        
        // url request
        var request = URLRequest(url: url!)
        let sharedSession = URLSession.shared
        
        // http method set to GET
        request.httpMethod = "GET"
        
        // semaphore dispacth till completion handler
        let semaphore = DispatchSemaphore(value: 0)
        
        // data task
        let task = sharedSession.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            self.jsonData = data
            
            // boolean variable will store true when data task finishes
            self.finished = true
            
            // signals semaphore that task finished
            semaphore.signal()
        })
        task.resume()
        
        // semaphore waits indefinitely
        _ = semaphore.wait(timeout: .distantFuture)
        
        return jsonData
    }
}

//
//  NewsItem.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 03/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

class NewsItem {
    // defines a data model for a news item
    
    var time: String
    var content: String
    
    // initializer
    init(time: String, content: String) {
        self.time = time
        self.content = content
    }
}

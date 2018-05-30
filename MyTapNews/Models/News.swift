//
//  News.swift
//  MyTapNews
//
//  Created by Hector Lueng on 5/29/18.
//  Copyright © 2018 USC. All rights reserved.
//

import Foundation

class News {
    var urlToImage: String
    var url: String
    var title: String
    var description: String
    var category: String?
    var relativeTime: String?
    
    public init(urlToImage: String, url: String, title: String, desc: String) {
        self.urlToImage = urlToImage
        self.url = url
        self.title = title
        self.description = desc
    }
}

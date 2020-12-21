//
//  NSCache.swift
//  CountryTopCharts
//
//  Created by Thomas Lenell on 2020-12-18.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation

class Cache {
    
    static let newsFeedCache = NSCache<NSString, ArticleHolder>()
    
    
    init() {
        Cache.newsFeedCache.countLimit = 10
        //Cache.newsFeedCache.totalCostLimit = ??
    }
    
    class func storeNewsFeedInCache(forKey key: String, articles: [ArticleResponse]) {
        
        let objectToCache = ArticleHolder(articles: articles)
        
        Cache.newsFeedCache.setObject(objectToCache, forKey: NSString(string: key))
    }
    
    class func clearNewsFeedCache() {
        Cache.newsFeedCache.removeAllObjects()
    }
    
}

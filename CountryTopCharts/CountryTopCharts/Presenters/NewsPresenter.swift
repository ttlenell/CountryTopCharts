//
//  NewsPresenter.swift
//  CountryTopCharts
//
//  Created by Thomas Lenell on 2020-12-15.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation

class NewsPresenter {
    let networkMonitor = NetworkMonitor()
    let newsAPI = NewsAPI()
   
    var newsFeed = [ArticleResponse]()
    
    var countryCode: String?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(getNewsWithConnection), name: Notification.Name("isConnected"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getNewsWithNoConnection), name: Notification.Name("isNotConnected"), object: nil)
    }
    
    func initiate() {
        networkMonitor.checkConnectivity()
    }
    
    @objc func getNewsWithConnection() {

        newsAPI.getNews(countryCode: countryCode!) { articles in
            
            self.updateNewsFeed(articles)
            
        }
        
        // stops monitoring the network when everything has loaded successfully
        networkMonitor.monitor.cancel()
        
    }
    
    @objc func getNewsWithNoConnection() {

        guard let countryCode = countryCode else { return }

        if let cachedArticle = Cache.newsFeedCache.object(forKey: NSString(string: countryCode)) {
            print("Using a cached image for item: \(countryCode)")
            
            updateNewsFeed(cachedArticle.articles)
        } else {
            
            updateNewsFeed()
        }
    }
    
    func updateNewsFeed(_ articles: [ArticleResponse] = [ArticleResponse]()) {

        let sortedNewsFeed = SortingUtility.bubbleSortNewsFeedAscending(newsFeed: articles)
        
        cacheArticle(articles: sortedNewsFeed)
        
        self.newsFeed = sortedNewsFeed
        
        NotificationCenter.default.post(name: Notification.Name("NewsFeedUpdated"), object: nil)
    }
    
    func cacheArticle(articles: [ArticleResponse]) {
        
        guard let countryCode = self.countryCode else { return }
        
        Cache.storeNewsFeedInCache(forKey: countryCode, articles: articles)
        
    }
    
    func clearNewsFeedCache() {
        
        Cache.clearNewsFeedCache()
        
    }

}


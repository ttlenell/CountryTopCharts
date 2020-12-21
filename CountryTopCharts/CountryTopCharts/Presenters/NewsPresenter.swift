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
   
    var newsFeed: [ArticleResponse]?
    
    var countryCode: String?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(getNewsWithConnection), name: Notification.Name("isConnected"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getNewsWithNoConnection), name: Notification.Name("isNotConnected"), object: nil)
    }
    
    func initiate() {
        networkMonitor.checkConnectivity()
    }
    
    @objc func getNewsWithConnection() {

        newsAPI.getNews(countryCode: countryCode!)
        // stops monitoring the network when everything has loaded successfully
        networkMonitor.monitor.cancel()
        
    }
    
    @objc func getNewsWithNoConnection() {
        
        guard let countryCode = countryCode else { return }

        if let cachedArticle = Cache.cache.object(forKey: NSString(string: countryCode)) {
            print("Using a cached image for item: \(countryCode)")
            NewsData.newsFeed = cachedArticle.articles
            updateNewsFeed()
        } else {
            NewsData.newsFeed = []
            updateNewsFeed()
        }
    }
    
    func updateNewsFeed() {
        guard let tempNewsFeed = NewsData.newsFeed else {return}

        let sortedNewsFeed = SortingUtility.bubbleSortNewsFeedAscending(newsFeed: tempNewsFeed)
        
        cacheArticle(articles: sortedNewsFeed)
        
        self.newsFeed = sortedNewsFeed
    }
    
    func cacheArticle(articles: [ArticleResponse]) {
        
        guard let countryCode = self.countryCode else { return }
        
//        Cache.storeNewsFeedInCache(countryCode)
        let objectToCache = ArticleHolder(articles: articles)
        
        Cache.cache.setObject(objectToCache, forKey: NSString(string: countryCode))
        Cache.cache.countLimit = 10
        

    }

}


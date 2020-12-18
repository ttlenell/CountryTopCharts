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
    
//    private let cache = NSCache<NSString, ArticleHolder>()
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(getNewsWithConnection), name: Notification.Name("isConnected"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getNewsWithNoConnection), name: Notification.Name("isNotConnected"), object: nil)
    }
    
    func initiate() {
        networkMonitor.checkConnectivity()
    }
    
    @objc func getNewsWithConnection() {

        newsAPI.getNews(countryCode: countryCode!)
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
        
        cacheArticle(articles: tempNewsFeed)
        
        self.newsFeed = tempNewsFeed
    }
    
    func cacheArticle(articles: [ArticleResponse]) {
        
        guard let countryCode = self.countryCode else { return }
        let objectToCache = ArticleHolder(articles: articles)
        
        Cache.cache.setObject(objectToCache, forKey: NSString(string: countryCode))
        print("CACHE = ", Cache.cache.object(forKey: NSString(string: countryCode)))

    }
    
}


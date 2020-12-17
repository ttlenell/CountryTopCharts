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
   
    
    var countryCode: String?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(getNewsWithConnection), name: Notification.Name("isConnected"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getNewsWithNoConnection), name: Notification.Name("isNotConnected"), object: nil)
    }
    
    func initiate() {
        networkMonitor.checkConnectivity()
    }
    
    @objc func getNewsWithConnection() {
        
        print("connected and getting from newsAPI")

        newsAPI.getNews(countryCode: countryCode!)
        networkMonitor.monitor.cancel()
        print("stopped monitoring network activity ")
        
        // save new to cache
        
    }
    
    @objc func getNewsWithNoConnection() {
        
        print("not connected and getting from cache")

        // get news from cache
        
    }
    
}

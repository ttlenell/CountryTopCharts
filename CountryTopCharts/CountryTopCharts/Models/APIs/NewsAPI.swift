//
//  NewsAPI.swift
//  CountryTopCharts
//
//  Created by Thomas Lenell on 2020-12-15.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation

class NewsAPI {
    
//    static var news: News?
    
    
    
    
    func getSources() {
        let sourcesUrlString: String = "https://newsapi.org/v2/sources?apiKey=d1c7748715cc482fb7f9908d73101c81"
        
        let request = NSMutableURLRequest(url: NSURL(string: sourcesUrlString)! as URL)
        let session = URLSession.shared
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
         let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if (error != nil) {
                
            }
          else {
            //inte error!
            guard let data = data else {return}
            do {
                
                let response: SourcesResponse = try JSONDecoder().decode(SourcesResponse.self, from: data)
                NewsData.sources = response.sources
   
                NotificationCenter.default.post(name: Notification.Name("SourcesUpdated"), object: nil)
                
            }
            catch let jsonError as NSError {
              print("JSON decode failed: \(jsonError.localizedDescription)")
            }
            }})
        task.resume()
        
    }
    
    func getNews(countryCode: String) {
        let newsUrlString: String = "https://newsapi.org/v2/top-headlines?country=" + countryCode + "&apiKey=d1c7748715cc482fb7f9908d73101c81"
        let request = NSMutableURLRequest(url: NSURL(string: newsUrlString)! as URL)
        let session = URLSession.shared
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
         let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if (error != nil) {
                
            }
          else {
            //inte error!
            guard let data = data else {return}
            do {
                
                let response: ArticlesResponse = try JSONDecoder().decode(ArticlesResponse.self, from: data)
                var tempArray: [ArticleResponse] = []
                
                for article in response.articles! {

                    if tempArray.count < 10 {
                        tempArray.append(article)
                    }
                }
                
                NewsData.newsFeed = tempArray
                
                NotificationCenter.default.post(name: Notification.Name("NewsFeedUpdated"), object: nil)
                
                
            }
            catch let jsonError as NSError {
              print("JSON decode failed: \(jsonError.localizedDescription)")
            }
            }})
        task.resume() }
}

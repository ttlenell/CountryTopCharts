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
    let sourcesUrlString: String = "https://newsapi.org/v2/sources?apiKey=d1c7748715cc482fb7f9908d73101c81"
    
    
    
    func getSources() {
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
                print("api SOURCE call complete from apinews.org")
                
                let response: SourcesResponse = try JSONDecoder().decode(SourcesResponse.self, from: data)
                NewsData.sources = response.sources
   
                NotificationCenter.default.post(name: Notification.Name("SourcesUpdated"), object: nil)
                
            }
            catch let jsonError as NSError {
              print("JSON decode failed: \(jsonError.localizedDescription)")
            }
            }})
        task.resume() }
    
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
                print(response)
                for article in response.articles! {

                    if tempArray.count < 10 {
                        tempArray.append(article)
                    } else {
                        return
                    }
                }
                
                NewsData.NewsFeed = tempArray
                print("api NEWS call complete from apinews.org")
                print("the country code is " + countryCode)
                
                
                
                
            }
            catch let jsonError as NSError {
              print("JSON decode failed: \(jsonError.localizedDescription)")
            }
            }})
        task.resume() }
}

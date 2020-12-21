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
    
    
    
    
    func getSources(_ closure: @escaping (_ sources: [Source]) -> Void) {
        let sourcesUrlString: String = "https://newsapi.org/v2/sources?apiKey=d1c7748715cc482fb7f9908d73101c81"
        
        let request = NSMutableURLRequest(url: NSURL(string: sourcesUrlString)! as URL)
        let session = URLSession.shared
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
         let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if (error != nil) {
                print("sources error = ", error.debugDescription)
            }
          else {
            //inte error!
            guard let data = data else {return}
            do {
                
                let response: SourcesResponse = try JSONDecoder().decode(SourcesResponse.self, from: data)
                
                guard let sources = response.sources else {
                    return
                }
                
                closure(sources)
                
            }
            catch let jsonError as NSError {
              print("JSON decode failed: \(jsonError.localizedDescription)")
            }
            }})
        task.resume()
        
    }
    
    func getNews(countryCode: String, _ closure: @escaping (_ articles: [ArticleResponse]) -> Void ) {
        let newsUrlString: String = "https://newsapi.org/v2/top-headlines?country=" + countryCode + "&apiKey=d1c7748715cc482fb7f9908d73101c81"
        let request = NSMutableURLRequest(url: NSURL(string: newsUrlString)! as URL)
        let session = URLSession.shared
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
         let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if (error != nil) {
                print("news error = ",error.debugDescription)
            }
          else {
            //inte error!
            guard let data = data else {return}
            do {
                
                let response: ArticlesResponse = try JSONDecoder().decode(ArticlesResponse.self, from: data)
                var tempArray: [ArticleResponse] = []
                
                for article in response.articles! {

                    if tempArray.count < 10 {
                        if article.title != nil && article.urlToImage != nil {
                            
                            tempArray.append(article)
                        }
                    }
                }
                
                closure(tempArray)
                
            }
            catch let jsonError as NSError {
              print("JSON decode failed: \(jsonError.localizedDescription)")
            }
            }})
        task.resume() }
}

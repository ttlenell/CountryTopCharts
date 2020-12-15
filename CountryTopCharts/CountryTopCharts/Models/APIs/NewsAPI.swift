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
    let urlString: String = "https://newsapi.org/v2/sources?apiKey=d1c7748715cc482fb7f9908d73101c81"
    
    
    func getNews() {
        let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL)
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
                print("api news call complete")
                
                
                NewsData.news = try JSONDecoder().decode(News.self, from: data)
                print(NewsData.news)
                
//                for source in NewsData.news?.sources! {
//                    
//                }
                NotificationCenter.default.post(name: Notification.Name("News Updated"), object: nil)
                
            }
            catch let jsonError as NSError {
              print("JSON decode failed: \(jsonError.localizedDescription)")
            }
            }})
        task.resume() }
}

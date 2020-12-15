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
    
    
    
    func getSources() {
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
                print("api NEWS call complete from apinews.org")
                
                
            }
            catch let jsonError as NSError {
              print("JSON decode failed: \(jsonError.localizedDescription)")
            }
            }})
        task.resume() }
}

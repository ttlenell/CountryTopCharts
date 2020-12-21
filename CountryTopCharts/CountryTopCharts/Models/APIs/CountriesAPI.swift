//
//  CountriesAPI.swift
//  CountryTopCharts
//
//  Created by Tobias Classon on 2020-11-27.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation

class CountriesAPI {
    
    
    
    func getCountries() {
        
        let urlString: String = "https://restcountries.eu/rest/v2/all"
        
        let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL)
        let session = URLSession.shared
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
         let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
         if (error != nil) {
            //error!
            print("countries error =", error.debugDescription)
            
            
            
         } else {
            //inte error!
            guard let data = data else {return}
            do {
                
                CountriesData.countries = try JSONDecoder().decode([CountryResponse].self, from: data)
                
                NotificationCenter.default.post(name: Notification.Name("CountriesUpdated"), object: nil)
                
            }
            catch let jsonError as NSError {
              print("JSON decode failed: \(jsonError.localizedDescription)")
            }
            }})
        task.resume()
        
    }
    
    
    
    
    
    
}

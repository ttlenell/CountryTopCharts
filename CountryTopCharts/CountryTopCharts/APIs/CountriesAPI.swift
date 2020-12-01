//
//  CountriesAPI.swift
//  CountryTopCharts
//
//  Created by Tobias Classon on 2020-11-27.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//
// hejsan
import Foundation

class CountriesAPI {
    
    var countries: [Country]?
    let urlString: String = "https://restcountries.eu/rest/v2/all"
    
    
    func getCountries(){
    let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL)
    let session = URLSession.shared
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
     let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
     if (error != nil) {
        //error!
        
     } else {
        //inte error!
        guard let data = data else {return}
        do {
            self.countries = try JSONDecoder().decode([Country].self, from: data)
            
        }
        catch let jsonError as NSError {
          print("JSON decode failed: \(jsonError.localizedDescription)")
        }
        print(self.countries)
        }})
    task.resume() }
    
    
    
    
    
    
}

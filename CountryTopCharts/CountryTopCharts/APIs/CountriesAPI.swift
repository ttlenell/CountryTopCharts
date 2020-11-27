//
//  CountriesAPI.swift
//  CountryTopCharts
//
//  Created by Tobias Classon on 2020-11-27.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation

class CountriesAPI {
    
    let urlString: String = "https://restcountries.eu/rest/v2/all"
    
    // get All Countries, för att visa i lista
    
    
    func getCountries(){
    let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL)
    let session = URLSession.shared
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
     let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
     if (error != nil) {
        //error
        
     } else {
        //inte error
        var result: CountryResult?
        print(data)
        guard let data = data else {return}
        do {
            result = try JSONDecoder().decode(CountryResult.self, from: data)
            print(result)
        }
        catch {
            print(result)
            print("error parsing JSON")
        }
        
        print("hej")
        }})
    task.resume() }
    
    
    
    
    
    
}

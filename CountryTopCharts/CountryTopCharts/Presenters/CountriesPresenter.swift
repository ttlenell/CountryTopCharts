//
//  Presenter.swift
//  CountryTopCharts
//
//  Created by Tobias Classon on 2020-11-27.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation

class CountriesPresenter {
    
    let countriesAPI = CountriesAPI()
    var countries = [CountryResponse]()
    var sources = [Source]()
    
    let newsAPI = NewsAPI()
    
    @objc func runGetCountries() {
        
        getCountries()
        
    }
    
    func getAcceptedCountries() {
        // Run get sources to trigger observer that will update countries
        getSources()
    }
    
    func getCountries() {
        
        countriesAPI.getCountries() { countries in
            
            self.updateCountries(countries: countries)
            
        }
    }
    
    func getSources() {
        
        newsAPI.getSources() { sources in
            
            self.sources = sources
            
            self.getCountries()
        }
    }
    
    func updateCountries(countries: [CountryResponse]) {
        var acceptedCountries: [CountryResponse] = []
        
        // filter countries to only show those
        // that exist in sources
        for country in countries {
            for source in self.sources{
                if country.alpha2Code?.lowercased() == source.country?.lowercased() {
                    var countryExist = false
                    for acceptedCountry in acceptedCountries {
                        if acceptedCountry.alpha2Code?.lowercased() ==  country.alpha2Code?.lowercased(){
                            countryExist = true
                        }
                    }
                    
                    if !countryExist {
                        var countryToAdd = country
                        countryToAdd.alpha2Code = countryToAdd.alpha2Code?.lowercased()
                        print("adding country to accepted")
                        acceptedCountries.append(countryToAdd)
                    }
                    
                }
            }
        }
        
        self.countries = acceptedCountries
        
        NotificationCenter.default.post(name: Notification.Name("CountriesUpdated"), object: nil)
      
    }
    
    func clearNewsFeedCache() {
        
        Cache.clearNewsFeedCache()
        
    }
}

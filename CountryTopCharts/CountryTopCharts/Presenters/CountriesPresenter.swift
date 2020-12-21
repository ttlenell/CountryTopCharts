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
    var countries: [CountryResponse]? = CountriesData.countries
    

    let newsAPI = NewsAPI()
    var sources: [Source]? = NewsData.sources
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(runGetCountries), name: Notification.Name("SourcesUpdated"), object: nil)
    }
    
    @objc func runGetCountries() {
        getCountries()
    }
    
    func getAcceptedCountries() {
        // Run get sources to trigger observer that will update countries
        getSources()
    }
    
    func getCountries() {
        countriesAPI.getCountries()
    }
    
    func getSources() {
        
        newsAPI.getSources()
    }
    
    func updateCountries() {
        var acceptedCountries: [CountryResponse] = []
    
        // filter countries to only show those
        // that exist in sources
        for country in CountriesData.countries! {
            for source in NewsData.sources!{
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
                        acceptedCountries.append(countryToAdd)
                    }
                    
                }
            }
        }
        
        CountriesData.countries = acceptedCountries
        self.countries = acceptedCountries
      
    }
    
    func clearNewsFeedCache() {
        
        Cache.clearNewsFeedCache()
        
    }
}

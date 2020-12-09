//
//  ViewController.swift
//  CountryTopCharts
//
//  Created by Tobias Classon on 2020-11-27.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import UIKit

class CountryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var countriesTableView: UITableView!
    let countriesPresenter = CountriesPresenter()
    let countriesAPI = CountriesAPI()
    
    var countries: [Country]?

    override func viewDidLoad() {
        super.viewDidLoad()
        countries = CountriesAPI.countries
        
        let nib = UINib(nibName: "CountryTableViewCell", bundle: nil)
        countriesTableView.register(nib, forCellReuseIdentifier: "CountryTableViewCell")
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
        
        countriesPresenter.getCountries()
        
        // antingen göra api asynkront och köra resten när vi vet att countries har ett värde
        // eller trigga en rerender när countries ändras
        
        
        // Kör api för att ge countries array ett värde
        // countriesPresenter.getCountries()
        
        // När api.countries fått ett värde ska presenter.countries uppdateras
        // observer??
        
        // När countriesPresenter.countries uppdateras ska sidan renderas om med ny data
        // hur triggar med rerender?
        
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        countries = CountriesAPI.countries
        print(countries)
        self.countriesTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let countries = countries else {
            print("returning 0 because countries is nil")
            return 0
            
        }
        
        return countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countriesTableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as! CountryTableViewCell
        guard let countries = countries else {
            return cell
        }
        cell.countryLabel.text = countries[indexPath.row].name
        return cell
    }
}


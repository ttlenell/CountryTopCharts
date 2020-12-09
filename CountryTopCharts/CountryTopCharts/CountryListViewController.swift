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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CountryTableViewCell", bundle: nil)
        countriesTableView.register(nib, forCellReuseIdentifier: "CountryTableViewCell")
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
        
        countriesPresenter.getCountries()
        
        NotificationCenter.default.addObserver(self, selector: #selector(countriesUpdatedNotificationRecieved), name: Notification.Name("CountriesUpdated"), object: nil)
        
    }
    
    @objc func countriesUpdatedNotificationRecieved () {
        
        countriesPresenter.updateCountries()
        
        DispatchQueue.main.async {
            self.countriesTableView.reloadData()
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let countries = countriesPresenter.countries else {
            print("returning 0 because countries is nil")
            return 0
            
        }
        
        return countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countriesTableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as! CountryTableViewCell
        guard let countries = countriesPresenter.countries else {
            return cell
        }
        cell.countryLabel.text = countries[indexPath.row].name
        return cell
    }
}


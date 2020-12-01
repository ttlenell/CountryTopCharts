//
//  ViewController.swift
//  CountryTopCharts
//
//  Created by Tobias Classon on 2020-11-27.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import UIKit

class CountryListViewController: UIViewController {
    
    let countriesPresenter = CountriesPresenter()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        // antingen göra api asynkront och köra resten när vi vet att countries har ett värde
        // eller trigga en rerender när countries ändras
        
        
        // Kör api för att ge countries array ett värde
        // countriesPresenter.getCountries()
        
        // När api.countries fått ett värde ska presenter.countries uppdateras
        // observer??
        
        // När countriesPresenter.countries uppdateras ska sidan renderas om med ny data
        // hur triggar med rerender?
        
    }

//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return UITableViewCell
//    }
}


//
//  ViewController.swift
//  CountryTopCharts
//
//  Created by Tobias Classon on 2020-11-27.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import UIKit
import CryptoKit

class CountryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var selectedRow = 0
    
    @IBOutlet var countriesTableView: UITableView!
    
    let countriesPresenter = CountriesPresenter()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CountryTableViewCell", bundle: nil)
        countriesTableView.register(nib, forCellReuseIdentifier: "CountryTableViewCell")
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
        
        countriesPresenter.getAcceptedCountries()
        
        NotificationCenter.default.addObserver(self, selector: #selector(countriesUpdatedNotificationRecieved), name: Notification.Name("CountriesUpdated"), object: nil)
        
        // Encyption playground
        
        DispatchQueue.global(qos: .default).async {
            let hashedString = self.hashItem(item: "hej")
            let hashedString2 = self.hashItem(item: "hej")
            let stringToEncode = "tjena"
            let encodedPassword = self.encodeString(stringToEncode: stringToEncode)
            let decodedPassword = self.decodeString(dataToDecode: encodedPassword!)
            
            DispatchQueue.main.async {
                print("hashed:", hashedString)
                print("hashed2:", hashedString2)
                
                print("encoded:", encodedPassword!.base64EncodedString())
                print("decoded:", decodedPassword!)
            }
        }
    }
    
    func hashItem(item: String) -> Int {

      var hasher = Hasher()
      item.hash(into: &hasher)
      return hasher.finalize()
    }
    
    func encodeString(stringToEncode: String) -> Data? {
        return stringToEncode.data(using: String.Encoding.utf8)
    }
    
    func decodeString(dataToDecode: Data) -> String? {
        return String(data: dataToDecode, encoding: String.Encoding.utf8)
    }
    
    @objc func countriesUpdatedNotificationRecieved () {
        
        DispatchQueue.main.async {
            self.countriesTableView.reloadData()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        countriesPresenter.clearNewsFeedCache()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToSelectedCountry" {

            let destinationVC = segue.destination as? SelectedCountryViewController
            
            destinationVC?.selectedCountryPresenter.country = countriesPresenter.countries[selectedRow]
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = countriesTableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedRow = indexPath.row
        performSegue(withIdentifier: "segueToSelectedCountry", sender: cell)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return countriesPresenter.countries.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = countriesTableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as! CountryTableViewCell
        
        cell.countryLabel.text = countriesPresenter.countries[indexPath.row].name
        
        return cell
    }
}


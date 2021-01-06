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
        
       let encrypted = EncyptionUtility.encrypt(stringToEncrypt: "tjolahopp")
       let decrypted =  EncyptionUtility.decrypt(dataToDecrypt: encrypted)
        print("?? IV:", EncyptionUtility.iv)
        print("??", decrypted)
        
        DispatchQueue.global(qos: .default).async {
            let hashedString = EncyptionUtility.hashItem(item: "hej")
            let hashedString2 = EncyptionUtility.hashItem(item: "hej")
            let stringToEncode = "tjena"
            let encodedPassword = EncyptionUtility.encodeString(stringToEncode: stringToEncode)
            let decodedPassword = EncyptionUtility.decodeString(dataToDecode: encodedPassword!)
            
            DispatchQueue.main.async {
                print("!!! hashed:", hashedString)
                print("!!! hashed2:", hashedString2)
                
                print("!!! encoded:", encodedPassword!.base64EncodedString())
                print("!!! decoded:", decodedPassword!)
            }
        }
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


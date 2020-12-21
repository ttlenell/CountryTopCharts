//
//  ViewController.swift
//  CountryTopCharts
//
//  Created by Tobias Classon on 2020-11-27.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

// Kriterier
// 1: MVP, Varför? (VIKTIGT!)
//    Använder observer pattern, varför? (VIKTIGT!)
//    Använder singletons, varför? (VIKTIGT!)

// 2: Relation mellan online data och cache: *CHECK*✅
//    Vi hämtar från api om internet finns och sparar i cache
//    Om internet inte finns så hämtar vi från cache och visar
//    upp tom array om cache e tom.

// 3: Unit tests för beteeneden: (VIKTIGT!)
//    Vad kan vi testa i vårt fall? api calls? NSTimer för att testa hastighet,
//    test för sorting algoritm och kryptering *CHECK*✅

// 4: Exempel från profiler före/efter, stresstest? (VIKTIGT!) ( Att kunna reflektera över detta )
//    Vi använder NWPathMonitor för att se om device är connected eller ej *CHECK*✅
//    Reflektera över data från exempelvis energy test osv

// 5: Encyption / sortering:
//    Sortering: Kan sortera NewsFeed på datum *CHECK*
//    Kryptering? låtsasfunktion, testa olika typer av hashing och reflektera över skillnader i output *CHECK*✅

//    Använda db? (Om vi har tid) Kunna reflektera över skillnaden på document based och SQL? (VIKTIGT!)

//    Skapa egna async anrop för att påvisa kunskap om threads? (Om vi har tid)

//    Error handling i api calls. ✅
//    Enkel error handling (typ logga error code) (VIKTIGT!) ✅ loggar error description
//    Retry funktionalitet vid rimlig error code (Om vi har tid) Behövs när vi hämtar hem countries

//    Kolla om SDWebImage cachar bilder ( VIKTIGT! ). Den cachear, ska ta reda på hur länge/hur stora filer
//    Regler för cache ( VIKTIGT! ) sätta hur länge/ hur stora filer?

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
        let hashedString = hashItem(item: "hej")
        let hashedString2 = hashItem(item: "hej")
        let stringToEncode = "tjena"
        let encodedPassword = encodeString(stringToEncode: stringToEncode)
        let decodedPassword = decodeString(dataToDecode: encodedPassword!)
        
        print("hashed:", hashedString)
        print("hashed2:", hashedString2)
        
        print("encoded:", encodedPassword!.base64EncodedString())
        print("decoded:", decodedPassword!)
        
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
        
        countriesPresenter.updateCountries()
        
        DispatchQueue.main.async {
            self.countriesTableView.reloadData()
        }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToSelectedCountry" {
            
            let destinationVC = segue.destination as? SelectedCountryViewController
            
            guard let countries = countriesPresenter.countries else {
                return
            }
            
            destinationVC?.selectedCountryPresenter.country = countries[selectedRow]
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = countriesTableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedRow = indexPath.row
        performSegue(withIdentifier: "segueToSelectedCountry", sender: cell)
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


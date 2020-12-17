//
//  NewsFeedViewController.swift
//  CountryTopCharts
//
//  Created by Tobias Classon on 2020-12-16.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import UIKit


class NewsFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let newsPresenter = NewsPresenter()
    
    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        newsTableView.register(nib, forCellReuseIdentifier: "NewsTableViewCell")
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.rowHeight = UITableView.automaticDimension
        newsTableView.estimatedRowHeight = 600
        
        newsPresenter.initiate()
        
        NotificationCenter.default.addObserver(self, selector: #selector(newsFeedUpdatedNotificationRecieved), name: Notification.Name("NewsFeedUpdated"), object: nil)
        
    }
    
    @objc func newsFeedUpdatedNotificationRecieved () {
        print("observer triggered")
        newsPresenter.updateNewsFeed()
        
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Did select cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let newsFeed = newsPresenter.newsFeed else {
            print("returning 0")
            return 0
        }
        print("returning count")
        return newsFeed.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        
         guard let newsFeed = newsPresenter.newsFeed else {
            return cell
         }
        guard let urlToImage = newsFeed[indexPath.row].urlToImage else { return cell }
//        guard let source = newsFeed[indexPath.row].source else { return cell }
//        guard let sourceName = source.name else { return cell }
        
        cell.title.text = newsFeed[indexPath.row].title
        cell.articleImageView.sd_setImage(with: URL(string: urlToImage), completed: nil)
        
        return cell
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}

//
//  ViewController.swift
//  MyTapNews
//
//  Created by Hector Lueng on 4/11/18.
//  Copyright © 2018 USC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var NewsTableView: UITableView!
    
    // public?
    var token: String!
    var userEmail: String!
    
    private var newsList: [News] = []
    private var pageNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NewsTableView.delegate = self
        NewsTableView.dataSource = self
        
        print("User name: \(userEmail), token: \(token!)")
        loadList()
        
        // TODO: scroll down listener
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadList() {
        let headers = ["Accept": "application/json",
                   "Content-Type": "application/json",
                   "Authorization": "Bearer " + self.token
        ]
        let url = "\(Config.tapNews.newApiUrl)/userId/\(userEmail!)/pageNum/\(pageNum)"
        
        Alamofire.request(url, method: .get, headers: headers)
        .responseJSON { (response) in
            switch response.result {
            case .success:
                let data = JSON(response.data!)
                print(data)
                if let list = data.array {
                    list.forEach({ (newsData) in
                        let news = News(urlToImage: newsData["urlToImage"].string!,
                                        url: newsData["url"].string!,
                                        title: newsData["title"].string!,
                                        desc: newsData["description"].string!)
                        if let category = newsData["category"].string {
                            news.category = category
                        }
                        if let relativeTime = newsData["relativeTime"].string {
                            news.relativeTime = relativeTime
                        }
                        self.newsList.append(news)
                    })
                    
                    // here?
                    self.pageNum += 1
                    
                    // TODO: performance? good practice?
                    self.NewsTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
            print("after loading news: list \(self.newsList)")
        }
    }
}

extension NewsViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCard") as! NewsTableViewCell
        let news = self.newsList[indexPath.row]
        
        print(news.title)
        cell.NewsTitleLabel.text = news.title
        cell.NewsDescription.text = news.description
        cell.imageUrl = news.urlToImage
        
        // TODO: implement loading of image from URL
//        cell.NewsImage.image = UIImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 168
    }
}


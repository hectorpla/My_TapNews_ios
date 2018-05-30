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
    
    private var newsList = [News]()
    private var pageNum: Int = 0
    private var isLoading: Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NewsTableView.delegate = self
        NewsTableView.dataSource = self
        
        print("User name: \(userEmail), token: \(token!)")
        
        // TODO: scroll down listener
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        spinner.frame = CGRect(x: 0, y: 0, width: self.NewsTableView.frame.width, height: 50)
        spinner.startAnimating()
        self.NewsTableView.tableFooterView = spinner
        
        loadMore()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let bottom = scrollView.contentSize.height - scrollView.frame.size.height
        let offset = scrollView.contentOffset.y
        
        print("scrollViewDidEndDragging, bottom: \(bottom), offset:\(offset)")
        if offset - bottom > 30 {
            loadMore()
            print("loadMore() called")
        }
    }
    
    func loadMore() {
        let headers = ["Accept": "application/json",
                   "Content-Type": "application/json",
                   "Authorization": "Bearer " + self.token
        ]
        let url = "\(Config.tapNews.newApiUrl)/userId/\(userEmail!)/pageNum/\(pageNum)"
        
        assert(!isLoading)
        self.isLoading = true
        Alamofire.request(url, method: .get, headers: headers)
        .responseJSON { (response) in
            switch response.result {
            case .success:
                let data = JSON(response.data!)
//                print(data)
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
            self.isLoading = false
        }
    }
}

extension NewsViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCard", for: indexPath) as! NewsTableViewCell
        let news = self.newsList[indexPath.row]
        
        cell.NewsTitleLabel.text = news.title
        cell.NewsDescription.text = news.description
        
        // TODO: implement loading of image from URL
        // bad to put here: repeated downloads for same images?
        // think about cell reuse
        // consider switching to SDWebImage
        print("tableViewCellForRowAt fetching image: \(news.urlToImage)")
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: URL(string: news.urlToImage)!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.NewsImage.image = image
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 168
    }
}

//
//  ViewController.swift
//  MyTapNews
//
//  Created by Hector Lueng on 4/11/18.
//  Copyright © 2018 USC. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var NewsListView: UITableView!
    
    // public?
    var token: String!
    var userEmail: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("User name: \(userEmail), token: \(token)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


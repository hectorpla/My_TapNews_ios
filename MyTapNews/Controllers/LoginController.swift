//
//  LoginController.swift
//  MyTapNews
//
//  Created by Hector Lueng on 4/24/18.
//  Copyright © 2018 USC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginController: UIViewController {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func login(_ sender: UIButton) {
        let userName = self.userName.text!
        let password = self.password.text!
        let body: Parameters = ["email": userName,
                                "password": password]
        
        print(body)
        Alamofire.request(Config.tapNews.loginApiUrl, method: .post,
                          parameters: body, encoding: JSONEncoding.default)
            .responseJSON { response in
//                print("Request: \(response.request)")
//                print("Response: \(response.response)")
//                print("Error: \(response.error)")
        
                switch response.result {
                case .success:
//                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                        print("Data: \(utf8Text)")
//                    }
                    let data = JSON(response.data)
                    print(data)
                    
                case .failure(let error):
                    print(error)
                }
        }
        
    }
    
}

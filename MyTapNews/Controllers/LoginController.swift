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
import Toast_Swift

class LoginController: UIViewController {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    private var token: String!
    
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
    
    @IBAction func loginPressed(_ sender: UIButton) {
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
                let data = JSON(response.data!)
                print(data)
                if !data["success"].bool! {
                    self.view.makeToast("login failed code: \(data["code"].int!)")
//                    print()
                    return
                }
                self.token = data["token"].string
                self.performSegue(withIdentifier: "LoginSuccessfullyShowNews",
                                  sender: self)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    // extract login logic
    func loginAuth() {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginSuccessfullyShowNews" {
            let tabBarController = segue.destination as! UITabBarController
            let newsViewController = tabBarController.viewControllers![0] as! NewsViewController
            
            // TODO: should use member var?
            newsViewController.userEmail = self.userName.text!
            newsViewController.token = self.token!
        }
    }
}


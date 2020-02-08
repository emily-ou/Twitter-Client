//
//  LoginViewController.swift
//  Twitter
//
//  Created by Emily Ou on 2/3/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBAction func loginButton(_ sender: Any) {
        
        // Twitter user authorization URL
        let URL = "https://api.twitter.com/oauth/request_token"
        
        // If login button is successful
        TwitterAPICaller.client?.login(url: URL, success: {
            // Sets LoggedIn key to true
            UserDefaults.standard.set(true, forKey: "LoggedIn")
            // Login to app
            self.performSegue(withIdentifier: "LoginToHome", sender: self)
        }, failure: { (Error) in
            // If login button is unsuccessful
            print("Login button failed")
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "LoggedIn") == true {
            // Login to app
            self.performSegue(withIdentifier: "LoginToHome", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

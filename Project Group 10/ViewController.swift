//
//  ViewController.swift
//  Project Group 10
//
//  Created by Vince Nguyen on 9/20/18.
//  Copyright © 2018 Vince Nguyen. All rights reserved.
//

import UIKit
import CloudKit
import Firebase


class ViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    @IBAction func LogInButton(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!)
            { (user, error) in
                if error == nil{
                self.performSegue(withIdentifier: "mainpage", sender: self)
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
        override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }


}


//
//  SignUpViewController.swift
//  Project Group 10
//
//  Created by Vince Nguyen on 10/23/18.
//  Copyright © 2018 Vince Nguyen. All rights reserved.
//

import UIKit
import Firebase



class SignUpViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()}
    
   
    @IBOutlet weak var reg_email: UITextField!
    @IBOutlet weak var reg_password: UITextField!
    @IBOutlet weak var reg_confirmPassword: UITextField!
    

    
    
   
    @IBAction func regButon(_ sender: Any) {
        if reg_password.text != reg_confirmPassword.text {
            
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
            
        else{
             Auth.auth().createUser(withEmail: reg_email.text!, password: reg_password.text!){ (user, error) in
                
                if error == nil {

                self.performSegue(withIdentifier: "login", sender: self)
                    
                }else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
}
    
    
    
    
    
    
    

       
    
    

  



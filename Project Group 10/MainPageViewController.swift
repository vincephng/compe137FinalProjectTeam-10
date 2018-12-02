//
//  MainPageViewController.swift
//  Project Group 10
//
//  Created by Vince Nguyen on 10/24/18.
//  Copyright © 2018 Vince Nguyen. All rights reserved.
//

import UIKit
import Firebase

class MainPageViewController: UIViewController {
   

    
    @IBAction func logoutButton(_ sender: Any) {
//        do {
//            try Auth.auth().signOut()
//        }
//        catch let signOutError as NSError {
//            print ("Error signing out: %@", signOutError)
//        }
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let initial = storyboard.instantiateInitialViewController()
      
          self.performSegue(withIdentifier: "logout", sender: self)
        
    }
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
    }
}

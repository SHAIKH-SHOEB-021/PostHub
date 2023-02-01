//
//  SettingViewController.swift
//  PostHub
//
//  Created by shoeb on 31/01/23.
//

import UIKit
import Firebase

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
   
    @IBAction func logoutBTN(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            print("Logout Successful")
            let signInVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
            self.navigationController?.pushViewController(signInVC, animated: true)
        }catch{
            print("Some Error")
        }
    }
}

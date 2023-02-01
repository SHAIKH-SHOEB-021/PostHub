//
//  SignUpViewController.swift
//  PostHub
//
//  Created by shoeb on 31/01/23.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signInLBL: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: false)
        let tap = UITapGestureRecognizer(target: self, action: #selector(signInGesture))
        signInLBL.addGestureRecognizer(tap)
    }
    
    @IBAction func signUpBTN(_ sender: Any) {
        if emailTF.text != "" && passwordTF.text != ""{
            Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { (authData, error) in
                if error != nil{
                    print("Error \(String(describing: error?.localizedDescription))")
                }else{
                    print("Sign Up Successful")
                    let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
                    self.navigationController?.pushViewController(signUpVC, animated: true)
                }
            }
        }else{
            print("Empty Email or Password")
        }
    }
    
    @objc func signInGesture(){
        let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
}

//
//  ViewController.swift
//  PostHub
//
//  Created by shoeb on 31/01/23.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signUpLBL: UILabel!
    @IBOutlet weak var forgotPassLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        let tap = UITapGestureRecognizer(target: self, action: #selector(signUpGesture))
        signUpLBL.addGestureRecognizer(tap)
        
    }
    
    @IBAction func signInBTN(_ sender: Any) {
        if emailTF.text != "" && passwordTF.text != ""{
            Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { (authData, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error!.localizedDescription)
                }else{
                    let alert = UIAlertController(title: "Successful", message: "SignIn Successfully", preferredStyle: UIAlertController.Style.alert)
                    let okBTN = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (UIAlertAction) in
                        let mainTabVC = self.storyboard?.instantiateViewController(withIdentifier: "MainTabViewController") as!
                        MainTabViewController
                        self.navigationController?.pushViewController(mainTabVC, animated: true)
                    }
                    alert.addAction(okBTN)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }else{
            self.makeAlert(titleInput: "Empty", messageInput: "Empty Email or Password")
        }
    }
    
    @objc func signUpGesture(){
        let signInVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as!
        SignUpViewController
        self.navigationController?.pushViewController(signInVC, animated: true)
    }
    
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okBTN = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okBTN)
        self.present(alert, animated: true, completion: nil)
    }
}


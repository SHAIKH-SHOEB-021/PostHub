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

        // Hide Navi Back Button Code Here
        self.navigationItem.setHidesBackButton(true, animated: false)
        let tap = UITapGestureRecognizer(target: self, action: #selector(signInGesture))
        signInLBL.addGestureRecognizer(tap)
    }
    
    @IBAction func signUpBTN(_ sender: Any) {
        if emailTF.text != "" && passwordTF.text != ""{
            Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { (authData, error) in
                if error != nil{
                    //print("Error \(String(describing: error?.localizedDescription))")
                    self.makeAlert(titleInput: "Error", messageInput: error!.localizedDescription)
                }else{
                    let alert = UIAlertController(title: "Successful", message: "SignUp Successfully", preferredStyle: UIAlertController.Style.alert)
                    let okBTN = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (UIAlertAction) in
                        let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
                        self.navigationController?.pushViewController(signUpVC, animated: true)
                    }
                    alert.addAction(okBTN)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }else{
            self.makeAlert(titleInput: "Empty", messageInput: "Empty Email or Password")
        }
    }
    
    @objc func signInGesture(){
        let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okBTN = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okBTN)
        self.present(alert, animated: true, completion: nil)
    }
}

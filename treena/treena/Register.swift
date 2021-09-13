//
//  Register.swift
//  treena
//
//  Created by asong on 2021/09/13.
//

import Foundation
import Firebase

class RegisterViewController: UIViewController {
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { authResult, error in
            if authResult != nil{
                print("register success")
                guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeVC") as? ViewController else {return}
              
                self.navigationController?.pushViewController(nextVC, animated: true)
            } else {
                print("register failed")
            }
        }
    }
}

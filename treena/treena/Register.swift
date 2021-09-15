//
//  Register.swift
//  treena
//
//  Created by asong on 2021/09/13.
//

import Foundation
import Firebase
import FirebaseDatabase

class RegisterViewController: UIViewController {
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    var ref: DatabaseReference!
    var uid: String!
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { authResult, error in
            if authResult != nil{
                print("register success")
                
                // Firebase Database 연결
                self.ref = Database.database().reference()
                
                // 데이터베이스에 회원정보 저장 
                if Auth.auth().currentUser != nil {
                    let user = Auth.auth().currentUser
                    self.uid = user?.uid
                    
                    let value: [String: Any] = [ "uid" : self.uid, "email" : user?.email]
                    self.ref.child("Users").child(self.uid).setValue(value)
                } else{
                    print("user is nil")
                }
                
                guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeVC") as? ViewController else {return}
              
                self.navigationController?.pushViewController(nextVC, animated: true)
            } else {
                print("register failed")
            }
        }
        
    }
}

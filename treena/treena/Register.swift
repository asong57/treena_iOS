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
    
    
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { authResult, error in
            if authResult != nil{
                print("register success")
                
                var ref: DatabaseReference!
                var uid: String!
                
                // Firebase Database 연결
                ref = Database.database().reference()
                
                // 데이터베이스에 회원정보 저장 
                if Auth.auth().currentUser != nil {
                    
                    let user = Auth.auth().currentUser
                    uid = user?.uid
                    
                    let value: [String: Any] = [ "uid" : uid, "email" : user?.email]
                    ref.child("Users").child(uid).setValue(value)
                    print("uid : \(uid)")
                    print("email : \(user?.email)")
                    print("database saved")
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

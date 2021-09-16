//
//  MyPage.swift
//  treena
//
//  Created by asong on 2021/09/13.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class MyPageViewController: UIViewController {
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var resetPasswordButton: UIButton!
    @IBOutlet weak var deleteUserButton: UIButton!
    
    var user: User!
    var userEmail: String!
    var ref: DatabaseReference!
    var uid: String!
    
    override func viewDidLoad() {
        self.user = Auth.auth().currentUser
        self.userEmail = user.email
        self.uid = user.uid
        ref = Database.database().reference()
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "LoginVC") as? LoginViewController else {return}
            
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetPasswordClicked(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: userEmail) { (error) in
            if error != nil {
                print("failed email sending")
            } else {
                print("successed email sending")
            }
        }
    }
    
    @IBAction func deleteUserClicked(_ sender: Any) {
        user?.delete(completion: { (error) in
            if error != nil {
                print("failed delete user")
            } else {
                print("successed delete user")
                
                self.ref.child("Users").child(self.uid).removeValue()
                
                guard let nextVC = self.storyboard?.instantiateViewController(identifier: "LoginVC") as? LoginViewController else {return}
                
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        })
    }
}

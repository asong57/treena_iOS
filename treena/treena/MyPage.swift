//
//  MyPage.swift
//  treena
//
//  Created by asong on 2021/09/13.
//

import Foundation
import UIKit
import FirebaseAuth

class MyPageViewController: UIViewController {
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var resetPasswordButton: UIButton!
    @IBOutlet weak var withdrawlButton: UIButton!
    
    var user: User!
    var userEmail: String!
    
    override func viewDidLoad() {
        self.user = Auth.auth().currentUser
        self.userEmail = user.email
        
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
}

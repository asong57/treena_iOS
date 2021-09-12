//
//  Login.swift
//  treena
//
//  Created by asong on 2021/09/10.
//

import Foundation
import UIKit
import Firebase

class LoginViewController : UIViewController{
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        
        loginLabel.text = "treena"
        
        if let user = Auth.auth().currentUser {
            loginLabel.text = "이미 로그인 된 상태입니다."
        }
    }
    
    // 로그인 버튼 클릭 이벤트
    // 다음 화면으로 이동
    // 로그인 확인
    @IBAction func loginButtonClick(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: pwTextField.text!) {
            (user, error) in
            if user != nil{
                print("login success")
            }else{
                print("login failed")
            }
        }
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeVC") as? ViewController else {return}
      
        self.navigationController?.pushViewController(nextVC, animated: true) }

   
}

//
//  Login.swift
//  treena
//
//  Created by asong on 2021/09/10.
//

import Foundation
import UIKit

class LoginViewController : UIViewController{
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        
        loginLabel.text = "treena"
    }
    
    // 로그인 버튼 클릭 이벤트
    // 다음 화면으로 이동
    @IBAction func loginButtonClick(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeVC") as? ViewController else {return}
      
        self.navigationController?.pushViewController(nextVC, animated: true) }

   
}

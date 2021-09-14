//
//  Plus.swift
//  treena
//
//  Created by asong on 2021/09/13.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

class PlusViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var diaryTextView: UITextView!
    
    var ref: DatabaseReference!
    var uid: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Firebase Database 연결
        ref = Database.database().reference()
        
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            uid = user?.uid
            print("user exists : \(uid)")
        } else{
            print("user is nil")
        }
        
        // placeholder 세팅
        placeholderSetting()
        
        // textView 테두리 선 주기
        self.diaryTextView.layer.borderWidth = 1.0
        self.diaryTextView.layer.borderColor = UIColor.black.cgColor
    }
    
    func placeholderSetting() {
        // UITextViewDelegate와 연결
        diaryTextView.delegate = self
        
        diaryTextView.text = "오늘은 어떤 일이 있었나요? \n오늘 느꼈던 감정에 집중하면서 감정 단어(ex. 행복했다, 슬펐다, 놀랐다)를 사용해서 일기를 작성해 보세요."
        diaryTextView.textColor = UIColor.lightGray
           
       }
       
       // TextView Place Holder
       func textViewDidBeginEditing(_ textView: UITextView) {
           if textView.textColor == UIColor.lightGray {
               textView.text = nil
               textView.textColor = UIColor.black
           }
       }
    
       // TextView Place Holder
       func textViewDidEndEditing(_ textView: UITextView) {
           if textView.text.isEmpty {
               textView.text = "오늘은 어떤 일이 있었나요? \n오늘 느꼈던 감정에 집중하면서 감정 단어(ex. 행복했다, 슬펐다, 놀랐다)를 사용해서 일기를 작성해 보세요."
               textView.textColor = UIColor.lightGray
           }
       }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        let value: [String: Any] = [ "todaydate" : diaryTextView.text]
        self.ref.child("diary").child(uid).setValue(value)
        print("save success")
    }
}

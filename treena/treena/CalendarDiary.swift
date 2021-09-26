//
//  CalendarDiary.swift
//  treena
//
//  Created by asong on 2021/09/20.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

class CalendarDiaryViewController: UIViewController, UITextViewDelegate{
    
    @IBOutlet weak var thisDateLabel: UILabel!
    @IBOutlet weak var diaryTextView: UITextView!
    
    var date: String!
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
        
        // 날짜 세팅
        let endIdx: String.Index = date.index(date.startIndex, offsetBy: 3)
        let monthStartIdx: String.Index = date.index(date.startIndex, offsetBy: 4)
        let monthEndIdx: String.Index = date.index(date.startIndex, offsetBy: 5)
        let dayStartIdx: String.Index = date.index(date.startIndex, offsetBy: 6)
        let year: String = String(date[...endIdx])
        let month: String = String(date[monthStartIdx...monthEndIdx])
        let day: String = String(date[dayStartIdx...])
        let nowDate = year+"년 "+month+"월 "+day+"일"
        thisDateLabel.text = nowDate
        
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
    
    // 다이어리 내용 저장 
    @IBAction func saveButtonClicked(_ sender: Any) {
        self.ref.child("diary").child(uid).child(date).setValue(diaryTextView.text)
        print("save success")
    }
    
    // 임시저장 
    @IBAction func temporaySaveButtonClicked(_ sender: Any) {
        self.ref.child("diary").child(uid).child(date).setValue(diaryTextView.text)
        print("save success")
    }
}

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
        setDate()
        
        // placeholder 세팅
        placeholderSetting()
                
        // textView 테두리 선 주기
        self.diaryTextView.layer.borderWidth = 1.0
        self.diaryTextView.layer.borderColor = UIColor.black.cgColor
        
        readDiary()
    }
    
    func setDate(){
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
    }
    
    func readDiary(){
        // 데이터 읽어오기
        self.ref.child("diary").child(uid).child(date).getData{ (error, snapshot) in
            if let error = error {
                print("error getting data \(error)")
            }else if snapshot.exists() {
                self.diaryTextView.textColor = UIColor.black
                self.diaryTextView.text = snapshot.value as! String
                print("got data \(snapshot.value!)")
            }else {
                self.placeholderSetting()
                print("No data")
            }
        }
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
    
    // 이전 일기 보기
    @IBAction func beforeDiaryButtonClicked(_ sender: Any) {
        let beforeDate: Int = Int(date)!-1
        date = String(beforeDate)
        checkCalendarDateException(date)
        setDate()
        readDiary()
    }
    
    // 다음 일기 보기
    @IBAction func afterDiaryButtonClicked(_ sender: Any) {
        let beforeDate: Int = Int(date)!+1
        date = String(beforeDate)
        checkCalendarDateException(date)
        setDate()
        readDiary()
    }
    
    // 달력 이동 예외 처리
    func checkCalendarDateException(_ inputDate: String){
        let startDayIdx: String.Index = inputDate.index(inputDate.startIndex, offsetBy: 6)
        var day: Int = Int(String(inputDate[startDayIdx...]))!
        
        let startMonthIdx: String.Index = inputDate.index(inputDate.startIndex, offsetBy: 4)
        let endMonthIdx: String.Index = inputDate.index(inputDate.startIndex, offsetBy: 5)
        var month: Int = Int(String(inputDate[startMonthIdx...endMonthIdx]))!
        
        let endYearIdx: String.Index = inputDate.index(inputDate.startIndex, offsetBy: 3)
        var year: Int = Int(String(inputDate[...endYearIdx]))!
        
        let monthDates = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        
        if day >= 1 && day <= 30{
            return
        }
        
        if month == 2 && day > 28 {
            month = 3
            day = 1
        }
        
        if day == 32 {
            if month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12 {
                month = month+1
                day = 1
            }
        }
        
        if day == 31 {
            if month == 4 || month == 6 || month == 9 || month == 11 {
                month = month+1
                day = 1
                if month == 13 {
                    month = 1
                    year = year+1
                }
            }
            
        }
        
        
        if day == 0 {
            month = month-1
            if month == 0 {
                month = 12
                year = year-1
            }
            day = monthDates[month-1]
        }
        
        var monthString: String = String(month)
        if month < 10 {
            monthString = "0"+monthString
        }
        
        date = String(year) + monthString + String(day)
    }
}

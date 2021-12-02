//
//  Calendar.swift
//  treena
//
//  Created by asong on 2021/09/13.
//

import Foundation
import UIKit
import FSCalendar
import FirebaseDatabase
import FirebaseAuth

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    var calendar = FSCalendar()
    var dates: [Date] = []
    var ref: DatabaseReference!
    var uid: String!
    var date: String!
    var datesWithDiary : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set delegate & datasource
        calendar.delegate = self
        calendar.dataSource = self
        view.addSubview(calendar)
        
        // Firebase Database 연결
        ref = Database.database().reference()
        
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            uid = user?.uid
            print("user exists : \(uid)")
        } else{
            print("user is nil")
        }
        getDiaryDates()
        
    }
    
    // 일기 쓴 날짜 배열 만들기
    func getDiaryDates(){
        // 데이터 읽어오기
        self.ref.child("diary").child(uid).getData{ (error, snapshot) in
            if let error = error {
                print("error getting data \(error)")
            }else if snapshot.exists() {
                let value: [String: String] = snapshot.value as! [String : String]
                for key in value.keys {
                    self.datesWithDiary.append(key)
                }
            }else {
                print("No data")
            }
        }
    }
}


// 달력 클릭이벤트
extension CalendarViewController {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "CalendarDiaryVC") as? CalendarDiaryViewController else {return}
        
        // 날짜를 원하는 형식으로 저장하기 위한 방법입니다.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        nextVC.date = dateFormatter.string(from: date)
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // 홈버튼 클릭이벤트
    @IBAction func homeButtonClicked(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeVC") as? ViewController else {return}
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // 특정 날짜에 이미지 세팅
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        let imageDateFormatter = DateFormatter()
        imageDateFormatter.dateFormat = "yyyyMMdd"
        var dateStr = imageDateFormatter.string(from: date)
        return datesWithDiary.contains(dateStr) ? UIImage(named: "icon_cat") : nil
    }
}

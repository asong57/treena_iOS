//
//  Calendar.swift
//  treena
//
//  Created by asong on 2021/09/13.
//

import Foundation
import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    var calendar = FSCalendar()
    var dates: [Date] = []
    
    fileprivate let datesWithCat = ["20211201","20150605"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set delegate & datasource
        calendar.delegate = self
        calendar.dataSource = self
        view.addSubview(calendar)
        
    }
    
    
    // 일기 쓴 날짜 배열 만들기
    func getDiaryDates(){
        
        
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
        print("date : \(dateStr)")
        return datesWithCat.contains(dateStr) ? UIImage(named: "icon_cat") : nil
    }
}

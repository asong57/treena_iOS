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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set delegate & datasource
        calendar.delegate = self
        calendar.dataSource = self
        
        view.addSubview(calendar)
    }
    
    // 달력 날짜 아래에 이미지 셋
    // FSCalendarDataSource
    func calendar(_ calendar: FSCalendar!, imageFor date: NSDate!) -> UIImage! {
        var anyImage: UIImage! = UIImage(named: "leaf2")
        
        
        return anyImage
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
}

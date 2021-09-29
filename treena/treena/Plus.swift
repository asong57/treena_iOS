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
import Alamofire

class PlusViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var diaryTextView: UITextView!
    @IBOutlet var dateLabel: UILabel!
    
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
        
        // 오늘 날짜 세팅
        let today = Date() //현재 시각 구하기
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 M월 d일"
        var dateString = dateFormatter.string(from: today)
        self.dateLabel.text = dateString
        
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
    
    // 일기 저장
    @IBAction func saveButtonClicked(_ sender: Any) {
        let today = Date() //현재 시각 구하기
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        var dateString = dateFormatter.string(from: today)
        
        self.ref.child("diary").child(uid).child(dateString).setValue(diaryTextView.text)
        print("save success")
        
        // 모델과 연결
        postTest()
    }
    
    // 임시 저장
    @IBAction func temporaySaveButtonClicked(_ sender: Any) {
        let today = Date() //현재 시각 구하기
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        var dateString = dateFormatter.string(from: today)
        
        self.ref.child("diary").child(uid).child(dateString).setValue(diaryTextView.text)
        print("save success")
    }
    
    func postTest() {
            let url = ""
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.timeoutInterval = 10
            
            // POST 로 보낼 정보
        let params = ["context":diaryTextView.text] as Dictionary

            // httpBody 에 parameters 추가
            do {
                try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
            } catch {
                print("http Body Error")
            }
            
        // 인공지능 모델 API 통신 요청
            AF.request(request).responseJSON { (response) in
                switch response.result {
                case .success(let res):
                    print("POST 성공")
                    print(res)
                    
                    do{
                        var emotion: String = ""
                    
                        // response JSON 파싱
                        let data = try? JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
                        emotion = try! JSONDecoder().decode(APIResponse.self, from: data!).answer
                        
                        // 모델에서 얻어온 감정 다음 화면으로 전달
                        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ImageVC") as? EmotionImageViewController else {return}
                        nextVC.emotion = emotion
                        self.navigationController?.navigationBar.tintColor = .black
                        self.navigationController?.navigationBar.topItem?.title = ""
                        self.navigationController?.pushViewController(nextVC, animated: true)
                        
                    } catch(let err) {
                        print(err.localizedDescription)
                    }
                    
                case .failure(let error):
                    print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                }
            }
        }
}

//
//  ViewController.swift
//  treena
//
//  Created by asong on 2021/09/10.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var emotion: String!
    var ref: DatabaseReference!
    var uid: String!
    var diaryUsage: UInt!
    var emotionResults: EmotionResult!
    var treeLevel: Int = 0
    
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
        checkDiaryUsage()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func mypageButtonClicked(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MyPageVC") as? MyPageViewController else {return}
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func plusButtonClicked(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "PlusVC") as? PlusViewController else {return}
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    @IBAction func calendarButtonClicked(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "CalendarVC") as? CalendarViewController else {return}
      
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    func setTreeImage(){
        var treeImageURLList : [String] = ["https://postfiles.pstatic.net/MjAyMTA3MjlfMjA3/MDAxNjI3NTY4NjE3Mjcx.DAnQNog3Cyr18qAv4ke17sWV0Ye3R1bBpiyilMO7J0Qg.dVECs9WmdPKnlH-8DODBy-aqXcA5wBPoVGSHeXcVMyMg.JPEG.hahahafb/wood1.jpg?type=w966",
                                           "https://postfiles.pstatic.net/MjAyMTA3MjlfMTg0/MDAxNjI3NTY4NjE3MzYw.LBABIbXm8OOg_7IkyTfFWN09L5MKulEW8sQe37ivtHQg.-eRZWUupFMLdMiXeGOA5JxB682YG6OSXvmIiufHMPxIg.JPEG.hahahafb/wood2.jpg?type=w966",
                                                    "https://postfiles.pstatic.net/MjAyMTA3MjlfMjEx/MDAxNjI3NTcwMjQwMTky.7FTr3ZXlKzqjDNJFpIozdB0tqhyWhHFPrIg-TxeqsQgg.zzg8zUuKkdcbKct-OYveJOW66nslK5kVqCMEmeiD9JEg.JPEG.hahahafb/wood3.jpg?type=w966",
                                            "https://postfiles.pstatic.net/MjAyMTA3MjlfMjE1/MDAxNjI3NTY4NjE3MzM1.zkDUA6_N9VZVeVvBs1Fq_P9Jarbd1t0gn5HNKfU4Yjcg.vBk5MFsLsDkjR-CaW2W4FC3xkV5bLDVcJ1iSs1kfTeMg.JPEG.hahahafb/wood4.jpg?type=w966",
                                            "https://postfiles.pstatic.net/MjAyMTA3MjlfMjA5/MDAxNjI3NTY4NjE3MzUx.cjKKjFNR1MVkP7jStnxaD5n4TwTzSxZ27m7e4UFaLG8g.3CXyfBGR_oz-chD5Fy9clqgwOBLZ7JOWGDZ6wFtfYO8g.JPEG.hahahafb/wood5.jpg?type=w966",
                                            "https://postfiles.pstatic.net/MjAyMTA3MjlfNjcg/MDAxNjI3NTY4NjE3MzYw.Pjru3AoxNWqDOIhv6Nou9r2L6nSphVWNEMey3v-5704g.Q431roZ5UeD_2te-GnJ1mWERCiYqXgOnvqk9LhC3fbwg.JPEG.hahahafb/wood6.jpg?type=w966",
                                            "https://postfiles.pstatic.net/MjAyMTA3MjlfNTEg/MDAxNjI3NTY4NjE3Mzg1.Em290aKXCBpxn1cqGNH3qt7d-aDEBljoZCaXtsNBfhog.HYBkVjxHr3KbbUGeEbY_igJFJNIw7OWaOPJDVvXOYCcg.JPEG.hahahafb/wood7.jpg?type=w966",
                                           "https://postfiles.pstatic.net/MjAyMTA3MjlfMjAx/MDAxNjI3NTY4NjE3NTkx.7n5dJb1vZXaZ2CMLMjAMRpnB0hfLs0aYYUDJzI3d_aEg.tbvVgbOKnaFw60NgmwBDWlPGh9efxFyMiXfnUsISM_Ig.JPEG.hahahafb/wood8.jpg?type=w966",
                                            "https://postfiles.pstatic.net/MjAyMTA3MjlfMjUg/MDAxNjI3NTY4NjE3Njk1.diWQ2q_gQza_Ll8twVi-eDMNQ-qj534u8HfeyYEbXhQg.vP9slLlDMUibCxJRTzvsn6mtBIXlKANOiiuxJ8mozp8g.JPEG.hahahafb/wood9.jpg?type=w966",
                                            ]
        
        let url = URL(string: treeImageURLList[treeLevel])
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url!){
                        if let image = UIImage(data: data){
                            DispatchQueue.main.async {
                                self.imageView.image = image
                                print(image)
                            }
                        }
                    }
                }
        
        /*
        do {
            let data = try Data(contentsOf: url!)
            imageView.image = UIImage(data: data)
        } catch {
            
        }*/
    }
    
    // 데이터베이스 사용자 일기량 확인 및 setTreeLevel()
    func checkDiaryUsage(){
        self.ref.child("diary").child(uid).getData{ (error, snapshot) in
            if let error = error {
                print("error getting data \(error)")
            }else if snapshot.exists() {
                self.diaryUsage = snapshot.childrenCount
                print("got data \(self.diaryUsage)")
                self.setTreeLevel()
            }else {
                print("No data")
            }
        }
    }
    
    // treeLevel 세팅
    func setTreeLevel(){
        if (diaryUsage <= 2 && diaryUsage >= 0) {
            treeLevel=0;
        }
        if (diaryUsage > 2 && diaryUsage <= 7) {
            treeLevel = 1;
        }
        if (diaryUsage > 7 && diaryUsage <= 14) {
            treeLevel = 2;
        }
        if (diaryUsage > 14 && diaryUsage <= 21) {
            treeLevel = 3;
        }
        if (diaryUsage > 21 && diaryUsage <= 28) {
            treeLevel = 4;
        }
        if (diaryUsage > 28 && diaryUsage <= 35) {
            treeLevel =  5;
        }
        if (diaryUsage > 35 && diaryUsage <= 42) {
            treeLevel = 6;
        }
        if (diaryUsage > 42 && diaryUsage <= 49) {
            treeLevel = 7;
        }
        if (diaryUsage > 49 && diaryUsage <= 56) {
            treeLevel = 8;
        }
        self.setTreeImage()
    }
}


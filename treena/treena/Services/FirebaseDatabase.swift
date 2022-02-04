//
//  FirebaseDatabase.swift
//  treena
//
//  Created by asong on 2021/12/20.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class FirebaseDatabase {
    
    var ref: DatabaseReference!
    var uid: String!
    static var data: UserDiaryState = UserDiaryState(diaryUsage: 20, treeLevel: 2)
    
    func getData(onCompleted: @escaping ([UserDiaryState]) -> Void) {
              /* 만약 통신을 한다면 통신을 모두 하고 난 이후 */
              /* 이스케이핑 클로저를 통해 값을 전달한다. */
        var diaryState: UserDiaryState = UserDiaryState(diaryUsage: 20, treeLevel: FirebaseDatabase.data.treeLevel)
        print("getData")
        print(diaryState.diaryUsage)
            onCompleted([diaryState])
        }
    
    func initilaize(){
        // Firebase Database 연결
        ref = Database.database().reference()
        
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            uid = user?.uid
            print("user exists : \(uid)")
        } else{
            print("user is nil")
        }
    }
    
    // 데이터베이스 사용자 일기량 확인 및 setTreeLevel()
    func checkDiaryUsage(){
        initilaize()
        
        self.ref.child("diary").child(uid).getData{ (error, snapshot) in
            if let error = error {
                print("error getting data \(error)")
            }else if snapshot.exists() {
                FirebaseDatabase.data.diaryUsage = snapshot.childrenCount
                print("got data \(FirebaseDatabase.data.diaryUsage)")
                self.setTreeLevel()
            }else {
                print("No data")
            }
        }
    }
    
    func setTreeLevel(){
        if (FirebaseDatabase.data.diaryUsage <= 2 && FirebaseDatabase.data.diaryUsage >= 0) {
            FirebaseDatabase.data.treeLevel=0;
        }else if (FirebaseDatabase.data.diaryUsage > 2 && FirebaseDatabase.data.diaryUsage <= 7) {
            FirebaseDatabase.data.treeLevel = 1;
        }else if (FirebaseDatabase.data.diaryUsage > 7 && FirebaseDatabase.data.diaryUsage <= 14) {
            FirebaseDatabase.data.treeLevel = 2;
        }else if (FirebaseDatabase.data.diaryUsage > 14 && FirebaseDatabase.data.diaryUsage <= 21) {
            FirebaseDatabase.data.treeLevel = 3;
        }else if (FirebaseDatabase.data.diaryUsage > 21 && FirebaseDatabase.data.diaryUsage <= 28) {
            FirebaseDatabase.data.treeLevel = 4;
        }else if (FirebaseDatabase.data.diaryUsage > 28 && FirebaseDatabase.data.diaryUsage <= 35) {
            FirebaseDatabase.data.treeLevel =  5;
        }else if (FirebaseDatabase.data.diaryUsage > 35 && FirebaseDatabase.data.diaryUsage <= 42) {
            FirebaseDatabase.data.treeLevel = 6;
        }else if (FirebaseDatabase.data.diaryUsage > 42 && FirebaseDatabase.data.diaryUsage <= 49) {
            FirebaseDatabase.data.treeLevel = 7;
        }else if (FirebaseDatabase.data.diaryUsage > 49 && FirebaseDatabase.data.diaryUsage <= 56) {
            FirebaseDatabase.data.treeLevel = 8;
        }
        print("FirebaseDatabase에서 diaryUsage")
        print(FirebaseDatabase.data.diaryUsage)
        
    }
}

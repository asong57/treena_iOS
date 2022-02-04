//
//  ObservableViewModel.swift
//  treena
//
//  Created by asong on 2021/12/20.
//

import Foundation

class ObservableViewModel: ObservableVMProtocol {
    let database: FirebaseDatabase = FirebaseDatabase()
    var storage: Observable<[UserDiaryState]> = Observable([])
    
    func fetchData() {
        database.checkDiaryUsage()
        print("fetch data")
        print(FirebaseDatabase.data.diaryUsage)
        database.getData { response in
            let observable = Observable(response)
            self.storage = observable
        }
    }
    
    func checkTreeLevel() {
        database.checkDiaryUsage()
        database.setTreeLevel()
        
        self.storage = Observable.init([UserDiaryState(diaryUsage: FirebaseDatabase.data.diaryUsage, treeLevel: FirebaseDatabase.data.treeLevel)])
        print("test Firebase data diaryUsage")
        print(FirebaseDatabase.data.diaryUsage)
        //
    }
    
    func setError(_ message: String) {
        
    }
    
    
        
    var errorMessage: Observable<String?> = Observable(nil)
        
    var error: Observable<Bool> = Observable(false)
}

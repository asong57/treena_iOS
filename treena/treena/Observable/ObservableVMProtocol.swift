
import Foundation

protocol ObservableVMProtocol {
    associatedtype T
    
    // 데이터를 가져옵니다.
    func fetchData()
    
    // treeLevel을 확인합니다.
    func checkTreeLevel()
    
    // 에러를 처리합니다.
    func setError(_ message: String)
    
    // 원본데이터
    var storage: Observable<[T]> { get set }
    
    // 에러 메세지
    var errorMessage: Observable<String?> { get set }
    
    // 에러
    var error: Observable<Bool> { get set }
}

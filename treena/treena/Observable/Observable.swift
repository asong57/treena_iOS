
import Foundation

class Observable<T> {
    // 3) 호출되면, 2번에서 받은 값을 전달한다.
    private var listener: ((T) -> Void)?
    
    // 2) 값이 set되면, listener에 해당 값을 전달한다,
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    // 1) 초기화함수를 통해서 값을 입력받고, 그 값을 "value"에 저장한다.
    init(_ value: T) {
        self.value = value
    }
    
    // 4) 다른 곳에서 bind라는 메소드를 호출하게 되면,
    // value에 저장했던 값을 전달해주고,
    // 전달받은 "closure" 표현식을 listener에 할당한다.
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}

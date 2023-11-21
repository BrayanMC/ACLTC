//
//  Observable.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

class Observable<T> {
    
    var value: T? {
        didSet {
            self.listener?(self.value)
        }
    }
    
    init( _ value: T?) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    
    func bind( _ listener: @escaping ((T?)) -> Void) {
        listener(value)
        self.listener = listener
    }
}


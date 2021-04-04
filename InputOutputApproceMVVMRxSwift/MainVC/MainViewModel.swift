//
//  MainViewModel.swift
//  InputOutputApproceMVVMRxSwift
//
//  Created by Mahmoud Abdul-Wahab on 04/04/2021.
//

import Foundation
import RxSwift
import RxCocoa


//MARK:- Input/Output Protocol
protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var input:  Input! {get}
    var output: Output! {get}
}

//MARK:-  ViewModel

class MainViewModel: ViewModelType{
    
    struct  Input {
        let nameText: AnyObserver<String>
        let validateBtnAction: AnyObserver<Void>
    }
    
    struct  Output {
        let validName:Driver<String>
    }
    
    private(set) var input: Input!
    private(set) var output: Output!
    
    private let nameTextSubject = ReplaySubject<String>.create(bufferSize: 1)
    private let validateBtnAction = PublishSubject<Void>()
    
    private let validNameSubject = ReplaySubject<String>.create(bufferSize: 1)

    
    
    init() {
        
        input = Input(nameText: nameTextSubject.asObserver(), validateBtnAction: validateBtnAction.asObserver())
        
        let validateOperation = validateName()
        output = Output(validName:validateOperation)
    }
  
    func validateName()->Driver<String>{
        return validateBtnAction
            .withLatestFrom(nameTextSubject)
            .map{ return "Welcom 😎 " + $0}
            .asDriver(onErrorJustReturn: "You arn't mahmoud")
    }
}

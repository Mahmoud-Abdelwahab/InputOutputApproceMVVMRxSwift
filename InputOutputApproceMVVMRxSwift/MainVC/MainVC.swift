//
//  MainVC.swift
//  InputOutputApproceMVVMRxSwift
//
//  Created by Mahmoud Abdul-Wahab on 03/04/2021.
//

import UIKit
import RxSwift
import RxCocoa

class MainVC: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var validateBtnOutlite: UIButton!
    
    let bag = DisposeBag()
    var mainViewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Binding inputs
        nameTF.rx.text.orEmpty
            .bind(to: mainViewModel.input.nameText)
            .disposed(by: bag)
        
        validateBtnOutlite.rx.controlEvent(.touchUpInside)
            .bind(to: mainViewModel.input.validateBtnAction)
            .disposed(by: bag)
        
        //Binding Output
        
        mainViewModel.output.validName.drive(onNext: { [weak self] in
            guard let self = self else{return}
            self.nameLable.rx.text.onNext($0)
        }).disposed(by: bag)
        
    }


}


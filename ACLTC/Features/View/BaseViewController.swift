//
//  BaseViewController.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

class BaseViewController: UIViewController {
    
    weak var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.dismissKeyboard()
    }
    
    /*
     internal func showErrorPopUp(viewData: CambixPopUpViewData) {
         coordinator?.showCambixPopUp(viewData: viewData)
     }
     */
}

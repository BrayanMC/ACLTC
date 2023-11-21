//
//  SplashController.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

class SplashController: BaseViewController, Storyboarded {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.goToLogInView()
        }
    }
    
    private func initViews() {
        view.applyGradient()
    }
    
    private func goToLogInView() {
        coordinator?.goToLogInView()
    }
}

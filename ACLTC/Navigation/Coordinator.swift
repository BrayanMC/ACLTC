//
//  Coordinator.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

class Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToSplash()
    }
    
    func goToSplash() {
        let vc = SplashController.instantiate(StoryboardIds.Splash)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToLogInView() {
        
    }
}

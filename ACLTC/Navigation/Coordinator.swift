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
    
    func goToSignInView() {
        let vc = SignInController.instantiate(StoryboardIds.SignIn)
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func goToSignUp() {
        let vc = SignUpController.instantiate(StoryboardIds.SignUp)
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func goToEarthquakesView() {
        let vc = EarthquakesController.instantiate(StoryboardIds.Earthquakes)
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func goToFiltersView(viewData: FilterViewData) {
        let vc = FiltersController.instantiate(StoryboardIds.Filters)
        vc.coordinator = self
        vc.viewData = viewData
        vc.modalPresentationStyle = .overCurrentContext
        navigationController.present(vc, animated: true)
    }
    
    func goToDetail(viewData: DetailViewData) {
        let vc = DetailController.instantiate(StoryboardIds.Detail)
        vc.coordinator = self
        vc.viewData = viewData
        vc.modalPresentationStyle = .overCurrentContext
        navigationController.present(vc, animated: true)
    }
    
    func showACLPopUp(viewData: ACLPopUpViewData) {
        let vc = ACLPopUpController.instantiate(StoryboardIds.ACLPopUp)
        vc.coordinator = self
        vc.viewData = viewData
        vc.modalPresentationStyle = .overCurrentContext
        navigationController.present(vc, animated: true)
    }
}

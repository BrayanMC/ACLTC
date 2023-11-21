//
//  ProgressFacade.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

class ProgressFacade {
    
    static func showProgress() {
        let progressView = ProgressView.shared
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
            progressView.frame = keyWindow.bounds
            keyWindow.addSubview(progressView)
            progressView.setUp()
            progressView.startAnimating()
        }
    }

    static func hideProgress() {
        let progressView = ProgressView.shared
        progressView.stopAnimating()
        progressView.removeFromSuperview()
    }
}

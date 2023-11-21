//
//  ProgressView.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

class ProgressView: UIView {
    
    static let shared = ProgressView()
    private var timer: Timer?
    private var indicatorImageView = UIImageView()
    private var backgroundView = UIView()
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setUp() {
        backgroundView.frame = bounds
        backgroundView.backgroundColor = ColorManager.shared.black400.withAlphaComponent(0.75)
        indicatorImageView.image = ImageManager.shared.circularIndicator
        let imageViewSize = CGSize(width: 40, height: 40) // Tamaño deseado
        let imageViewX = (bounds.size.width - imageViewSize.width) / 2
        let imageViewY = (bounds.size.height - imageViewSize.height) / 2
        indicatorImageView.frame = CGRect(x: imageViewX, y: imageViewY, width: imageViewSize.width, height: imageViewSize.height)
        backgroundView.addSubview(indicatorImageView)
        addSubview(backgroundView)
    }
    
    public func startAnimating() {
        indicatorImageView.isHidden = false
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
        }
    }
    
    public func stopAnimating() {
        indicatorImageView.isHidden = true
        stopTimer()
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func animateView() {
        UIView.animate(withDuration: 0.8, delay: 0.0, options: .curveLinear, animations: {
            self.indicatorImageView.transform = self.indicatorImageView.transform.rotated(by: CGFloat(Double.pi))
        }, completion: { (finished) in
            if self.timer != nil {
                self.timer = Timer.scheduledTimer(timeInterval: 0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
            }
        })
    }
}

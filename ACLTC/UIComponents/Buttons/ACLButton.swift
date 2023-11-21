//
//  ACLButton.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

public class ACLButton: UIButton {
    
    private var indicatorImageView: UIImageView?
    private var _code: Int = ACLButtonCodes.primary.rawValue
    private var timer: Timer?
    
    @IBInspectable var code: Int {
          get {
            return _code
          }
          set {
            _code = Int(newValue)
            updateStyles()
          }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customBuilder()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customBuilder()
    }

    private func customBuilder() {
        cornerRadius = 10
        titleLabel?.setLineHeight(UIFont.LineHeight.body1.value)
        setPrimaryButton()
    }
    
    private func updateStyles() {
        switch _code {
        case ACLButtonCodes.primary.rawValue:
            setPrimaryButton()
            break
        case ACLButtonCodes.secondary.rawValue:
            setSecondaryButton()
            break
        default: break
        }
    }

    public func mode(isActive: Bool) {
        if (isActive) {
            enable()
        } else {
            disable()
        }
    }
    
    public func setTitle(_ title: String) {
        setTitle(title, for: .normal)
        setTitle(title, for: .disabled)
        setTitle(title, for: .selected)
        setTitle(title, for: .highlighted)
    }

    public func setPrimaryButton() {
        titleLabel?.font = UIFont.body1Bold
        titleLabel?.textColor = ColorManager.shared.white
        titleLabel?.tintColor = ColorManager.shared.white
        backgroundColor = ColorManager.shared.red
    }
    
    public func setSecondaryButton() {
        titleLabel?.font = UIFont.body1Bold
        titleLabel?.textColor = ColorManager.shared.red
        titleLabel?.tintColor = ColorManager.shared.red
        backgroundColor = ColorManager.shared.white
        layer.borderWidth = 1.0
        layer.borderColor = ColorManager.shared.red.cgColor
    }
    
    public func enable() {
        isEnabled = true
        isUserInteractionEnabled = true
        backgroundColor = ColorManager.shared.red
    }

    public func disable() {
        isEnabled = false
        isUserInteractionEnabled = false
        backgroundColor = ColorManager.shared.secondary100
    }
    
    private func createIndicator() {
        indicatorImageView = UIImageView(image: ImageManager.shared.buttonCircularIndicator)
        guard let _ = indicatorImageView else {
            return
        }
        addSubview(indicatorImageView!)
        indicatorImageView?.translatesAutoresizingMaskIntoConstraints = false
        indicatorImageView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        indicatorImageView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        indicatorImageView?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicatorImageView?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    public func showProgressIndicator() {
        createIndicator()
        indicatorImageView?.isHidden = false
        titleLabel?.layer.opacity = 0.0
        isEnabled = false
        isUserInteractionEnabled = false
        startTimer()
    }
    
    private func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.0, target: self, selector: #selector(animateView), userInfo: nil, repeats: false)
        }
    }
    
    public func stopProgressIndicator() {
        indicatorImageView?.isHidden = true
        titleLabel?.layer.opacity = 1
        isEnabled = true
        isUserInteractionEnabled = true
        stopTimer()
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func animateView() {
        guard let _ = indicatorImageView else {
            return
        }
        UIView.animate(withDuration: 0.8, delay: 0.0, options: .curveLinear, animations: {
            self.indicatorImageView!.transform = self.indicatorImageView!.transform.rotated(by: CGFloat(Double.pi))
        }, completion: { (finished) in
            if self.timer != nil {
                self.timer = Timer.scheduledTimer(timeInterval: 0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
            }
        })
    }
}

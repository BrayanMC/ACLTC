//
//  ACLNavigationBar.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

public class ACLNavigationBar: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var barBackButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var barDismissButton: UIButton!
    
    private weak var delegate: ACLNavigationBarProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    private func initView() {
        Bundle.main.loadNibNamed(ACLNavigationBar.nibName, owner: self, options: nil)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(contentView)
    }
    
    convenience init(
        delegate: ACLNavigationBarProtocol? = nil,
        type: ACLNavigationBarType,
        title: String = ""
    ) {
        self.init(frame: .zero)
        displayView(delegate: delegate, type: type, title: title)
    }
    
    public func displayView(
        delegate: ACLNavigationBarProtocol? = nil,
        type: ACLNavigationBarType,
        title: String = ""
    ) {
        self.delegate = delegate
        switch type {
        case .regularView:
            backgroundView.applyGradient()
            barBackButton.setImage(ImageManager.shared.icLeftArrow, for: .normal)
            titleLabel.textColor = ColorManager.shared.white
            barBackButton.isHidden = false
            break
        case .fullScreenModal:
            barBackButton.setImage(ImageManager.shared.icLeftArrow, for: .normal)
            titleLabel.textColor = ColorManager.shared.black300
            barDismissButton.isHidden = false
            break
        }
        titleLabel.text = title
        titleLabel.setLineHeight(24.0, lineHeightMultiple: 0.91)
    }
    
    @IBAction func barDismissButtonTapped(_ sender: Any) {
        delegate?.dismissButtonTapped()
    }
    
    @IBAction func barBackButtonTapped(_ sender: Any) {
        delegate?.backButtonTapped()
    }
}


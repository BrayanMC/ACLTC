//
//  ACLButtonCell.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

public class ACLButtonCell: UICollectionViewCell {
    
    @IBOutlet weak var aclButton: ACLButton!
    
    private var index: Int = 0
    var onViewDidPress: ((Int) -> Void)?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    
    private func initView() {
        aclButton.translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
    }
    
    public func buildButton(title: String, type: ACLPopUpButtonType, index: Int) {
        self.index = index
        aclButton.setTitle(title, for: .normal)
        switch type {
        case .primary:
            aclButton.code = 1
            break
        case .secondary:
            aclButton.code = 2
            break
        }
    }
    
    @IBAction private func aclButtonTapped(_ sender: UIButton ) {
        onViewDidPress?(index)
    }
}


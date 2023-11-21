//
//  ACLPopUpController.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

public enum ActionsOrientation {
    case horizontal
    case vertical
}

protocol ACLPopUpControllerProtocol: AnyObject {
    func animateDisappearPopUp(handler: (() -> Void)?)
}

public class ACLPopUpController: UIViewController, Storyboarded {
    
    @IBOutlet private weak var viewBackground: UIView!
    @IBOutlet private weak var viewForm: UIView!
    @IBOutlet weak var actionsCollectionView: UICollectionView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var actionsCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var actionsSideConstraints: [NSLayoutConstraint]!
    
    private let orientation: ActionsOrientation = .horizontal
    var viewData: ACLPopUpViewData?
    weak var coordinator: Coordinator?
    private let lineSpacing: CGFloat = 8.0
    private let actionHeight: CGFloat = 38.0
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        setUpFormInformation()
        setDelegates()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateAppearPopUp()
    }
    
    private func initView() {
        viewBackground.alpha = 0.0
        viewForm.alpha = 0.0
        viewBackground.addTapGesture(self, action: #selector(dismissPopUp(_:)))
        actionsSideConstraints.forEach { (constraint) in
            constraint.constant = 18
        }
        
        switch orientation {
        case .vertical:
            let count = viewData?.actions.count ?? 0
            actionsCollectionViewHeightConstraint.constant = (actionHeight * CGFloat(count)) + (lineSpacing * CGFloat(count - 1))
            break
        case .horizontal:
            break
        }
    }
    
    private func setDelegates() {
        actionsCollectionView.delegate = self
        actionsCollectionView.dataSource = self
        actionsCollectionView.register(cell: ACLButtonCell.self)
        switch orientation {
        case .vertical:
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = lineSpacing
            layout.scrollDirection = .vertical
            actionsCollectionView.collectionViewLayout = layout
            break
        case .horizontal:
            break
        }
    }
    
    func setUpFormInformation() {
        if let _viewData = viewData {
            titleLabel.text = _viewData.title
            if (_viewData.boldHighlighting) {
                descriptionLabel.attributedText = _viewData.description.addAttributeText(texts: _viewData.boldTexts, color: descriptionLabel.textColor, font: .body2Bold)
                descriptionLabel.textAlignment = .center
            } else if (_viewData.description.contains("<b>") && _viewData.description.contains("</b>")) {
                let results = _viewData.description.extractContentBetweenBTags()
                if let description = _viewData.description.stripHTMLTags() {
                    descriptionLabel.attributedText = description.addAttributeText(texts: results, color: descriptionLabel.textColor, font: .body1Bold)
                    descriptionLabel.textAlignment = .center
                }
            } else {
                descriptionLabel.text = _viewData.description
            }
            switch _viewData.popUpType {
            case .error:
                iconImageView.image = ImageManager.shared.icACLPopUpAlert
                break
            case .noInternet:
                iconImageView.image = ImageManager.shared.icACLPopUpNoInternet
                break
            case .custom(let imageType):
                iconImageView.image = imageType.getImage()
                break
            }
        }
    }
    
    @objc func dismissPopUp(_ gesture: UITapGestureRecognizer) {
        animateDisappearPopUp(handler: nil)
    }
    
    func animateAppearPopUp() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .calculationModeLinear) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                self.viewBackground.alpha = 1.0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.viewForm.alpha = 1.0
            }
        } completion: { _ in }
    }
}

extension ACLPopUpController: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewData?.actions.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ACLButtonCell = collectionView.dequeue(for: indexPath)
        cell.buildButton(title: viewData?.actions[indexPath.row].title ?? "", type: viewData?.actions[indexPath.row].type ?? .primary, index: indexPath.row)
        cell.onViewDidPress = { [weak self] (index) -> Void in
            self?.animateDisappearPopUp { [self] in
                self?.viewData?.actions[index].handler?()
            }
        }
        return cell
    }
}

extension ACLPopUpController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension ACLPopUpController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (viewData?.actions.count ?? 0 > 1) {
            switch orientation {
            case .vertical:
                return CGSize(width: collectionView.frame.size.width, height: actionHeight)
            case .horizontal:
                let numberOfItemsPerRow: CGFloat = CGFloat(viewData?.actions.count ?? 1)
                let spacingBetweenCells: CGFloat = 8.0
                let totalSpacing = ((numberOfItemsPerRow - 1) * spacingBetweenCells)
                let itemWidth = (collectionView.frame.size.width - totalSpacing) / CGFloat(numberOfItemsPerRow)
                return CGSize(width: itemWidth, height: actionHeight)
            }
        } else {
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        }
    }
}

extension ACLPopUpController: ACLPopUpControllerProtocol {
    
    func animateDisappearPopUp(handler: (() -> Void)?) {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .calculationModeLinear) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                self.viewForm.alpha = 0.0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.viewBackground.alpha = 0.0
            }
        } completion: {_ in
            handler?()
            self.dismiss(animated: false)
        }
    }
}

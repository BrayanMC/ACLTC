//
//  EarthquakeViewCell.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

import UIKit

class EarthquakeViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var magnitudeLabel: UILabel!
    @IBOutlet weak var depthLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var seeImageView: UIImageView!
    
    var onViewDidPress: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestures()
    }
    
    private func addGestures() {
        seeImageView.addTapGesture(self, action: #selector(didDidPress))
    }
    
    private func setLoadingView(showShimmer: Bool) {
        seeImageView.isHidden = showShimmer
        titleLabel.isShimmer(showShimmer, cornerRadius: 8)
        magnitudeLabel.isShimmer(showShimmer, cornerRadius: 8)
        depthLabel.isShimmer(showShimmer, cornerRadius: 8)
        placeLabel.isShimmer(showShimmer, cornerRadius: 8)
    }
    
    func displayShimmers() {
        setLoadingView(showShimmer: true)
    }
    
    func setUpCell(_ feature: Earthquake.Feature) {
        setLoadingView(showShimmer: false)
        titleLabel.text = feature.properties.title
        magnitudeLabel.text = String(format: "DETAIL_MAGNITUDE_TEXT".localized, feature.properties.mag.formatWithTwoDecimals())
        depthLabel.text = String(format: "DETAIL_DEPTH_TEXT".localized, feature.geometry.coordinates[2].formatWithTwoDecimals())
        placeLabel.text = String(format: "DETAIL_PLACE_TEXT".localized, feature.properties.place)
    }
    
    @objc func didDidPress(gesture: UILongPressGestureRecognizer) {
        onViewDidPress?()
    }
}


//
//  DetailController.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

import UIKit
import GoogleMaps

class DetailController: BaseViewController, Storyboarded {
    
    @IBOutlet weak var aclNavigationBar: ACLNavigationBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var magnitudeLabel: UILabel!
    @IBOutlet weak var depthLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var contentMapView: GMSMapView!
    //@IBOutlet weak var mapView: GMSMapView!
    
    private var mapView: GMSMapView?
    var viewData: DetailViewData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        setUpInformation()
    }
    
    private func initViews() {
        aclNavigationBar.displayView(delegate: self, type: .fullScreenModal, title: .empty)
    }
    
    private func setUpInformation() {
        if let _viewData = viewData {
            titleLabel.text = _viewData.title
            magnitudeLabel.text = String(format: "DETAIL_MAGNITUDE_TEXT".localized, _viewData.mag.formatWithTwoDecimals())
            depthLabel.text = String(format: "DETAIL_DEPTH_TEXT".localized, _viewData.depth.formatWithTwoDecimals())
            placeLabel.text = String(format: "DETAIL_PLACE_TEXT".localized, _viewData.place)
            setUpMap(latitude: _viewData.coordinates[0], longitude: _viewData.coordinates[1])
        }
    }
    
    private func setUpMap(latitude: Double, longitude: Double) {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let camera = GMSCameraPosition(target: location, zoom: 10, bearing: 0, viewingAngle: 0)
        mapView = GMSMapView.map(withFrame: contentMapView.bounds, camera: camera)
        if let _mapView = mapView {
            contentMapView.addSubview(_mapView)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                _mapView.animate(to: camera)
                self.addMarker(location)
            }
        }
    }
    
    private func addMarker(_ location: CLLocationCoordinate2D) {
        if let _mapView = mapView {
            let marker = GMSMarker()
            marker.position = location
            marker.map = _mapView
            marker.snippet = "\(location.latitude),\(location.longitude)"
            debugPrint("\(location.latitude),\(location.longitude)")
        }
    }
}

extension DetailController: ACLNavigationBarProtocol {
    
    func rightButtonTapped() {
        dismiss(animated: true)
    }
    
    func leftButtonTapped() {
    }
}

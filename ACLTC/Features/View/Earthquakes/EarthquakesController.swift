//
//  EarthquakesController.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

import UIKit

class EarthquakesController: BaseViewController, Storyboarded {
    
    @IBOutlet weak var aclNavigationBar: ACLNavigationBar!
    @IBOutlet weak var openFiltersView: UIView!
    @IBOutlet weak var selectedDatesLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var earthquakesView: UIView!
    @IBOutlet weak var earthquakesTableView: UITableView!
    @IBOutlet weak var earthquakesHeightConstraint: NSLayoutConstraint!
    
    private lazy var viewModel = EarthquakeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        bind()
        setDelegates()
        getEarthquakes()
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        setEarthquakesListHeightConstraint()
    }
    
    private func initViews() {
        view.applyGradient()
        aclNavigationBar.displayView(delegate: self, type: .logOut, title: .empty)
        addGestures()
    }
    
    private func addGestures() {
        openFiltersView.addTapGesture(self, action: #selector(didDidPress))
    }
    
    private func bind() {
        viewModel.features.bind { [weak self] result in
            guard self != nil else { return }
            guard let _result = result else { return }
            if (_result.isEmpty) {
                self?.emptyView.isHidden = false
                self?.earthquakesView.isHidden = true
            } else {
                self?.emptyView.isHidden = true
                self?.earthquakesView.isHidden = false
                self?.earthquakesTableView.reloadData()
                self?.setEarthquakesListHeightConstraint()
            }
        }
        
        viewModel.popUpError.bind { [weak self] result in
            guard self != nil else { return }
            guard let _result = result else { return }
            self?.earthquakesTableView.reloadData()
            self?.showErrorPopUp(viewData: _result)
        }
    }
    
    private func setEarthquakesListHeightConstraint() {
        earthquakesHeightConstraint.constant = earthquakesTableView.intrinsicContentSize.height
    }
    
    private func setDelegates() {
        earthquakesTableView.delegate = self
        earthquakesTableView.dataSource = self
        earthquakesTableView.register(EarthquakeViewCell.self)
    }
    
    private func getEarthquakes() {
        let startTime = UtilsManager.formatDateToString(date: Date(), toFormat: DateFormats.yyyy_MM_dd)
        let endTime = UtilsManager.formatDateToString(date: Date(), toFormat: DateFormats.yyyy_MM_dd)
        setSelectedDateLabel()
        viewModel.getEarthquakes(GetEarthquakeParam(startTime: startTime, endTime: endTime))
    }
    
    private func setSelectedDateLabel(_ startTime: Date = Date(), _ endTime: Date = Date()) {
        let sameDay = Calendar.current.isDate(startTime, equalTo: endTime, toGranularity: .day)
        if (sameDay) {
            let selectedDate = String(format: "TEXT_DATE".localized, UtilsManager.getDateFormat(date: startTime, format: "dd"), UtilsManager.getDateFormat(date: startTime, format: "MMMM"))
            self.selectedDatesLabel.attributedText = selectedDate
                .addAttributeText(color: ColorManager.shared.black400, font: .caption1Bold, isUnderline: true)
        } else {
            let selectedDateFrom = String(format: "TEXT_DATE".localized, UtilsManager.getDateFormat(date: startTime, format: "dd"), UtilsManager.getDateFormat(date: startTime, format: "MMMM"))
            let selectedDateTo = String(format: "TEXT_DATE".localized, UtilsManager.getDateFormat(date: endTime, format: "dd"), UtilsManager.getDateFormat(date: endTime, format: "MMMM"))
            let selectedDate = String(format: "TEXT_DATE_FROM_TO".localized, selectedDateFrom, selectedDateTo)
            self.selectedDatesLabel.attributedText = selectedDate
                .addAttributeText(texts: [selectedDateFrom, selectedDateTo], color: ColorManager.shared.black400, font: .caption1Bold, isUnderline: true)
        }
    }
    
    @objc func didDidPress(gesture: UILongPressGestureRecognizer) {
        coordinator?.goToFiltersView(viewData: FilterViewData(callback: { date in
            self.emptyView.isHidden = true
            self.earthquakesView.isHidden = false
            self.setSelectedDateLabel(date.startTime, date.endTime)
            let startTime = UtilsManager.formatDateToString(date: date.startTime, toFormat: DateFormats.yyyy_MM_dd)
            let endTime = UtilsManager.formatDateToString(date: date.endTime, toFormat: DateFormats.yyyy_MM_dd)
            self.viewModel.getEarthquakes(GetEarthquakeParam(startTime: startTime, endTime: endTime))
        }))
    }
}

extension EarthquakesController: ACLNavigationBarProtocol {
    
    func rightButtonTapped() {
    }
    
    func leftButtonTapped() {
        coordinator?.goToLogInView()
    }
}

extension EarthquakesController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let features = viewModel.features.value {
            if indexPath.row == features.count - 1 {
                viewModel.loadNextPage()
            }
        }
    }
}

extension EarthquakesController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let earthquakes = viewModel.features.value {
            return earthquakes.count
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EarthquakeViewCell = tableView.dequeueCell(forIndexPath: indexPath)
        if let features = viewModel.features.value {
            let feature: Earthquake.Feature = features[indexPath.row]
            cell.setUpCell(feature)
            cell.onViewDidPress = { [weak self] () -> Void in
                guard self != nil else { return }
                let viewData = DetailViewData(
                    title: feature.properties.title ?? "",
                    mag: feature.properties.mag ?? 0.00,
                    place: feature.properties.place ?? "",
                    depth: feature.geometry.coordinates[2],
                    coordinates: [feature.geometry.coordinates[1], feature.geometry.coordinates[0]]
                )
                self?.coordinator?.goToDetail(viewData: viewData)
            }
            return cell
        }
        cell.displayShimmers()
        return cell
    }
}

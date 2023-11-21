//
//  EarthquakeViewModel.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

final class EarthquakeViewModel: BaseViewModel {
    
    lazy var eventService: EventService = EventServiceImpl()
    
    var earthquake: Observable<Earthquake> = Observable(nil)
    var features: Observable<[Earthquake.Feature]> = Observable(nil)
    private var displayedItems: [Earthquake.Feature] = []
    private var currentPage = 0
    private let itemsPerPage = 10
    
    func getEarthquakes(_ params: GetEarthquakeParam) {
        eventService.getEarthquakes(params) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                if let _data = data {
                    self?.earthquake.value = _data
                    self?.loadNextPage()
                }
            case .failure(let error):
                switch error {
                case .notConnectedToInternet(let data):
                    self?.loading.value = false
                    self?.popUpError.value = self?.buildErrorPopUpViewData(
                        title: "POP_UP_NO_INTERNET_TITLE".localized,
                        description: data?.message ?? "",
                        type: .noInternet,
                        buttonTitle: "POP_UP_TRY_AGAIN_BUTTON_TITLE".localized,
                        completion: {
                            self?.getEarthquakes(params)
                        }
                    )
                default:
                    self?.loading.value = false
                    self?.popUpError.value = self?.buildErrorNotContemplatedPopUpViewData(
                        completion: {
                            self?.getEarthquakes(params)
                        }
                    )
                }
            }
        }
    }
    
    func loadNextPage() {
        let startIndex = currentPage * itemsPerPage
        let endIndex = (currentPage + 1) * itemsPerPage
        if let _earthquake = earthquake.value {
            if let _features = _earthquake.features {
                if (!_features.isEmpty) {
                    let newItems = Array(_features[startIndex..<endIndex] )
                    displayedItems.append(contentsOf: newItems)
                    currentPage += 1
                    features.value = displayedItems
                } else {
                    features.value = []
                }
            } else {
                features.value = []
            }
        } else {
            features.value = []
        }
    }
}

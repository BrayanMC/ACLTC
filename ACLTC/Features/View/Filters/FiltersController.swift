//
//  FiltersController.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

import UIKit

class FiltersController: BaseViewController, Storyboarded {
    
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var bottomSheetView: UIView!
    @IBOutlet weak var startTimeACLTextField: ACLTextField!
    @IBOutlet weak var endTimeACLTextField: ACLTextField!
    @IBOutlet weak var filterACLButton: ACLButton!
    
    private let datePicker = UIDatePicker()
    var viewData: FilterViewData?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bottomSheetView.animateBottomSheet(show: true) {
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        bottomSheetView.roundTopCorners(radius: 16.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        addGestures()
    }
    
    private func initViews() {
        startTimeACLTextField.displayView(id: 1, eventsDelegate: self, placeholder: "FILTERS_START_DATE".localized, isCounterHidden: true, textFieldType: .Date)
        endTimeACLTextField.displayView(id: 2, eventsDelegate: self, placeholder: "FILTERS_END_DATE".localized, isEnabled: false, isCounterHidden: true, textFieldType: .Date)
        filterACLButton.disable()
    }
    
    private func addGestures() {
        overlayView.addTapGesture(self, action:  #selector(overlayViewTapped))
    }
    
    @objc func overlayViewTapped(_ sender: UITapGestureRecognizer) {
        bottomSheetView.animateBottomSheet(show: false) {
            self.dismiss(animated: false)
        }
    }
    
    @IBAction func saveCustomButtonTapped(_ sender: Any) {
        bottomSheetView.animateBottomSheet(show: false) {
            self.dismiss(animated: false) {
                if let _viewData = self.viewData {
                    _viewData.callback?(
                        SelectedDate(
                            startTime: self.startTimeACLTextField.getSelectedDate(),
                            endTime: self.endTimeACLTextField.getSelectedDate()
                        )
                    )
                }
            }
        }
    }
}

extension FiltersController: ACLTextFieldEventsProtocol {
    
    func editingDidBegin(id: Int, _ text: String) {
    }
    
    func editingDidEnd(id: Int, _ text: String) {
        switch id {
        case startTimeACLTextField.getId():
            endTimeACLTextField.enable()
            endTimeACLTextField.setMinimumDate(startTimeACLTextField.getSelectedDate())
            break
        case endTimeACLTextField.getId():
            filterACLButton.enable()
            break
        default:
            break
        }
    }
    
    func editingChanged(id: Int, _ text: String) {
    }
}

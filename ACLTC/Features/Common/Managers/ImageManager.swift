//
//  ImageManager.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

public final class ImageManager {
    
    public static let shared: ImageManager = ImageManager()

    private init() { }
    
    public var check: UIImage = UIImage(named: "check") ?? UIImage()
    public var uncheck: UIImage = UIImage(named: "uncheck") ?? UIImage()
    public var eyeClosed: UIImage = UIImage(named: "eye_closed") ?? UIImage()
    public var eye: UIImage = UIImage(named: "eye") ?? UIImage()
    public var icLeftArrow: UIImage = UIImage(named: "ic_left_arrow") ?? UIImage()
    public var icClose: UIImage = UIImage(named: "ic_close") ?? UIImage()
    public var icLogOut: UIImage = UIImage(named: "ic_log_out") ?? UIImage()
    public var buttonCircularIndicator: UIImage = UIImage(named: "button_circular_indicator") ?? UIImage()
    public var icACLPopUpAlert: UIImage = UIImage(named: "ic_acl_pop_up_alert") ?? UIImage()
    public var icACLPopUpNoInternet: UIImage = UIImage(named: "ic_acl_pop_up_no_internet") ?? UIImage()
    public var icACLPopUpMoneyManagement: UIImage = UIImage(named: "ic_cacl_pop_up_money_management") ?? UIImage()
    public var circularIndicator: UIImage = UIImage(named: "circular_indicator") ?? UIImage()
}

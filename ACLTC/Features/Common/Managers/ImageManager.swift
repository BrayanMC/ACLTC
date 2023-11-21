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
    
    public var bottomMenuBenefits: UIImage = UIImage(named: "bottom_menu_benefits") ?? UIImage()
    public var bottomMenuPoints: UIImage = UIImage(named: "bottom_menu_points") ?? UIImage()
    public var bottomMenuChangeAlert: UIImage = UIImage(named: "bottom_menu_change_alert") ?? UIImage()
    public var bottomMenuOperations: UIImage = UIImage(named: "bottom_menu_operations") ?? UIImage()
    public var bottomMenuArrowCollapse: UIImage = UIImage(named: "bottom_menu_arrow_collapse") ?? UIImage()
    public var bottomMenuArrowExpand: UIImage = UIImage(named: "bottom_menu_arrow_expand") ?? UIImage()
    public var icLeftArrow: UIImage = UIImage(named: "ic_left_arrow") ?? UIImage()
    public var tooltipPENCCI: UIImage = UIImage(named: "tooltip_pen_cci") ?? UIImage()
    public var tooltipDollarCCI: UIImage = UIImage(named: "tooltip_dollar_cci") ?? UIImage()
    public var buttonCircularIndicator: UIImage = UIImage(named: "button_circular_indicator") ?? UIImage()
    public var icACLPopUpAlert: UIImage = UIImage(named: "ic_acl_pop_up_alert") ?? UIImage()
    public var icACLPopUpNoInternet: UIImage = UIImage(named: "ic_acl_pop_up_no_internet") ?? UIImage()
    public var icACLPopUpMoneyManagement: UIImage = UIImage(named: "ic_cacl_pop_up_money_management") ?? UIImage()
    public var circularIndicator: UIImage = UIImage(named: "circular_indicator") ?? UIImage()
}

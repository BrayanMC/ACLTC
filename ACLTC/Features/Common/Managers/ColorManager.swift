//
//  ColorManager.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

public final class ColorManager {
    
    public static let shared: ColorManager = ColorManager()

    private init() { }
    
    public var red: UIColor = UIColor(named: "Red", in: Bundle.main, compatibleWith: nil) ?? .clear
    public var secondary100: UIColor = UIColor(named: "Secondary100", in: Bundle.main, compatibleWith: nil) ?? .clear
    public var secondary200: UIColor = UIColor(named: "Secondary200", in: Bundle.main, compatibleWith: nil) ?? .clear
    public var secondary300: UIColor = UIColor(named: "Secondary300", in: Bundle.main, compatibleWith: nil) ?? .clear
    public var white: UIColor = UIColor(named: "White", in: Bundle.main, compatibleWith: nil) ?? .clear
    public var black200: UIColor = UIColor(named: "Black200", in: Bundle.main, compatibleWith: nil) ?? .clear
    public var black300: UIColor = UIColor(named: "Black300", in: Bundle.main, compatibleWith: nil) ?? .clear
    public var black400: UIColor = UIColor(named: "Black400", in: Bundle.main, compatibleWith: nil) ?? .clear
    public var primary: UIColor = UIColor(named: "Primary", in: Bundle.main, compatibleWith: nil) ?? .clear
    public var primary200: UIColor = UIColor(named: "Primary200", in: Bundle.main, compatibleWith: nil) ?? .clear
    public var primary700: UIColor = UIColor(named: "Primary", in: Bundle.main, compatibleWith: nil) ?? .clear
    public var pressedCell: UIColor = UIColor(named: "PressedCell", in: Bundle.main, compatibleWith: nil) ?? .clear
    public var background: UIColor = UIColor(named: "Background", in: Bundle.main, compatibleWith: nil) ?? .clear
}


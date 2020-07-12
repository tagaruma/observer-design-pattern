//
//  UIColor+RGB.swift
//  builder-pattern
//
//  Created by Ruslan Garifulin on 25.06.2020.
//  Copyright © 2020 Ruslan Garifulin. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(value: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        rgb(red: value, green: value, blue: value, alpha: alpha)
    }

    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: min(max(alpha, 0.0), 1.0))
    }
}

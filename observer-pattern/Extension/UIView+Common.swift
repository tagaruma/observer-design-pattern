//
//  UIView+Common.swift
//  builder-pattern
//
//  Created by Ruslan Garifulin on 25.06.2020.
//  Copyright © 2020 Ruslan Garifulin. All rights reserved.
//

import UIKit

extension UIView {
    var layoutGuide: UILayoutGuide {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide
        }

        return layoutMarginsGuide
    }

    func addAnchors(top: NSLayoutYAxisAnchor? = nil, topPadding: CGFloat = 0,
                    bottom: NSLayoutYAxisAnchor? = nil, bottomPadding: CGFloat = 0.0,
                    left: NSLayoutXAxisAnchor? = nil, leftPadding: CGFloat = 0.0,
                    right: NSLayoutXAxisAnchor? = nil, rightPadding: CGFloat = 0.0,
                    leading: NSLayoutXAxisAnchor? = nil, leadingPadding: CGFloat = 0.0,
                    trailing: NSLayoutXAxisAnchor? = nil, trailingPadding: CGFloat = 0.0,
                    widthAnchor: NSLayoutDimension? = nil, heightAnchor: NSLayoutDimension? = nil,
                    width: CGFloat = 0.0, height: CGFloat = 0.0,
                    centerX: NSLayoutXAxisAnchor? = nil, centerXConst: CGFloat = 0.0,
                    centerY: NSLayoutYAxisAnchor? = nil, centerYConst: CGFloat = 0.0) {
        translatesAutoresizingMaskIntoConstraints = false

        var anchors: [NSLayoutConstraint] = []

        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topPadding))
        }

        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomPadding))
        }

        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftPadding))
        }

        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightPadding))
        }

        if let leading = leading {
            anchors.append(leadingAnchor.constraint(equalTo: leading, constant: leadingPadding))
        }

        if let trailing = trailing {
            anchors.append(trailingAnchor.constraint(equalTo: trailing, constant: -trailingPadding))
        }

        if let centerX = centerX {
            anchors.append(centerXAnchor.constraint(equalTo: centerX, constant: centerXConst))
        }

        if let centerY = centerY {
            anchors.append(centerYAnchor.constraint(equalTo: centerY, constant: centerYConst))
        }

        if let widthAnchor = widthAnchor {
            anchors.append(self.widthAnchor.constraint(equalTo: widthAnchor))
        } else if width != 0.0 {
            anchors.append(self.widthAnchor.constraint(equalToConstant: width))
        }

        if let heightAnchor = heightAnchor {
            anchors.append(self.heightAnchor.constraint(equalTo: heightAnchor))
        } else if height != 0.0 {
            anchors.append(self.heightAnchor.constraint(equalToConstant: height))
        }

        NSLayoutConstraint.activate(anchors)
    }
}

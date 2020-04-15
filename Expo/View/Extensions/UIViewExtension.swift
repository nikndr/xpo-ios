//
//  UIViewExtension.swift
//  Expo
//
//  Created by Nikandr Marhal on 09.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

extension UIView {
    func makeRoundedCorners(withRadius radius: CGFloat? = nil, corners: CACornerMask = .allCorners) {
        var roundRadius = CGFloat()
        if let radius = radius {
            roundRadius = radius
        } else {
            roundRadius = bounds.height / 2
        }
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: roundRadius, height: roundRadius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        layer.mask = mask
        layer.cornerRadius = roundRadius
        clipsToBounds = true
        layer.maskedCorners = corners
    }
}

extension CACornerMask {
    static var allCorners: CACornerMask {
        [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
    }

    static var topLeft: CACornerMask {
        .layerMinXMinYCorner
    }

    static var topRight: CACornerMask {
        .layerMaxXMinYCorner
    }

    static var bottomRight: CACornerMask {
        .layerMaxXMaxYCorner
    }

    static var bottomLeft: CACornerMask {
        .layerMinXMaxYCorner
    }
}

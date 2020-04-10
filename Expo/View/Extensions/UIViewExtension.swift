//
//  UIViewExtension.swift
//  Expo
//
//  Created by Nikandr Marhal on 09.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

extension UIView {
    func makeRoundedCorners(withRadius radius: CGFloat? = nil, corners: UIRectCorner = .allCorners) {
        var roundRadius = CGFloat()
        if let radius = radius {
            roundRadius = radius
        } else {
            roundRadius = bounds.height / 2
        }
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: roundRadius, height: roundRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

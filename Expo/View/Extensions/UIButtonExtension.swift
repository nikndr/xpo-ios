//
//  UIButtonExtrnsion.swift
//  Expo
//
//  Created by Nikandr Marhal on 27.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

extension UIButton {
    
    static let enabledAlpha: CGFloat = 1.0
    static let disabledAlpha: CGFloat = 0.7
    
    func setEnabled(_ isEnabled: Bool) {
        self.isEnabled = isEnabled
        self.alpha = isEnabled ? UIButton.enabledAlpha : UIButton.disabledAlpha
    }
}


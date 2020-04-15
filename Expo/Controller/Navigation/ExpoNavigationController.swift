//
//  ExpoNavigationController.swift
//  Expo
//
//  Created by Nikandr Marhal on 15.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

final class ExpoNavigationController: UINavigationController {
    
    // MARK: - Properties
    
    // MARK: - Outlets
    
    // MARK: - Actions
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
    }
    
    // MARK: - UI configuration
    
    /// Put your custom UI code here:
    /// rounded corners, shadows, corders etc.
    func configureUIElements() {
        let statusBarBounds = navigationBar.bounds
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.frame = statusBarBounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        navigationBar.addSubview(visualEffectView)
        navigationBar.sendSubviewToBack(visualEffectView)
    }
}

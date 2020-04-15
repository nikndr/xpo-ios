//
//  AuthChoiceViewController.swift
//  Expo
//
//  Created by Nikandr Marhal on 08.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

class AuthChoiceViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var haveAccountButton: UIButton!
    @IBOutlet weak var dontHaveAccountButton: UIButton!
    
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
        haveAccountButton.makeRoundedCorners()
        dontHaveAccountButton.makeRoundedCorners()
    }
  
}

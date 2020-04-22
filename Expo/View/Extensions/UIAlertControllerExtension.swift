//
//  UIAlertControllerExtension.swift
//  Expo
//
//  Created by Nikandr Marhal on 14.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func loadingView(withTitle title: String?, message: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 30, width: 30, height: 30))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating()
        
        alert.view.addSubview(loadingIndicator)
        return alert
    }
}

//
//  SplashScreenViewController.swift
//  Expo
//
//  Created by Nikandr Marhal on 30.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    var session = AppSession.shared
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        view.addSubview(activityIndicator)

        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.4)

        makeServiceCall()
    }

    private func makeServiceCall() {
        activityIndicator.startAnimating()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
            self.activityIndicator.stopAnimating()

            if case .loggedIn(_) = self.session.state {
//                SceneDelegate.shared.rootViewController.showMainScreen()
            } else {
//                SceneDelegate.shared.rootViewController.showLogOut()
            }
        }
    }
}

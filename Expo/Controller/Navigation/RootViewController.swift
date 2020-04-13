//
//  RootViewController.swift
//  Expo
//
//  Created by Nikandr Marhal on 30.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    // MARK: - Properties

    private var current: UIViewController

    // MARK: - Initialization

    init() {
        self.current = SplashViewController()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.current = SplashViewController()
        super.init(coder: coder)
    }

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
    }

    // MARK: - Navigation

    private func showScreen(representedBy viewController: UIViewController) {
        let new = UINavigationController(rootViewController: viewController)
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)

        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        current = new
    }

    func showLogInScreen() {
        let logIn = LogInViewController()
        showScreen(representedBy: logIn)
    }

    func showMainScreen() {
        let mainScreen = MainScreenViewController()
//        showScreen(representedBy: mainScreen)
        animateFadeTransition(to: mainScreen)
    }

    func showLogOut() {
        let logIn = LogInViewController()
        animateDismissTransition(to: logIn)
    }

    // MARK: - Transition animations

    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        addChild(new)
        current.willMove(toParent: nil)
        transition(from: current, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {}) { _ in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }

    private func animateDismissTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
//        let initialFrame = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
        current.willMove(toParent: nil)

        addChild(new)
        transition(from: current, to: new, duration: 0.3, options: [], animations: { new.view.frame = self.view.bounds }) { _ in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
}

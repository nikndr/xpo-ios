//
//  UIStoryboardExtension.swift
//  Expo
//
//  Created by Nikandr Marhal on 08.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

fileprivate enum Storyboard : String {
    case main = "Main"
}

fileprivate extension UIStoryboard {
    
    static func loadFromMain(_ identifier: String) -> UIViewController {
        return load(from: .main, identifier: identifier)
    }
    
    static func load(from storyboard: Storyboard, identifier: String) -> UIViewController {
        let uiStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return uiStoryboard.instantiateViewController(withIdentifier: identifier)
    }
}

// MARK: - App View Controllers

extension UIStoryboard {
    class func instantiateMainScreenViewControoler() -> MainScreenViewController {
        loadFromMain("MainScreenViewController") as! MainScreenViewController
    }
    
    class func instantiateMainScreenTabBarController() -> MainScreenTabBarController {
        loadFromMain("MainScreenTabBarController") as! MainScreenTabBarController
    }
    
    class func instantiateAuthChoiceNavigationController() -> AuthChoiceNavigationController {
        loadFromMain("AuthChoiceNavigationController") as! AuthChoiceNavigationController
    }
}

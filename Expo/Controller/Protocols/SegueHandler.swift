//
//  SegueHandler.swift
//  Expo
//
//  Created by Nikandr Marhal on 28.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

protocol SegueHandler {
    associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandler where Self: UIViewController, SegueIdentifier.RawValue == String {
    func performSegueWithIdentifier(segueIdentifier: SegueIdentifier,
                                    sender: AnyObject?) {
        performSegue(withIdentifier: segueIdentifier.rawValue, sender: sender)
    }

    func segueIdentifier(for segue: UIStoryboardSegue) -> SegueIdentifier {
        guard
            let identifier = segue.identifier,
            let segueIdentifier = SegueIdentifier(rawValue: identifier)
        else {
            fatalError("Invalid segue identifier: \(String(describing: segue.identifier))")
        }

        return segueIdentifier
    }
}

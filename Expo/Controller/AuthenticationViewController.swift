//
//  AuthenticationViewController.swift
//  Expo
//
//  Created by Nikandr Marhal on 27.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {
    // MARK: - Properties

    var previousKeyboardHeight: CGFloat = 0

    // MARK: - Gestures

    func registerGestures() {
        let tapGestureBackground = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        view.addGestureRecognizer(tapGestureBackground)
    }

    @objc func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    // MARK: - Notifications

    func registerNotifications() {
        previousKeyboardHeight = 0
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc func keyboardWillChange(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        let viewHeight = view.frame.height
        let keyboardHeight = viewHeight - keyboardViewEndFrame.minY
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            view.frame.origin.y = 0
        } else {
            view.frame.origin.y -= keyboardHeight
        }
    }
}

// MARK: - UITextFieldDelegate conformation

extension AuthenticationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}

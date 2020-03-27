//
//  SignUpViewController.swift
//  Expo
//
//  Created by Nikandr Marhal on 27.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, FormDataSender {
    // MARK: - Outlets

    @IBOutlet var fullNameTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var organizerAccountSwitch: UISwitch!
    @IBOutlet var createAccountButton: UIButton!

    var allFieldsFilled: Bool {
        !(fullNameTextField.text?.isEmpty ?? true) &&
            !(usernameTextField.text?.isEmpty ?? true) &&
            !(passwordTextField.text?.isEmpty ?? true)
    }

    // MARK: - Actions

    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
        createAccount()
    }

    @IBAction func alreadyHaveAccountButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        registerGestures()
        registerNotifications()

        fullNameTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self

        createAccountButton.setEnabled(false)

        manageTextFieldEditing()
    }

    // MARK: - Text field validation

    func manageTextFieldEditing() {
        [fullNameTextField, usernameTextField, passwordTextField]
            .forEach { $0?.addTarget(self, action: #selector(editingChanged), for: .editingChanged) }
    }

    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1, textField.text?.first == " " {
            textField.text = ""
            return
        }
        createAccountButton.setEnabled(allFieldsFilled)
    }

    // MARK: - Account creation logic

    func createAccount() {
        if allFieldsFilled {
            print("createAccount()")
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
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

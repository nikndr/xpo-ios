//
//  ProfileViewController.swift
//  Expo
//
//  Created by Nikandr Marhal on 10.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, FormDataSender {
    // MARK: - Properties
    
    var session = AppSession.shared
    
    var user: User!
    var passwordFieldEdited = false
    var usernameFieldEdited = false
    
    var userFieldsFilled: Bool {
        !(fullNameTextField.text?.isEmpty ?? true) && !(usernameTextField.text?.isEmpty ?? true)
    }
    
    var passwordFieldFilled: Bool {
        !(passwordTextField.text?.isEmpty ?? true)
    }
    
    var allFieldsFilled: Bool {
        userFieldsFilled && passwordFieldFilled
    }
    
    // MARK: - Outlets
    
    @IBOutlet var fullNameTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nameErrorLabel: UILabel!
    @IBOutlet var usernameErrorLabel: UILabel!
    @IBOutlet var passwordErrorLabel: UILabel!
    @IBOutlet var saveButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        updateProfile()
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
        manageTextFieldEditing()
    }
    
    // MARK: - Updating
    
    func updateProfile() {
        let alert = UIAlertController.loadingView(withTitle: "Please wait", message: "Updating your profile")
        present(alert, animated: true, completion: nil)
        session.updateUser(newName: fullNameTextField.text,
                           newLogin: usernameFieldEdited ? usernameTextField.text : nil,
                           newPassword: passwordFieldEdited ? passwordTextField.text : nil) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                alert.dismiss(animated: true) { [weak self] in
                    guard let self = self else { return }
                    let alert = UIAlertController(title: "Saved!", message: "You will see your updated profile immediately.", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    self.user = user
                    self.configureUIElements()
                    let when = DispatchTime.now() + 1.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        alert.dismiss(animated: true, completion: nil)
                    }
                }
            case .failure(let error):
                print("In updateProfile(): \(error)")
                alert.dismiss(animated: true) { [weak self] in
                    guard let self = self else { return }
                    let alert = UIAlertController(title: "Updating failed", message: "Could not update profile", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    // MARK: - UI configuration
    
    /// Put your custom UI code here:
    /// rounded corners, shadows, corders etc.
    func configureUIElements() {
        saveButton.makeRoundedCorners()
        saveButton.setEnabled(false)
        
        fullNameTextField.text = user.name
        usernameTextField.text = user.login
        
        [nameErrorLabel, usernameErrorLabel, passwordErrorLabel].forEach { hide(errorLabel: $0) }
    }
    
    func showErrorLabel(for textField: UITextField, withMessage message: String) {
        switch textField {
        case fullNameTextField:
            show(errorLabel: nameErrorLabel, withText: message)
        case usernameTextField:
            show(errorLabel: usernameErrorLabel, withText: message)
        case passwordTextField:
            show(errorLabel: passwordErrorLabel, withText: message)
        default:
            break
        }
    }
    
    func hideErrorLabel(for textField: UITextField) {
        switch textField {
        case fullNameTextField:
            hide(errorLabel: nameErrorLabel)
        case usernameTextField:
            hide(errorLabel: usernameErrorLabel)
        case passwordTextField:
            hide(errorLabel: passwordErrorLabel)
        default:
            break
        }
    }
    
    func show(errorLabel: UILabel, withText text: String) {
        errorLabel.text = text
        errorLabel.isHidden = false
    }
    
    func hide(errorLabel: UILabel) {
        errorLabel.text = String()
        errorLabel.isHidden = true
    }
    
    // MARK: - Field data validation
    
    func isUsernameValid(_ username: String) -> Bool {
        username.count > 2 && !username.contains(" ")
    }
    
    func manageTextFieldEditing() {
        [usernameTextField, fullNameTextField, passwordTextField]
            .forEach { $0?.addTarget(self, action: #selector(editingChanged), for: .editingChanged) }
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        registerEdit(of: textField)
        eraseSpaces(from: textField)
        restrictEmptyText(for: textField)
        
        if usernameFieldEdited {
            validateUsername()
        } else {
            saveButton.setEnabled(userFieldsFilled)
        }
    }
    
    func registerEdit(of textField: UITextField) {
        switch textField {
        case usernameTextField:
            usernameFieldEdited = true
        case passwordTextField:
            passwordFieldEdited = true
        default:
            break
        }
    }
    
    func eraseSpaces(from textField: UITextField) {
        if textField.text?.count == 1, textField.text?.first == " " {
            textField.text = ""
            return
        }
    }
    
    func restrictEmptyText(for textField: UITextField) {
        if textField.text?.count == 0 {
            showErrorLabel(for: textField, withMessage: "This field cannot be empty")
        } else {
            hideErrorLabel(for: textField)
        }
    }
    
    func validateUsername() {
        if isUsernameValid(usernameTextField.text!) {
            hide(errorLabel: usernameErrorLabel)
            saveButton.setEnabled(userFieldsFilled)
        } else {
            show(errorLabel: usernameErrorLabel, withText: "Must be at least 3 characters long and have no spaces")
        }
    }
}

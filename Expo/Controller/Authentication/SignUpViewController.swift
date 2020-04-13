//
//  SignUpViewController.swift
//  Expo
//
//  Created by Nikandr Marhal on 27.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

class SignUpViewController: AuthenticationViewController, FormDataSender {
    // MARK: - Properties

    var session = AppSession.shared

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

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        registerGestures()

        fullNameTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self

        createAccountButton.setEnabled(false)

        setUpUI()

        manageTextFieldEditing()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        switch segueIdentifier(for: segue) {
//        case .createAccountAndLogIn:
//            #warning("Missing implementation")
//        }
    }

    // MARK: - UI preparation

    func setUpUI() {
        createAccountButton.makeRoundedCorners()
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
            session.signUp(withName: fullNameTextField.text!, username: usernameTextField.text!, password: passwordTextField.text!, isOrganizer: organizerAccountSwitch.isOn) { result in
                switch result {
                case .success(_):
                    let mainScreenVC = UIStoryboard.instantiateMainScreenTabBarController()
                    self.view.window?.rootViewController = mainScreenVC
                    self.view.window?.makeKeyAndVisible()
                case .failure(let error):
                    let alert = UIAlertController(title: "Sign up failed", message: error.rawValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
}

// extension SignUpViewController: SegueHandler {
//    enum SegueIdentifier: String {
//        case createAccountAndLogIn
//    }
// }

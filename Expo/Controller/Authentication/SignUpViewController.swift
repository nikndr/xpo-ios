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
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var organizerAccountSwitch: UISwitch!
    @IBOutlet var createAccountButton: UIButton!

    var allFieldsFilled: Bool {
        !(fullNameTextField.text?.isEmpty ?? true) &&
            !(usernameTextField.text?.isEmpty ?? true) &&
            !(emailTextField.text?.isEmpty ?? true) &&
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
        emailTextField.delegate = self
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
        [fullNameTextField, usernameTextField, emailTextField, passwordTextField]
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
            let alertTitle = localizedString(for: .pleaseWait)
            let alertBody = "\(localizedString(for: .creatingYourAccount))"
            let alert = UIAlertController.loadingView(withTitle: alertTitle, message: alertBody)
            present(alert, animated: true, completion: nil)
            session.signUp(withName: fullNameTextField.text!, username: usernameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, isOrganizer: organizerAccountSwitch.isOn) { result in
                switch result {
                case .success:
                    alert.dismiss(animated: true) { [weak self] in
                        guard let self = self else { return }
                        let alertTitle = localizedString(for: .accountCreated)
                        let alertBody = localizedString(for: .goAheadAndLogInExc)
                        let alert = UIAlertController(title: alertTitle, message: alertBody, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                            self?.navigationController?.popViewController(animated: true)
                        }))
                        self.present(alert, animated: true)
                    }
                case .failure(let error):
                    alert.dismiss(animated: true) { [weak self] in
                        guard let self = self else { return }
                        let alertTitle = localizedString(for: .signUpFailed)
                        let alert = UIAlertController(title: alertTitle, message: error.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                }
            }
        }
    }
}

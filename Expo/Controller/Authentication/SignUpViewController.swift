//
//  SignUpViewController.swift
//  Expo
//
//  Created by Nikandr Marhal on 27.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

class SignUpViewController: AuthenticationViewController, FormDataSender {
    
    weak var sourceViewController: LogInViewController?
    
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
        navigationController?.popViewController(animated: true)//(animated: true, completion: nil)
//        dismiss(animated: true, completion: nil)
    }

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        registerGestures()

        fullNameTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self

        createAccountButton.setEnabled(false)

        manageTextFieldEditing()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sourceViewController = nil
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .createAccountAndLogIn:
            #warning("Missing implementation")
        }
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

extension SignUpViewController: SegueHandler {
    enum SegueIdentifier: String {
        case createAccountAndLogIn
    }
}

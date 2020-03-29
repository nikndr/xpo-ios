//
//  ViewController.swift
//  Expo
//
//  Created by Nikandr Marhal on 27.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

class LogInViewController: AuthenticationViewController, FormDataSender {
    // MARK: - Outlets

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var logInButton: UIButton!

    var allFieldsFilled: Bool {
        !(usernameTextField.text?.isEmpty ?? true) && !(passwordTextField.text?.isEmpty ?? true)
    }

    // MARK: - Actions

    @IBAction func logInButtonPressed(_ sender: UIButton) {
        logIn()
        performSegue(withIdentifier: .logIn, sender: self)
    }

    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
        view.endEditing(true)
        performSegue(withIdentifier: .createAccount, sender: self)
    }

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        registerGestures()

        usernameTextField.delegate = self
        passwordTextField.delegate = self
//        logInButton.setEnabled(false)

        manageTextFieldEditing()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .createAccount:
            let destinationVC = segue.destination as! SignUpViewController
            destinationVC.sourceViewController = self
        case .logIn:
            break
        }
    }

    // MARK: - Text field validation

    func manageTextFieldEditing() {
        [usernameTextField, passwordTextField]
            .forEach { $0?.addTarget(self, action: #selector(editingChanged), for: .editingChanged) }
    }

    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1, textField.text?.first == " " {
            textField.text = ""
            return
        }
        logInButton.setEnabled(allFieldsFilled)
    }

    // MARK: - Log in logic

    func logIn() {
        if allFieldsFilled {
            print("logIn()")
            // call to api
            // receive response with User object
            
        }
    }
}

// MARK: - SegueHandler conformation

extension LogInViewController: SegueHandler {
    enum SegueIdentifier: String {
        case createAccount
        case logIn
    }
}

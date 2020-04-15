//
//  ViewController.swift
//  Expo
//
//  Created by Nikandr Marhal on 27.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

class LogInViewController: AuthenticationViewController, FormDataSender {
    // MARK: - Properties

    var session = AppSession.shared

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
    }

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        registerGestures()

        usernameTextField.delegate = self
        passwordTextField.delegate = self
        logInButton.setEnabled(true)

        setUpUI()

        manageTextFieldEditing()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .logIn:
            break
        }
    }
    
    func showMainScreen() {
        let mainScreenVC = UIStoryboard.instantiateMainScreenTabBarController()
        view.window?.rootViewController = mainScreenVC
        view.window?.makeKeyAndVisible()
    }

    // MARK: - UI preparation

    func setUpUI() {
        logInButton.makeRoundedCorners()
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
            let alert = UIAlertController.loadingView(withTitle: "Please wait", message: "Logging in...")
            present(alert, animated: true, completion: nil)
            session.logIn(withUsername: usernameTextField.text!, password: passwordTextField.text!) { result in
                switch result {
                case .success:
                    alert.dismiss(animated: true) { [weak self] in
                        self?.showMainScreen()
                    }
                case .failure(let error):
                    print(error)
                    alert.dismiss(animated: true) { [weak self] in
                        let alert = UIAlertController(title: "Login failed", message: "Invalid login and password combination", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self?.present(alert, animated: true)
                    }
                }
            }
        }
    }
}

// MARK: - SegueHandler conformation

extension LogInViewController: SegueHandler {
    enum SegueIdentifier: String {
        case logIn
    }
}

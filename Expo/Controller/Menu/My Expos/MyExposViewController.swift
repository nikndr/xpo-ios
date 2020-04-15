//
//  MyExposViewController.swift
//  Expo
//
//  Created by Nikandr Marhal on 29.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

class MyExposViewController: UIViewController {
    // MARK: - Properties

    var expoTableChild: MyExpoListTableViewController? {
        didSet {
            expoTableChild?.delegate = self
        }
    }

    var selectedExpo: Expo?

    // MARK: - Outlets

    @IBOutlet var createNewExpoButton: UIButton!
    @IBOutlet weak var createNewExpoBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Actions

    @IBAction func createNewExpoButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: .createExpo, sender: self)
    }

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUIElements()
    }

    // MARK: - UI configuration

    func configureUIElements() {
        createNewExpoButton.makeRoundedCorners()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .editExpo:
            let destination = segue.destination as! ManageExpoViewController
            destination.expo = selectedExpo!
            destination.navigationItem.title = "Edit \(selectedExpo!.name)"
        case .createExpo:
            let destination = segue.destination as! ManageExpoViewController
            destination.navigationItem.title = "Create new Expo"
        case .myExpoList, .editExpoAnother:
            break
        }
    }
}

// MARK: - Conformation to TableDataReceiver

extension MyExposViewController: ExpoDataReceiver {
    func didSelectCell(withExpo expo: Expo) {
        selectedExpo = expo
        performSegue(withIdentifier: .editExpo, sender: self)
    }
}

// MARK: - Conformation to SegueHandler

extension MyExposViewController: SegueHandler {
    enum SegueIdentifier: String {
        case editExpo
        case createExpo
        case editExpoAnother
        case myExpoList
    }
}

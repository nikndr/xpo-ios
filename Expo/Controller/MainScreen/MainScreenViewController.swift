//
//  ExpoListViewController.swift
//  Expo
//
//  Created by Nikandr Marhal on 29.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {
    // Mark: - Properties
    var expoTableChild: ExpoListTableViewController? {
        didSet {
            expoTableChild?.delegate = self
        }
    }
    
    var selectedExpo: Expo?
    
    // MARK: - Outlets
    
    // MARK: - Actions
    
    @IBAction func profileButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: .showProfile, sender: self)
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let image = UIImage(systemName: "gear")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(openProfile))
    }
    
    // MARK: - UI configuration
    
    /// Put your custom UI code here:
    /// rounded corners, shadows, corders etc.
    func configureUIElements() {}
    
    // Mark: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .showExpo:
            let destination = segue.destination as! ExpoViewController
            destination.expo = selectedExpo!
        default:
            break
        }
    }
    
    @objc func openProfile() {
        performSegue(withIdentifier: .showProfile, sender: self)
    }
}

// MARK: - Conformation to TableDataReceiver

extension MainScreenViewController: ExpoDataReceiver {
    func didSelectCell(withExpo expo: Expo) {
        selectedExpo = expo
        performSegue(withIdentifier: .showExpo, sender: self)
    }
}

extension MainScreenViewController: SegueHandler {
    enum SegueIdentifier: String {
        case showExpo
        case showProfile
        case expoList
    }
}

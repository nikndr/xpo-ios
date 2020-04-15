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
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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

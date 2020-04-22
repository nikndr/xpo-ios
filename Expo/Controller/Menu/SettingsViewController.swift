//
//  ProfileViewController.swift
//  Expo
//
//  Created by Nikandr Marhal on 29.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    // MARK: - Properties
    
    let session = AppSession.shared
    
    // MARK: - Outlets
    
    // MARK: - Actions
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
        
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - UI configuration
    
    /// Put your custom UI code here:
    /// rounded corners, shadows, corders etc.
    func configureUIElements() {}
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .editProfile:
            guard case .loggedIn(let user) = session.state else { fatalError("юзер блять де???") }
            let destination = segue.destination as! ProfileViewController
            destination.user = user
        default:
            break
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case StaticCells.editProfile.rawValue:
            performSegue(withIdentifier: .editProfile, sender: self)
        case StaticCells.myExpos.rawValue:
            performSegue(withIdentifier: .myExpos, sender: self)
        case StaticCells.logOut.rawValue:
            AppSession.shared.logOut {
                self.view.window?.rootViewController = UIStoryboard.instantiateAuthChoiceNavigationController()
                self.view.window?.makeKeyAndVisible()
            }
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if case .loggedIn(let user) = AppSession.shared.state, !user.isOrganizer {
            return indexPath.row == StaticCells.myExpos.rawValue ? .zero : super.tableView(tableView, heightForRowAt: indexPath)
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
}

// MARK: - Conformation to SegueHandler

extension SettingsViewController: SegueHandler {
    enum SegueIdentifier: String {
        case editProfile
        case myExpos
        case logOut
    }
}

extension SettingsViewController {
    enum StaticCells: Int {
        case editProfile, myExpos, logOut
    }
}

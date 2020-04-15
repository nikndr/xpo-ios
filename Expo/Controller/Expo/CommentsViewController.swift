//
//  CommentsViewController.swift
//  Expo
//
//  Created by Nikandr Marhal on 15.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

protocol ExpoReloadDelegate: AnyObject {
    func reloaded(_ expo: Expo)
}

class CommentsViewController: UITableViewController {
    // MARK: - Properties
    
    var expo: Expo!
    let session = AppSession.shared
    weak var expoReloadDelegate: ExpoReloadDelegate?
    
    // MARK: - Outlets
    
    // MARK: - Actions
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
        
//        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.commentCell.rawValue)
        
        expo.comments.sort(by: >) // sorted by date
    }
    
    // MARK: - UI configuration
    
    /// Put your custom UI code here:
    /// rounded corners, shadows, corders etc.
    func configureUIElements() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addComment))
        
        tableView.tableFooterView = UIView()
    }
    
    func fill(_ cell: UITableViewCell, with comment: Comment) {
        cell.textLabel?.text = comment.userName
        cell.detailTextLabel?.text = comment.text
    }
    
    // MARK: - Adding comments
    
    @objc func addComment() {
        if case .loggedIn(let user) = session.state {
            let alert = configureCommentInputAlert(for: user)
            present(alert, animated: true, completion: nil)
        } else {
            // handle logged out user
        }
    }
    
    func configureCommentInputAlert(for user: User) -> UIAlertController {
        let alert = UIAlertController(title: "What do you think about \(expo.name)?",
                                      message: "Add your comment to share an opinion",
                                      preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Please, type in your comment"
        }
        
        let action = UIAlertAction(title: "Submit", style: .default) { [weak alert, weak self] _ in
            guard let self = self, let alert = alert else { return }
            DispatchQueue.main.async {
                user.comment(on: self.expo, with: (alert.textFields?.first?.text!)!) { result in
                    switch result {
                    case .success:
                        self.reloadComments()
                    case .failure(let error):
                        debugPrint(error)
                        let errorAlert = UIAlertController(title: "Problem with adding your comment. Please, try again later.", message: "", preferredStyle: .alert)
                        errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(errorAlert, animated: true, completion: nil)
                    }
                }
            }
        }
        
        alert.addAction(action)
        
        return alert
    }
    
    // MARK: - Loading data
    
    func reloadComments() {
        Expo.getExpo(by: expo.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let expo):
                self.expo = expo
                self.expoReloadDelegate?.reloaded(expo)
                self.expo.comments.sort(by: >)
                self.tableView.reloadData()
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expo.comments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.commentCell.rawValue, for: indexPath)
        fill(cell, with: expo.comments[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let alert = UIAlertController.loadingView(withTitle: "Please wait", message: "Deleting your comment...")
        present(alert, animated: true, completion: nil)
        expo.comments[indexPath.row].delete { [weak self, weak alert] result in
            guard let self = self, let alert = alert else { return }
            switch result {
            case .success:
                self.expo.comments.remove(at: indexPath.row)
                self.reloadComments()
                alert.dismiss(animated: true, completion: nil)
            case .failure(let error):
                debugPrint(error)
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard case .loggedIn(let user) = session.state else { return false }
        return expo.comments[indexPath.row].userName == user.name // xDDDDDDDDDDDDDDDDD
    }
    
    // MARK: - Table view delegate
}

// MARK: - Cell identifiers

extension CommentsViewController {
    enum CellIdentifiers: String {
        case commentCell
    }
}

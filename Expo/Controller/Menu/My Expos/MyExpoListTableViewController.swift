//
//  MyExpoListTableViewController.swift
//  Expo
//
//  Created by Nikandr Marhal on 10.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

class MyExpoListTableViewController: UITableViewController {
    // MARK: - Properties

    var session = AppSession.shared
    var expos = [Expo]()
    var delegate: TableDataReceiver?

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorColor = .clear
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.loadData()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let parentVC = parent as! MyExposViewController
        parentVC.expoTableChild = self

        let footerHeight = parentVC.createNewExpoButton.frame.height + parentVC.createNewExpoBottomConstraint.constant * 2
        let footer = UIView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: footerHeight))
        tableView.tableFooterView = footer
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        (parent as! MyExposViewController).expoTableChild = nil
    }

    // MARK: - Load data

    func loadData() {
        guard case .loggedIn(let user) = session.state else { return }
        user.getOrganizedExpos { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let expos):
                self.expos = expos
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - Map data to cell

    func fill(cell: ExpoTableViewCell, withDataOf expo: Expo) {
        cell.title = expo.name
        cell.date = (startDate: expo.startTime, endDate: expo.endTime)
        cell.previewImageURL = expo.imageURL
        cell.viewCount = expo.viewsCount
        cell.likeCount = expo.likesCount

        //        cell.organizer = expo.organizerID.name
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return expos.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = CellIdentifier.expoCell.rawValue
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ExpoTableViewCell
        else {
            fatalError("Cell identifier not found: \(identifier)")
        }
        let expo = expos[indexPath.section]
        fill(cell: cell, withDataOf: expo)
        draw(cell: cell)
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        expos[indexPath.section].випіліца { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.expos.remove(at: indexPath.section)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectCell(withExpo: expos[indexPath.section])
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        ExpoTableViewCell.Constants.headerHeight.rawValue
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
    }

    // MARK: - UI configuration

    func draw(cell: ExpoTableViewCell) {
        cell.makeRoundedCorners(withRadius: ExpoTableViewCell.Constants.cornerRadius.rawValue, corners: .allCorners)
    }
}

// MARK: - Cell identifiers

extension MyExpoListTableViewController {
    enum CellIdentifier: String {
        case expoCell
    }
}

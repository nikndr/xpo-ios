//
//  ExpoListTableViewController.swift
//  Expo
//
//  Created by Nikandr Marhal on 29.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

protocol TableDataReceiver {
    func didSelectCell(withExpo expo: Expo)
}

class ExpoListTableViewController: UITableViewController {
    // MARK: - Properties

    var delegate: TableDataReceiver?
    var expos = [Expo]()

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorColor = .clear

        view.window?.rootViewController = self
        view.window?.makeKeyAndVisible()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.loadData()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        (parent as! MainScreenViewController).expoTableChild = self
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        (parent as! MainScreenViewController).expoTableChild = nil
    }
    
    // MARK: - Load data
    
    func loadData() {
        Expo.getAllExpos { [weak self] result in
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
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                     for: indexPath) as? ExpoTableViewCell
        else {
            fatalError("Cell identifier not found: \(identifier)")
        }
        let expo = expos[indexPath.section]
        fill(cell: cell, withDataOf: expo)
        draw(cell: cell)
        return cell
    }

    func fill(cell: ExpoTableViewCell, withDataOf expo: Expo) {
        cell.title = expo.name
        cell.date = (startDate: expo.startTime, endDate: expo.endTime)
        cell.previewImageURL = expo.imageURL
        cell.viewCount = expo.viewsCount
        cell.likeCount = expo.likesCount
        
//        cell.organizer = expo.organizerID.name
    }

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

    // MARK: - Graphics

    func draw(cell: ExpoTableViewCell) {
        cell.makeRoundedCorners(withRadius: ExpoTableViewCell.Constants.cornerRadius.rawValue, corners: .allCorners)
    }
}

// MARK: - Cell identifiers

extension ExpoListTableViewController {
    enum CellIdentifier: String {
        case expoCell
    }
}

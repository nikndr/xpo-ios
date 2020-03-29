//
//  ExpoListTableViewController.swift
//  Expo
//
//  Created by Nikandr Marhal on 29.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

class ExpoListTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorColor = .clear

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Expo.expos.count
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
        let expo = Expo.expos[indexPath.section]
        fill(cell: cell, withContentsOf: expo)
        draw(cell: cell)
        

        return cell
    }

    func fill(cell: ExpoTableViewCell, withContentsOf expo: Expo) {
        cell.title = expo.name
        cell.organizer = expo.organizer.name
        cell.descriptionText = expo.description
        cell.previewImageURL = expo.imageURL
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        cell.backgroundColor = .clear
        cell.layer.masksToBounds = false
        cell.layer.shadowOpacity = Float(ExpoTableViewCell.Constants.shadowOpacity.rawValue)
        cell.layer.shadowRadius = ExpoTableViewCell.Constants.shadowRadius.rawValue
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowColor = UIColor.black.cgColor
        
        
        cell.contentView.backgroundColor = .white
        cell.contentView.layer.cornerRadius = ExpoTableViewCell.Constants.cornerRadius.rawValue
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .expoDetails:
            break
        }
    }
}

// MARK: - Cell identifiers

extension ExpoListTableViewController {
    enum CellIdentifier: String {
        case expoCell
    }
}

// MARK: - SegueHandler conformation

extension ExpoListTableViewController: SegueHandler {
    enum SegueIdentifier: String {
        case expoDetails
    }
}

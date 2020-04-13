//
//  ExpoViewController.swift
//  Expo
//
//  Created by Nikandr Marhal on 09.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

class ExpoViewController: UIViewController {
    // MARK: - Properties
    
    var expo: Expo!
    var downloadViewHeight: CGFloat = 0.0
    
    // MARK: - Outlets
    
    @IBOutlet var expoTitleImage: UIImageView!
    @IBOutlet var downloadView: UIProgressView!
    @IBOutlet var downloadViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var actionButton: UIButton!
    @IBOutlet var organizerLabel: UILabel!
    @IBOutlet var dateTimeLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var addCommentButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func actionButtonPressed(_ sender: UIButton) {
        updateState()
    }
    
    @IBAction func addCommentButtonPressed(_ sender: UIButton) {}
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        updateLikeButton()
    }
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
        expo.increaseViewCount()
    }
    
    // MARK: - UI configuration
    
    /// Put your custom UI code here:
    /// rounded corners, shadows, corders etc.
    func configureUIElements() {
        adjustments()
        assignExpoDataToUI()
        
        if case .loggedIn(let user) = AppSession.shared.state {
            if user.likes(expo) {
                likeButton.tintColor = Constants.likeButtonColor
            } else {
                likeButton.tintColor = Constants.dislikeButtonColor
            }
        }
        notLoadedState()
    }
    
    func updateLikeButton() {
        if case .loggedIn(let user) = AppSession.shared.state {
            if user.likes(expo) {
                likeButton.tintColor = Constants.dislikeButtonColor
                user.dislike(expo)
                expo.decreaseLikeCount()
            } else {
                likeButton.tintColor = Constants.likeButtonColor
                user.like(expo)
                expo.increaseLikeCount()
            }
        }
    }
    
    func adjustments() {
        actionButton.makeRoundedCorners(withRadius: nil, corners: [.bottomLeft, .bottomRight])
        expoTitleImage.makeRoundedCorners(withRadius: actionButton.bounds.height / 2, corners: [.topLeft, .topRight])
        addCommentButton.makeRoundedCorners()
        likeButton.makeRoundedCorners()
    }
    
    func assignExpoDataToUI() {
        navigationItem.title = expo.name
        expoTitleImage.setImageFrom(url: expo.imageURL.absoluteString)
        organizerLabel.text = expo.organizer.name
        dateTimeLabel.text = formatTimeInterval(startDate: expo.startTime, endDate: expo.endTime)
        locationLabel.text = expo.locationName
        descriptionLabel.text = expo.description
    }
    
    func updateState() {
//        switch expo.state {
//        case .notDownloaded:
//            notLoadedState()
//        case .downloading(_):
//            downloadingState()
//        case .downloaded(_):
//            downloadedState()
//        }
        downloadingState()
        downloadedState()
    }
    
    func notLoadedState() {
        downloadViewHeight = downloadViewHeightConstraint.constant
        downloadViewHeightConstraint.constant = .zero
    }
    
    func downloadingState() {
        UIView.animate(withDuration: 0.5) {
            self.downloadViewHeightConstraint.constant = self.downloadViewHeight
            self.view.layoutIfNeeded()
        }
        actionButton.setTitle( Constants.cancelButtonText, for: .normal)
        actionButton.backgroundColor = Constants.cancelButtonColor
    }
    
    func downloadedState() {
        actionButton.setTitle( Constants.openButtonText, for: .normal)
        actionButton.backgroundColor = Constants.openButtonColor
    }
    
    // Mark: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .todo:
            break
        }
    }
}

// MARK: - Conformation to SegueHandler

extension ExpoViewController: SegueHandler {
    enum SegueIdentifier: String {
        case todo
    }
}

extension ExpoViewController {
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
        static let downloadButtonText = "Download Expo"
        static let downloadButtonColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        static let cancelButtonText = "Cancel downloading"
        static let cancelButtonColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        static let openButtonText = "Open Expo"
        static let openButtonColor = #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
        static let likeButtonColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        static let dislikeButtonColor = #colorLiteral(red: 0.5960784314, green: 0.5960784314, blue: 0.6156862745, alpha: 1)
    }
}

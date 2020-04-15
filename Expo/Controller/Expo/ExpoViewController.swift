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
    
    var session = AppSession.shared
    var expo: Expo!
    var commentsControllerChild: CommentsViewController? {
        didSet {
            commentsControllerChild?.expoReloadDelegate = self
        }
    }
    
    var downloadViewHeight: CGFloat = 0.0
    var isLiked: Bool! {
        didSet {
            likeButton.tintColor = isLiked ? Constants.likeButtonColor : Constants.dislikeButtonColor
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet var expoTitleImage: UIImageView!
    @IBOutlet var downloadView: UIProgressView!
    @IBOutlet var downloadViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var proceedButton: UIButton!
    @IBOutlet var organizerLabel: UILabel!
    @IBOutlet var dateTimeLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var addCommentButton: UIButton!
    @IBOutlet var likeButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func proceedButtonPressed(_ sender: UIButton) {
        updateState()
    }
    
    @IBAction func addCommentButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: .showComments, sender: self)
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        guard case .loggedIn(let user) = session.state else { return }
        isLiked.toggle()
        if isLiked {
            user.like(expo) { _ in }
        } else {
            user.dislike(expo) { _ in }
        }
//        user.like(expo, value: isLiked) { response in
//            switch response {
//            case .success(let uToE):
//                print(uToE)
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.visitExpo()
//            self.configureUIElements()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUIElements()
    }
    
    // MARK: - Network calls
    
    func visitExpo() {
        guard case .loggedIn(let user) = session.state else { return }
        user.visit(expoID: expo.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let userToExpo):
                self.isLiked = userToExpo.liked
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - UI configuration
    
    /// Put your custom UI code here:
    /// rounded corners, shadows, corders etc.
    func configureUIElements() {
        adjustments()
        assignExpoDataToUI()
        notLoadedState()
    }
    
    func adjustments() {
        proceedButton.makeRoundedCorners(withRadius: nil, corners: [.bottomLeft, .bottomRight])
        expoTitleImage.makeRoundedCorners(withRadius: proceedButton.bounds.height / 2, corners: [.topLeft, .topRight])
        addCommentButton.makeRoundedCorners()
        likeButton.makeRoundedCorners()
    }
    
    func assignExpoDataToUI() {
        navigationItem.title = expo.name
        expoTitleImage.setImageFrom(url: expo.imageURL)
//        organizerLabel.text = expo.organizerID.name
        dateTimeLabel.text = DateFormatter.formatTimeInterval(startDate: expo.startTime, endDate: expo.endTime)
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
        proceedButton.setTitle(Constants.cancelButtonText, for: .normal)
        proceedButton.backgroundColor = Constants.cancelButtonColor
    }
    
    func downloadedState() {
        proceedButton.setTitle(Constants.openButtonText, for: .normal)
        proceedButton.backgroundColor = Constants.openButtonColor
    }
    
    // Mark: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .showAR:
            break
        case .showComments:
            let destination = segue.destination as! CommentsViewController
            destination.expo = expo
            commentsControllerChild = destination
        }
    }
}

// MARK: - Conformation to SegueHandler

extension ExpoViewController: SegueHandler {
    enum SegueIdentifier: String {
        case showAR
        case showComments
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


// MARK: - Conformation to ExpoReloadDelegate
extension ExpoViewController: ExpoReloadDelegate {
    func reloaded(_ expo: Expo) {
        self.expo = expo
    }
}

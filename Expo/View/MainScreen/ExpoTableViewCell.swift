//
//  ExpoTableViewCell.swift
//  Expo
//
//  Created by Nikandr Marhal on 29.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

class ExpoTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var previewImageURL: String? {
        didSet {
            guard let previewImageURL = previewImageURL else { return }
            expoImage.setImageFrom(previewImageURL)
        }
    }
    
    var previewImage: UIImage? {
        didSet {
            expoImage.image = previewImage
        }
    }
    
    var title: String? {
        didSet {
            print(title)
            expoNameLabel.text = title
        }
    }
    
    var organizer: String? {
        didSet {
            expoOrganizerLabel.text = organizer
        }
    }
    
    var descriptionText: String? {
        didSet {
            expoDescriptionLabel.text = descriptionText
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var expoImage: UIImageView!
    @IBOutlet weak var expoNameLabel: UILabel!
    @IBOutlet weak var expoOrganizerLabel: UILabel!
    @IBOutlet weak var expoDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension ExpoTableViewCell {
    enum Constants: CGFloat {
        case cornerRadius = 8.0
        case shadowRadius = 4.0
        case borderWidth = 1.0
        case headerHeight = 10.0
        case shadowOpacity = 0.3
    }
}

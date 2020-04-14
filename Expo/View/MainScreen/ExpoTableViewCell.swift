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
            expoImage.setImageFrom(url: previewImageURL)
        }
    }
    
    var previewImage: UIImage? {
        didSet {
            expoImage.image = previewImage
        }
    }
    
    var title: String? {
        didSet {
            expoNameLabel.text = title
        }
    }
    
    var organizer: String? {
        didSet {
            expoOrganizerLabel.text = organizer
        }
    }
    
    var date: (startDate: Date?, endDate: Date?)? {
        didSet {
            guard let date = date, let startDate = date.startDate, let endDate = date.endDate else { return }
            expoDateLabel.text = DateFormatter.formatTimeInterval(startDate: startDate, endDate: endDate)
        }
    }
    
    var viewCount: Int? {
        didSet {
            viewCountLabel.text = "\(viewCount ?? 0)"
        }
    }
    
    var likeCount: Int? {
        didSet {
            likeCountLabel.text = "\(likeCount ?? 0)"
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var expoImage: UIImageView!
    @IBOutlet weak var expoNameLabel: UILabel!
    @IBOutlet weak var expoOrganizerLabel: UILabel!
    @IBOutlet weak var expoDateLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        expoDateLabel.numberOfLines = 0
        expoDateLabel.sizeToFit()
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

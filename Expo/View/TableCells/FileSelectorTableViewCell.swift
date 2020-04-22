//
//  FileSelectorTableViewCell.swift
//  Expo
//
//  Created by Nikandr Marhal on 16.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

class FileSelectorTableViewCell: UITableViewCell {
    // MARK: - Outlets

    @IBOutlet weak var pickMarkerButton: UIButton!
    @IBOutlet weak var pickModelButton: UIButton!
    @IBOutlet weak var pickMarkerLabel: UILabel!
    @IBOutlet weak var pickModelLabel: UILabel!
    
    

    // MARK: - Life cycle

    override func awakeFromNib() {
        super.awakeFromNib()

        pickMarkerButton.makeRoundedCorners()
        pickModelButton.makeRoundedCorners()
    }
}

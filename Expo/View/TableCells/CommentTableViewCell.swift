//
//  CommentTableViewCell.swift
//  Expo
//
//  Created by Nikandr Marhal on 15.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

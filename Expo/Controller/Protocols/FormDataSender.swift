//
//  FormDataSender.swift
//  Expo
//
//  Created by Nikandr Marhal on 27.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation

protocol FormDataSender {
    /// Validate that each text field was willed with data
    var allFieldsFilled: Bool { get }

    /// Each implementer mush provide custom behavior for form validation
    func manageTextFieldEditing()
}

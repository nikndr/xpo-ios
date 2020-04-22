//
//  Localization.swift
//  Expo
//
//  Created by Nikandr Marhal on 19.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation

enum LocalizedString: String {
    case create
    case submit
    case cancel
    case save
    case edit
    case open
    case savedExc
    case pleaseWait

    case deletingExpo

    case createNewExpo
    case creatingNewExpo
    case youHaveCreated
    case youHaveUpdated
    case creatingFailed
    case couldNotCreateExpo
    case savingExpo
    case updatingFailed
    case couldNotUpdateExpo
    
    case updatingYourProfile
    case youWillSeeYourProfile
    case couldNotUpdateProfile
    case fieldCannotBeEmpty
    case usernameError
    
    case loggingIn
    case loginFailed
    case invalidLoginAndPassword
    
    case creatingYourAccount
    case accountCreated
    case goAheadAndLogInExc
    case signUpFailed
    
    case commentPrompt
    case addComment
    case pleaseTypeInComment
    case problemWithAddingComment
    case deletingComment
    
    case downloadExpo
}

func localizedString(for key: LocalizedString) -> String {
    return NSLocalizedString(key.rawValue, comment: "zhopa")
}

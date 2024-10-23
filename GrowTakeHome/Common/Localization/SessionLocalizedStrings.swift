//
//  SessionLocalizedStrings.swift
//  GrowTakeHome
//
//  Created by Dante Garcia on 10/22/24.
//

import Foundation

enum SessionLocalizedStrings {
    
    // MARK: - Waiting Room Strings
    
    static let waitingForProvider = NSLocalizedString(
        "Title that informs the user that they are waiting for a provider",
        value: "Waiting for provider...",
        comment: "Waiting for provider..."
    )
    
    static let waitingRoomDescriptionMessage = NSLocalizedString(
        "Informs the user that they will be moved to the session automatically",
        value: "When they come online, you’ll be redirected to the session automatically",
        comment: "When they come online, you’ll be redirected to the session automatically"
    )
    
    // MARK: - Join Session Strings
    
    static let providerInSession = NSLocalizedString(
        "Title that informs the user that the provider is in the session",
        value: "Provider is in the session",
        comment: "Provider is in the session"
    )
    
    static let joinNow = NSLocalizedString(
        "Title for the join now button",
        value: "Join Now",
        comment: "Join Now"
    )
    
    // MARK: - Live Session Strings
    
    static let inSession = NSLocalizedString(
        "Title that informs the user that they are in a session",
        value: "In session",
        comment: "In session"
    )
    
    static let exit = NSLocalizedString(
        "Title for the exit button",
        value: "Exit",
        comment: "Exit"
    )
    
    // MARK: - Mood Selection Strings
    
    static let howHaveYouBeenWeek = NSLocalizedString(
        "Title that asks the users how they have been feeling this week",
        value: "How have you been feeling this week?",
        comment: "How have you been feeling this week?"
    )
    
    static let logActivity = NSLocalizedString(
        "Title for the log activity button",
        value: "Log Activity",
        comment: "Log Activity"
    )
}

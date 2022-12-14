//
//  NotificationAlert.swift
//  push-notifications-lecture-11
//
//  Created by Igor Rosocha on 07.12.2022.
//

import Foundation

struct NotificationAlert: Codable, Identifiable {
    let id: String
    let alertTitle: String
    let alertMessage: String
    var alertButtonTitle: String
}

//
//  PushManager.swift
//  push-notifications-lecture-11
//
//  Created by Igor Rosocha on 07.12.2022.
//

import UserNotifications
import UIKit

final class PushManager: NSObject, ObservableObject {
    
    // MARK: - Internal properties
    
    static let shared = PushManager()
    
    @Published var notificationAlert: NotificationAlert?
    
    // MARK: - Public helpers
    
    func start() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { granted, errror in
            if granted {
                DispatchQueue.main.async {
                    self.createActions()
                    
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
            
            UNUserNotificationCenter.current().delegate = self
        }
    }
    
    func stop() {
        UIApplication.shared.unregisterForRemoteNotifications()
    }
    
    // MARK: - Private helpers
    
    private func createActions() {
        let firstNotificationAction = UNNotificationAction(
            identifier: Action.first.rawValue,
            title: "First action",
            options: [.foreground]
        )
        
        let secondNotificationAction = UNNotificationAction(
            identifier: Action.second.rawValue,
            title: "Second action",
            options: [.foreground]
        )
        
        let notificationCategory = UNNotificationCategory(
            identifier: "NOTIFICATION_CATEGORY",
            actions: [firstNotificationAction, secondNotificationAction],
            intentIdentifiers: [],
            hiddenPreviewsBodyPlaceholder: "This is hidden, bro!",
            options: []
        )
        
        UNUserNotificationCenter.current().setNotificationCategories(
            Set([notificationCategory])
        )
    }
}

extension PushManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        print("[NOTIFICATION_RECEIVE]", notification)
        completionHandler([.banner, .badge, .sound])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        print("[NOTIFICATION_OPEN]", response)
        
        let userInfo = response.notification.request.content.userInfo
        let action = response.actionIdentifier
        
        if let action = Action(rawValue: action) {
            print("[NOTIFICATION_ACTION]", action)
        }
        
        let jsonData = try! JSONSerialization.data(withJSONObject: userInfo, options: [])
        
        do {
            let notificationAlert = try JSONDecoder().decode(NotificationAlert.self, from: jsonData)
            self.notificationAlert = notificationAlert
            print("[NOTIFICATION_ALERT]", notificationAlert)
        } catch {
            print("[NOTIFICATION_PARSING_ERROR]", error.localizedDescription)
        }

        completionHandler()
    }
}

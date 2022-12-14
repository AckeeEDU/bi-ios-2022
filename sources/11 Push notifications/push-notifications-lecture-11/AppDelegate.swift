//
//  AppDelegate.swift
//  push-notifications-lecture-11
//
//  Created by Igor Rosocha on 07.12.2022.
//

import UIKit

final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        PushManager.shared.start()
        
        return true
    }
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        let tokenString = deviceToken.map { String(format: "%02.2hhx", $0)}.joined()
        print("[DEVICE_TOKEN]", tokenString)
    }
}

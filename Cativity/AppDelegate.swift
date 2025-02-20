//
//  AppDelegate.swift
//  Cativity
//
//  Created by Wahyu Untoro on 20/05/24.
//

import UIKit
import UserNotifications
import ActivityKit

class AppDelegate: NSObject, ObservableObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
//    static let shared = AppDelegate()
    var navigationManager: NavigationManager?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Request notification permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("Notification permission granted: \(granted)")
            }
        }
        
        // Set the delegate
        UNUserNotificationCenter.current().delegate = self
        
        
        // Define actions
        let acceptAction = UNNotificationAction(identifier: "ACCEPT_ACTION",
                                                title: "Check-in sekarang",
                                                options: [.foreground])
        let declineAction = UNNotificationAction(identifier: "DECLINE_ACTION",
                                                 title: "Tunda",
                                                 options: [.destructive, .foreground])
        
        // Define category
        let meetingInviteCategory = UNNotificationCategory(identifier: "TASK_RECEIVE",
                                                           actions: [acceptAction, declineAction],
                                                           intentIdentifiers: [],
                                                           options: [])
        
        // Register the category
        UNUserNotificationCenter.current().setNotificationCategories([meetingInviteCategory])
        
        return true
    }
    
    // This method will be called when the app is in the foreground and a notification is received
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let content = notification.request.content
        print("Message received: \(content.body)")
        completionHandler([.alert, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            print("on tap \(response.actionIdentifier)")
        self.navigationManager?.navigateToPage = "PageToNavigate"
            completionHandler()
        }
}

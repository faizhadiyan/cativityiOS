//
//  NotificationManager.swift
//  Cativity
//
//  Created by Wahyu Untoro on 20/05/24.
//

import Foundation
import UserNotifications

func scheduleNotification(date: Date, title: String, body: String) {
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    content.sound = UNNotificationSound.default
    content.categoryIdentifier = "TASK_RECEIVE"
    
    var dateComponents = DateComponents()
    dateComponents.hour = extractHour(from: date) // 2 PM
    dateComponents.minute = extractMinute(from: date) + 3 // 2:30 PM
    
//    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)

    
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("Error: \(error.localizedDescription)")
        } else {
            print("Notification scheduled")
        }
    }
}

func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("Notification permission granted: \(granted)")
            }
        }
    }

func extractHour(from date: Date) -> Int {
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    return hour
}

func extractMinute(from date: Date) -> Int {
    let calendar = Calendar.current
    let hour = calendar.component(.minute, from: date)
    return hour
}

func checkNotificationPermission() {
    UNUserNotificationCenter.current().getNotificationSettings { settings in
        switch settings.authorizationStatus {
        case .authorized:
            print("Authorized")
        case .denied:
            print("Denied")
        case .notDetermined:
            print("Not determined")
        case .provisional:
            print("Provisional")
        case .ephemeral:
            print("Ephemeral")
        @unknown default:
            print("Unknown status")
        }
    }
}

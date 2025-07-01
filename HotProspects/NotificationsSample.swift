//
//  NotificationsSample.swift
//  HotProspects
//
//  Created by bino on 6/28/25.
//

import SwiftUI
import UserNotifications

struct NotificationsSample: View {
    var body: some View {
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the dog"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default
                
                // Show notif in 5 secs
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                // add the request
                UNUserNotificationCenter.current().add(request) { error in
                    if let error {
                        print("Error scheduling notification: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

#Preview {
    NotificationsSample()
}

import Foundation
import AppKit
import UserNotifications

NSApplication.shared.setActivationPolicy(.accessory)

let pasteboard = NSPasteboard.general
var lastChangeCount = pasteboard.changeCount
let charactersToTrim: Set<Character> = ["a", "p"]

let notificationCenter = UNUserNotificationCenter.current()
notificationCenter.requestAuthorization(options: [.alert, .sound]) { granted, error in
    if !granted {
        print("Notification permission denied")
    }
}

print("Clipboard Echo is running. Press Ctrl+C to stop.")

while true {
    if pasteboard.changeCount != lastChangeCount {
        lastChangeCount = pasteboard.changeCount
        if let copiedText = pasteboard.string(forType: .string) {
            let containsForbiddenChars = copiedText.contains { charactersToTrim.contains($0) }
            let trimmedText = String(copiedText.filter { !charactersToTrim.contains($0) })
            
            if containsForbiddenChars {
                let content = UNMutableNotificationContent()
                content.title = "Clipboard Cleaned"
                content.body = "Removed forbidden characters from clipboard"
                content.sound = .default
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
                notificationCenter.add(request)
            }
            
            pasteboard.clearContents()
            pasteboard.setString(trimmedText, forType: .string)
            lastChangeCount = pasteboard.changeCount
            print("📋 Copied: \(trimmedText)")
        }
    }
    Thread.sleep(forTimeInterval: 0.5)
}


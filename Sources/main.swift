import Foundation
import AppKit
import UserNotifications

NSApplication.shared.setActivationPolicy(.accessory)

let pasteboard = NSPasteboard.general
var lastChangeCount = pasteboard.changeCount
func isSuspiciousCharacter(_ char: Character) -> Bool {
    let scalar = char.unicodeScalars.first!
    let value = scalar.value
    
    // Zero-width and formatting characters
    if scalar.properties.isDefaultIgnorableCodePoint { return true }
    
    // Specific suspicious ranges
    switch value {
    case 0x200B...0x200F: return true  // Zero width spaces and marks
    case 0x202A...0x202E: return true  // Directional formatting
    case 0x2060...0x2069: return true  // Word joiner and isolates
    case 0xFEFF: return true           // Zero width no-break space
    case 0x061C: return true           // Arabic letter mark
    case 0x180E: return true           // Mongolian vowel separator
    case 0x034F: return true           // Combining grapheme joiner
    case 0xE0001: return true          // Language tag
    case 0xE0020...0xE007F: return true // Tag characters
    default: break
    }
    
    // Non-printable control characters (except common ones like newlines)
    if scalar.properties.generalCategory == .control {
        switch value {
        case 0x09, 0x0A, 0x0D: return false  // Keep tab, newline, carriage return
        default: return true
        }
    }
    
    return false
}

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
            let containsForbiddenChars = copiedText.contains(where: isSuspiciousCharacter)
            let trimmedText = String(copiedText.filter { !isSuspiciousCharacter($0) })
            
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


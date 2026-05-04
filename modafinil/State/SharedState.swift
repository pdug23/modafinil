import Foundation

enum SharedState {
    static let appGroup = "group.com.patrick.modafinil"

    private enum Key {
        static let isWired = "isWired"
        static let expiresAtTimestamp = "expiresAtTimestamp"
        static let durationLabel = "durationLabel"
        static let pendingIntent = "pendingIntent"
        static let lastUpdated = "lastUpdated"
    }

    private static var defaults: UserDefaults? {
        UserDefaults(suiteName: appGroup)
    }

    struct Snapshot {
        let isWired: Bool
        let expiresAt: Date?
        let duration: Duration?
    }

    static func write(isWired: Bool, duration: Duration?, expiresAt: Date?) {
        guard let defaults else { return }
        defaults.set(isWired, forKey: Key.isWired)
        if let timestamp = expiresAt?.timeIntervalSince1970 {
            defaults.set(timestamp, forKey: Key.expiresAtTimestamp)
        } else {
            defaults.removeObject(forKey: Key.expiresAtTimestamp)
        }
        if let label = duration?.storageLabel {
            defaults.set(label, forKey: Key.durationLabel)
        } else {
            defaults.removeObject(forKey: Key.durationLabel)
        }
        defaults.set(Date().timeIntervalSince1970, forKey: Key.lastUpdated)
    }

    static func readSnapshot() -> Snapshot {
        guard let defaults else {
            return Snapshot(isWired: false, expiresAt: nil, duration: nil)
        }
        let isWired = defaults.bool(forKey: Key.isWired)
        let expiresAt: Date? = {
            let timestamp = defaults.double(forKey: Key.expiresAtTimestamp)
            return timestamp > 0 ? Date(timeIntervalSince1970: timestamp) : nil
        }()
        let duration: Duration? = {
            guard let label = defaults.string(forKey: Key.durationLabel) else { return nil }
            return Duration(storageLabel: label)
        }()
        return Snapshot(isWired: isWired, expiresAt: expiresAt, duration: duration)
    }

    static func consumePendingIntent() -> String? {
        guard let defaults else { return nil }
        let intent = defaults.string(forKey: Key.pendingIntent)
        if intent != nil {
            defaults.removeObject(forKey: Key.pendingIntent)
        }
        return intent
    }

    static func setPendingIntent(_ intent: String) {
        defaults?.set(intent, forKey: Key.pendingIntent)
    }
}

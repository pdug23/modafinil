import Foundation

enum Duration: Equatable, Codable, Hashable {
    case indefinite
    case minutes(Int)
    case hours(Int)

    var seconds: Int? {
        switch self {
        case .indefinite: return nil
        case .minutes(let m): return m * 60
        case .hours(let h): return h * 3600
        }
    }

    var shortLabel: String {
        switch self {
        case .indefinite: return "∞"
        case .minutes(let m): return "\(m)m"
        case .hours(let h): return "\(h)h"
        }
    }

    var storageLabel: String {
        switch self {
        case .indefinite: return "inf"
        case .minutes(let m): return "\(m)m"
        case .hours(let h): return "\(h)h"
        }
    }

    init?(storageLabel: String) {
        if storageLabel == "inf" {
            self = .indefinite
        } else if storageLabel.hasSuffix("m"), let n = Int(storageLabel.dropLast()) {
            self = .minutes(n)
        } else if storageLabel.hasSuffix("h"), let n = Int(storageLabel.dropLast()) {
            self = .hours(n)
        } else {
            return nil
        }
    }

    static let presets: [Duration] = [
        .minutes(15), .minutes(30), .hours(1), .hours(2), .indefinite
    ]
}

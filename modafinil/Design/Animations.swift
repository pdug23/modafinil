import SwiftUI

extension Animation {
    static let modSpring = Animation.spring(response: 0.32, dampingFraction: 0.78)
    static let modSubtle = Animation.easeInOut(duration: 0.18)
    static let modBreathe = Animation.easeInOut(duration: 4.0).repeatForever(autoreverses: true)
}

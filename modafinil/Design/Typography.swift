import SwiftUI

extension Font {
    static let modStatus = Font.system(size: 28, weight: .semibold, design: .default)
    static let modHero = Font.system(size: 32, weight: .medium, design: .rounded).monospacedDigit()
    static let modPill = Font.system(size: 12, weight: .medium, design: .default).monospacedDigit()
    static let modCTA = Font.system(size: 14, weight: .semibold, design: .default)
    static let modCaption = Font.system(size: 11, weight: .regular, design: .default)
}

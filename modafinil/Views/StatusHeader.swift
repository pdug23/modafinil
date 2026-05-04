import SwiftUI
import AppKit

struct StatusHeader: View {
    let isWired: Bool

    var body: some View {
        HStack(spacing: 8) {
            Circle()
                .fill(isWired ? Color.modAccent : Color(nsColor: .tertiaryLabelColor))
                .frame(width: 8, height: 8)
                .shadow(color: .modAccent.opacity(isWired ? 0.6 : 0), radius: 6)
                .animation(.modSpring, value: isWired)
            Text(isWired ? "Wired" : "Off")
                .font(.modStatus)
                .tracking(-0.5)
                .id(isWired)
                .transition(.opacity)
            Spacer()
        }
        .animation(.modSubtle, value: isWired)
    }
}

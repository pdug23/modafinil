import SwiftUI

struct StatusHeader: View {
    let isWired: Bool

    var body: some View {
        HStack(spacing: 8) {
            dot
            Text(isWired ? "Wired" : "Off")
                .font(.modStatus)
                .tracking(-0.5)
            Spacer()
        }
    }

    @ViewBuilder
    private var dot: some View {
        if isWired {
            Circle()
                .fill(Color.modAccent)
                .frame(width: 8, height: 8)
                .shadow(color: .modAccent.opacity(0.6), radius: 6)
        } else {
            Circle()
                .fill(.tertiary)
                .frame(width: 8, height: 8)
        }
    }
}

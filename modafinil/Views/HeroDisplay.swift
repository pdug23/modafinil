import SwiftUI

struct HeroDisplay: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        VStack(spacing: 12) {
            glyph
                .frame(height: 44)
            Text(caption)
                .font(.modCaption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }

    @ViewBuilder
    private var glyph: some View {
        if appState.isWired {
            if let remaining = appState.remainingSeconds {
                Text(formatCountdown(remaining))
                    .font(.modHero)
                    .foregroundStyle(Color.modAccent)
            } else {
                Text("∞")
                    .font(.modHero)
                    .foregroundStyle(Color.modAccent)
            }
        } else {
            Image(systemName: "moon")
                .font(.modHero)
                .foregroundStyle(.tertiary)
        }
    }

    private var caption: String {
        if appState.isWired {
            if let expiresAt = appState.expiresAt {
                let formatter = DateFormatter()
                formatter.timeStyle = .short
                return "until \(formatter.string(from: expiresAt))"
            } else {
                return "keeping awake"
            }
        } else {
            return "ready to wire"
        }
    }

    private func formatCountdown(_ seconds: Int) -> String {
        let h = seconds / 3600
        let m = (seconds % 3600) / 60
        let s = seconds % 60
        if h > 0 {
            return String(format: "%d:%02d:%02d", h, m, s)
        } else {
            return String(format: "%02d:%02d", m, s)
        }
    }
}

import SwiftUI

struct HeroDisplay: View {
    @Environment(AppState.self) private var appState
    @State private var breathing = false

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                glyph
                    .id(glyphID)
                    .transition(.scale(scale: 0.7).combined(with: .opacity))
            }
            .frame(height: 44)
            .animation(.modSpring, value: glyphID)

            Text(caption)
                .font(.modCaption)
                .foregroundStyle(.secondary)
                .id(caption)
                .transition(.opacity)
                .animation(.modSubtle, value: caption)
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            withAnimation(.modBreathe) {
                breathing = true
            }
        }
    }

    private var glyphID: String {
        if !appState.isWired { return "off" }
        return appState.remainingSeconds == nil ? "infinite" : "timed"
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
                    .scaleEffect(breathing ? 1.03 : 1.0)
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

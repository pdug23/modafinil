import SwiftUI

struct DurationPills: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        HStack(spacing: 6) {
            ForEach(Duration.presets, id: \.self) { duration in
                Button {
                    handleTap(duration)
                } label: {
                    Text(duration.shortLabel)
                }
                .buttonStyle(PillButtonStyle(isSelected: isSelected(duration)))
            }
        }
    }

    private func isSelected(_ duration: Duration) -> Bool {
        appState.isWired && appState.currentDuration == duration
    }

    private func handleTap(_ duration: Duration) {
        if appState.isWired && appState.currentDuration == duration {
            appState.deactivate()
        } else {
            appState.activate(duration: duration)
        }
    }
}

import SwiftUI

struct PopoverView: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        VStack(spacing: 14) {
            StatusHeader(isWired: appState.isWired)
            DurationPills()
            if appState.isWired {
                PrimaryButton()
            }
            Divider()
                .opacity(0.08)
            FooterRow()
        }
        .padding(16)
        .frame(width: 280)
    }
}

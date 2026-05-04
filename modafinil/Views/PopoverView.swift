import SwiftUI
import AppKit

struct PopoverView: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(appState.isWired ? "Wired" : "Off")
                .font(.modStatus)
                .tracking(-0.5)
            Button("Quit Modafinil") {
                NSApplication.shared.terminate(nil)
            }
        }
        .padding(16)
        .frame(width: 280)
    }
}

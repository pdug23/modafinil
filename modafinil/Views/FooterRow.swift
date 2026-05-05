import SwiftUI
import AppKit

struct FooterRow: View {
    @Environment(\.openSettings) private var openSettings

    var body: some View {
        HStack {
            Button {
                NSApp.activate(ignoringOtherApps: true)
                openSettings()
            } label: {
                Image(systemName: "gearshape")
                    .font(.system(size: 14))
                    .foregroundStyle(.tertiary)
            }
            .buttonStyle(.plain)

            Spacer()

            Button {
                NSApplication.shared.terminate(nil)
            } label: {
                Text("quit")
                    .font(.modCaption)
                    .tracking(-0.5)
                    .foregroundStyle(.tertiary)
            }
            .buttonStyle(.plain)
        }
    }
}

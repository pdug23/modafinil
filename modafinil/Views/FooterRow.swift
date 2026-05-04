import SwiftUI
import AppKit

struct FooterRow: View {
    var body: some View {
        HStack {
            Image(systemName: "gearshape")
                .font(.system(size: 14))
                .foregroundStyle(.tertiary)
            Spacer()
            Button {
                NSApplication.shared.terminate(nil)
            } label: {
                Text("Quit")
                    .font(.modCaption)
                    .foregroundStyle(.tertiary)
            }
            .buttonStyle(.plain)
        }
    }
}

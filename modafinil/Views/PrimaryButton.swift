import SwiftUI

struct PrimaryButton: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        Button {
            appState.deactivate()
        } label: {
            Text("off")
                .tracking(-0.5)
        }
        .buttonStyle(PrimaryButtonStyle(isWired: true))
    }
}

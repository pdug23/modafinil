import SwiftUI

struct PrimaryButton: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        Button {
            appState.toggle()
        } label: {
            Text(appState.isWired ? "Go to Sleep" : "Stay Wired")
        }
        .buttonStyle(PrimaryButtonStyle(isWired: appState.isWired))
    }
}

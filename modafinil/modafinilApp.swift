import SwiftUI
import AppKit

@main
struct ModafinilApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        MenuBarExtra {
            Button(appDelegate.appState.isWired ? "Wired" : "Off") {
                appDelegate.appState.toggle()
            }
            Divider()
            Button("Quit Modafinil") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q")
        } label: {
            Image(systemName: appDelegate.appState.isWired ? "pills.fill" : "pills")
        }
        .menuBarExtraStyle(.menu)
    }
}

final class AppDelegate: NSObject, NSApplicationDelegate {
    let appState = AppState()

    func applicationWillTerminate(_ notification: Notification) {
        appState.stopForTermination()
    }
}

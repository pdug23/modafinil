import SwiftUI
import AppKit

@main
struct ModafinilApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        MenuBarExtra {
            PopoverView()
                .environment(appDelegate.appState)
        } label: {
            Image(appDelegate.appState.isWired ? "MenuBarIconFilled" : "MenuBarIcon")
                .opacity(appDelegate.appState.isWired ? 1.0 : 0.3)
        }
        .menuBarExtraStyle(.window)

        Settings {
            SettingsView()
        }
    }
}

final class AppDelegate: NSObject, NSApplicationDelegate {
    let appState = AppState()

    func applicationWillTerminate(_ notification: Notification) {
        appState.stopForTermination()
    }
}

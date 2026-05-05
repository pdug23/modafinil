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
            Image(systemName: appDelegate.appState.isWired ? "pills.fill" : "pills")
                .foregroundStyle(appDelegate.appState.isWired ? AnyShapeStyle(Color.modAccent) : AnyShapeStyle(.foreground))
        }
        .menuBarExtraStyle(.window)
    }
}

final class AppDelegate: NSObject, NSApplicationDelegate {
    let appState = AppState()

    func applicationWillTerminate(_ notification: Notification) {
        appState.stopForTermination()
    }
}

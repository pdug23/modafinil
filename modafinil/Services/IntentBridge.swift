import Foundation

@MainActor
final class IntentBridge {
    private let appState: AppState
    private var timer: Timer?

    init(appState: AppState) {
        self.appState = appState
    }

    func start() {
        stop()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            guard let self else { return }
            Task { @MainActor [self] in
                self.poll()
            }
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    private func poll() {
        guard let intent = SharedState.consumePendingIntent() else { return }
        handle(intent)
    }

    private func handle(_ intent: String) {
        if intent == "toggle" {
            appState.toggle()
        } else if intent.hasPrefix("set:") {
            let label = String(intent.dropFirst(4))
            if let duration = Duration(storageLabel: label) {
                appState.activate(duration: duration)
            }
        }
    }
}

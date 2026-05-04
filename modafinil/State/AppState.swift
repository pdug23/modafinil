import Foundation
import Observation
import AppKit

@Observable
final class AppState {
    private(set) var isWired: Bool = false
    private(set) var currentDuration: Duration?
    private(set) var expiresAt: Date?
    private(set) var remainingSeconds: Int?

    @ObservationIgnored private let caffeinate = CaffeinateManager()
    @ObservationIgnored private var tickTimer: Timer?

    private static let lastUsedKey = "lastUsedDuration"

    var lastUsedDuration: Duration {
        get {
            let label = UserDefaults.standard.string(forKey: Self.lastUsedKey) ?? "inf"
            return Duration(storageLabel: label) ?? .indefinite
        }
        set {
            UserDefaults.standard.set(newValue.storageLabel, forKey: Self.lastUsedKey)
        }
    }

    init() {
        caffeinate.didTerminate = { [weak self] in
            self?.handleProcessExit()
        }
    }

    func toggle() {
        if isWired {
            deactivate()
        } else {
            activate(duration: lastUsedDuration)
        }
    }

    func activate(duration: Duration) {
        do {
            try caffeinate.start(duration: duration)
            isWired = true
            currentDuration = duration
            lastUsedDuration = duration
            if let seconds = duration.seconds {
                expiresAt = Date().addingTimeInterval(TimeInterval(seconds))
                remainingSeconds = seconds
                startTickTimer()
            } else {
                expiresAt = nil
                remainingSeconds = nil
                stopTickTimer()
            }
            haptic()
        } catch {
            clearState()
        }
    }

    func deactivate() {
        caffeinate.stop()
        clearState()
        haptic()
    }

    private func haptic() {
        NSHapticFeedbackManager.defaultPerformer.perform(.alignment, performanceTime: .now)
    }

    func stopForTermination() {
        caffeinate.stop()
    }

    private func handleProcessExit() {
        clearState()
    }

    private func clearState() {
        isWired = false
        currentDuration = nil
        expiresAt = nil
        remainingSeconds = nil
        stopTickTimer()
    }

    private func tick() {
        guard let expiresAt else { return }
        let remaining = max(0, Int(expiresAt.timeIntervalSinceNow.rounded()))
        remainingSeconds = remaining
    }

    private func startTickTimer() {
        stopTickTimer()
        tickTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self else { return }
            Task { @MainActor [self] in
                self.tick()
            }
        }
    }

    private func stopTickTimer() {
        tickTimer?.invalidate()
        tickTimer = nil
    }
}

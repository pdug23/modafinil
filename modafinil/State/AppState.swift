import Foundation
import Observation

@Observable
final class AppState {
    private(set) var isWired: Bool = false
    private let caffeinate = CaffeinateManager()

    init() {
        caffeinate.didTerminate = { [weak self] in
            self?.isWired = false
        }
    }

    func toggle() {
        if isWired {
            caffeinate.stop()
            isWired = false
        } else {
            do {
                try caffeinate.start()
                isWired = true
            } catch {
                isWired = false
            }
        }
    }

    func stopForTermination() {
        caffeinate.stop()
    }
}

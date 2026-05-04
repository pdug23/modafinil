import Foundation

final class CaffeinateManager {
    private var process: Process?
    var didTerminate: (() -> Void)?

    var isRunning: Bool { process?.isRunning ?? false }

    func start() throws {
        stop()
        let p = Process()
        p.executableURL = URL(fileURLWithPath: "/usr/bin/caffeinate")
        p.arguments = ["-d", "-i", "-s"]
        p.terminationHandler = { [weak self] _ in
            Task { @MainActor in
                self?.process = nil
                self?.didTerminate?()
            }
        }
        try p.run()
        process = p
    }

    func stop() {
        process?.terminationHandler = nil
        process?.terminate()
        process = nil
    }
}

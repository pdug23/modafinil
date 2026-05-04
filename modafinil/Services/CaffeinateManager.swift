import Foundation

final class CaffeinateManager {
    private var process: Process?
    var didTerminate: (() -> Void)?

    var isRunning: Bool { process?.isRunning ?? false }

    func start(duration: Duration) throws {
        stop()
        let p = Process()
        p.executableURL = URL(fileURLWithPath: "/usr/bin/caffeinate")
        var args = ["-d", "-i", "-s"]
        if let seconds = duration.seconds {
            args.append(contentsOf: ["-t", String(seconds)])
        }
        p.arguments = args
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

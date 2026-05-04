import AppIntents

struct ToggleWiredIntent: AppIntent {
    static var title: LocalizedStringResource = "Toggle Wired"
    static var description = IntentDescription("Toggle keeping your Mac awake.")

    func perform() async throws -> some IntentResult {
        SharedState.setPendingIntent("toggle")
        return .result()
    }
}

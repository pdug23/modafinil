import WidgetKit
import Foundation

struct WidgetEntry: TimelineEntry {
    let date: Date
    let isWired: Bool
    let expiresAt: Date?
    let duration: Duration?
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WidgetEntry {
        WidgetEntry(date: Date(), isWired: false, expiresAt: nil, duration: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (WidgetEntry) -> Void) {
        let snapshot = SharedState.readSnapshot()
        completion(WidgetEntry(
            date: Date(),
            isWired: snapshot.isWired,
            expiresAt: snapshot.expiresAt,
            duration: snapshot.duration
        ))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<WidgetEntry>) -> Void) {
        let snapshot = SharedState.readSnapshot()
        let now = Date()

        guard snapshot.isWired else {
            let entry = WidgetEntry(date: now, isWired: false, expiresAt: nil, duration: nil)
            completion(Timeline(entries: [entry], policy: .never))
            return
        }

        guard let expiresAt = snapshot.expiresAt else {
            let entry = WidgetEntry(date: now, isWired: true, expiresAt: nil, duration: snapshot.duration)
            completion(Timeline(entries: [entry], policy: .never))
            return
        }

        var entries: [WidgetEntry] = []
        var entryDate = now
        while entryDate < expiresAt {
            entries.append(WidgetEntry(date: entryDate, isWired: true, expiresAt: expiresAt, duration: snapshot.duration))
            entryDate = entryDate.addingTimeInterval(60)
        }
        entries.append(WidgetEntry(date: expiresAt, isWired: false, expiresAt: nil, duration: nil))
        completion(Timeline(entries: entries, policy: .atEnd))
    }
}

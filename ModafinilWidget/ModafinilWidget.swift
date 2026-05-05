import WidgetKit
import SwiftUI

struct ModafinilWidget: Widget {
    let kind: String = "ModafinilWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ModafinilWidgetEntryView(entry: entry)
                .containerBackground(for: .widget) {
                    WidgetBackground(isWired: entry.isWired)
                }
        }
        .configurationDisplayName("Modafinil")
        .description("Keep your Mac awake.")
        .supportedFamilies([.systemMedium])
    }
}

private struct WidgetBackground: View {
    let isWired: Bool

    var body: some View {
        if isWired {
            MeshGradient(
                width: 3,
                height: 3,
                points: [
                    [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                    [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
                    [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                ],
                colors: [
                    Color.modAccentBright, Color.modAccentBright, Color.modAccent,
                    Color.modAccentBright, Color.modAccent,       Color.modAccentMuted,
                    Color.modAccent,       Color.modAccentMuted,  Color.modAccentDeep
                ]
            )
        } else {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.10, green: 0.10, blue: 0.11),
                        Color(red: 0.055, green: 0.055, blue: 0.06)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                RadialGradient(
                    colors: [Color.white.opacity(0.05), Color.clear],
                    center: .topLeading,
                    startRadius: 0,
                    endRadius: 240
                )
            }
        }
    }
}

struct ModafinilWidgetEntryView: View {
    let entry: WidgetEntry

    var body: some View {
        VStack(spacing: 0) {
            Wordmark(isWired: entry.isWired)
                .padding(.top, 14)
            Spacer(minLength: 0)
            HeroStatus(entry: entry)
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

private struct Wordmark: View {
    let isWired: Bool

    var body: some View {
        HStack(spacing: 7) {
            PillGlyph(strokeRatio: 3)
                .foregroundStyle(isWired ? Color.modSurfaceDark : Color.white.opacity(0.45))
                .frame(width: 13, height: 20)
            Text("modafinil")
                .font(.system(size: 15, weight: .medium, design: .monospaced))
                .tracking(-0.5)
                .foregroundStyle(isWired ? Color.modSurfaceDark : Color.white.opacity(0.50))
        }
    }
}

private struct HeroStatus: View {
    let entry: WidgetEntry

    var body: some View {
        Group {
            if entry.isWired {
                if let expiresAt = entry.expiresAt {
                    VStack(spacing: 4) {
                        wiredLabel
                        Text(timerInterval: entry.date...expiresAt, countsDown: true)
                            .foregroundStyle(Color.modSurfaceDark)
                    }
                } else {
                    wiredLabel
                }
            } else {
                Text("off")
                    .foregroundStyle(Color.white.opacity(0.35))
            }
        }
        .font(.system(size: 15, weight: .medium, design: .monospaced))
        .tracking(-0.5)
    }

    private var wiredLabel: some View {
        HStack(spacing: 6) {
            Image(systemName: "circle.fill")
                .font(.system(size: 5))
                .foregroundStyle(Color.modSurfaceDark)
                .symbolEffect(.pulse, options: .repeating)
            Text("wired")
                .foregroundStyle(Color.modSurfaceDark)
        }
    }
}

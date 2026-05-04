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
        .supportedFamilies([.systemSmall])
    }
}

struct ModafinilWidgetEntryView: View {
    let entry: WidgetEntry

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            VStack {
                Spacer()
                glyph
                Spacer()
            }
            .frame(maxWidth: .infinity)

            Text(entry.isWired ? "Wired" : "Off")
                .font(.modCaption)
                .foregroundStyle(entry.isWired ? AnyShapeStyle(Color.white.opacity(0.8)) : AnyShapeStyle(.secondary))

            if entry.isWired {
                VStack {
                    HStack {
                        Spacer()
                        Circle()
                            .fill(Color.white.opacity(0.8))
                            .frame(width: 6, height: 6)
                    }
                    Spacer()
                }
            }
        }
    }

    @ViewBuilder
    private var glyph: some View {
        if entry.isWired {
            if let expiresAt = entry.expiresAt {
                Text(timerInterval: entry.date...expiresAt, countsDown: true)
                    .font(.system(size: 22, weight: .medium, design: .rounded))
                    .monospacedDigit()
                    .foregroundStyle(Color.white.opacity(0.95))
                    .multilineTextAlignment(.center)
            } else {
                Text("∞")
                    .font(.system(size: 44, weight: .medium, design: .rounded))
                    .foregroundStyle(Color.white.opacity(0.95))
            }
        } else {
            Image(systemName: "moon")
                .font(.system(size: 40, weight: .light))
                .foregroundStyle(.tertiary)
        }
    }
}

private struct WidgetBackground: View {
    let isWired: Bool

    var body: some View {
        if isWired {
            RadialGradient(
                colors: [Color.modAccent.opacity(0.85), Color.modAccentMuted.opacity(0.6)],
                center: .center,
                startRadius: 0,
                endRadius: 110
            )
        } else {
            Color.modSurfaceDark
        }
    }
}

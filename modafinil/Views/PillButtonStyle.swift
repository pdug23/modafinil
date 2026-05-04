import SwiftUI

struct PillButtonStyle: ButtonStyle {
    let isSelected: Bool

    func makeBody(configuration: Configuration) -> some View {
        PillBody(configuration: configuration, isSelected: isSelected)
    }

    private struct PillBody: View {
        let configuration: ButtonStyle.Configuration
        let isSelected: Bool
        @State private var isHovering = false

        var body: some View {
            configuration.label
                .font(.modPill)
                .frame(maxWidth: .infinity)
                .frame(height: 28)
                .foregroundStyle(isSelected ? AnyShapeStyle(Color.modAccent) : AnyShapeStyle(.secondary))
                .background(
                    RoundedRectangle(cornerRadius: 7)
                        .fill(backgroundFill(pressed: configuration.isPressed))
                )
                .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
                .animation(.modSpring, value: configuration.isPressed)
                .onHover { isHovering = $0 }
        }

        private func backgroundFill(pressed: Bool) -> Color {
            if isSelected {
                return Color.modAccent.opacity(pressed ? 0.20 : 0.15)
            } else if pressed {
                return Color.primary.opacity(0.10)
            } else if isHovering {
                return Color.primary.opacity(0.05)
            } else {
                return Color.clear
            }
        }
    }
}

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    let isWired: Bool

    func makeBody(configuration: Configuration) -> some View {
        PrimaryBody(configuration: configuration, isWired: isWired)
    }

    private struct PrimaryBody: View {
        let configuration: ButtonStyle.Configuration
        let isWired: Bool
        @State private var isHovering = false

        var body: some View {
            configuration.label
                .font(.modCTA)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .foregroundStyle(isWired ? AnyShapeStyle(Color.modAccent) : AnyShapeStyle(.primary))
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(backgroundFill(pressed: configuration.isPressed))
                )
                .scaleEffect(configuration.isPressed ? 0.99 : 1.0)
                .animation(.modSubtle, value: configuration.isPressed)
                .animation(.modSubtle, value: isWired)
                .onHover { isHovering = $0 }
        }

        private func backgroundFill(pressed: Bool) -> Color {
            let base: Double = isWired ? 0.15 : 0.08
            let hover: Double = isHovering ? 0.05 : 0
            let press: Double = pressed ? 0.05 : 0
            let total = base + hover + press
            return isWired ? Color.modAccent.opacity(total) : Color.primary.opacity(total)
        }
    }
}

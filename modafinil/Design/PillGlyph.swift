import SwiftUI

struct PillGlyph: View {
    var strokeRatio: CGFloat = 3

    var body: some View {
        Canvas { ctx, size in
            let pillAspect: CGFloat = 44.0 / 70.0
            let widthFromHeight = size.height * pillAspect
            let pillW = min(size.width, widthFromHeight)
            let pillH = pillW / pillAspect
            let strokeWidth = max(1, pillW * strokeRatio / 44.0)
            let inset = strokeWidth / 2
            let radius = max(0, pillW * 20.0 / 44.0 - inset)
            let originX = (size.width - pillW) / 2
            let originY = (size.height - pillH) / 2
            let rect = CGRect(
                x: originX + inset,
                y: originY + inset,
                width: pillW - strokeWidth,
                height: pillH - strokeWidth
            )
            var path = Path(roundedRect: rect, cornerRadius: radius)
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            ctx.stroke(path, with: .style(.foreground), lineWidth: strokeWidth)
        }
        .aspectRatio(44.0 / 70.0, contentMode: .fit)
    }
}

import SwiftUI

/// A compact token-driven tooltip content container.
public struct CNTooltip<Content: View>: View {
    @Environment(\.cnTheme) private var theme

    private let content: Content

    /// Creates a tooltip content container.
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    /// The tooltip body.
    public var body: some View {
        content
            .font(theme.typography.caption.font)
            .padding(.horizontal, theme.space.x3)
            .padding(.vertical, theme.space.x2)
            .frame(maxWidth: 240, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
            .background(theme.colors.popover.color)
            .foregroundStyle(theme.colors.popoverForeground.color)
            .clipShape(RoundedRectangle(cornerRadius: theme.radius.md))
            .cnBorder(color: theme.colors.border, cornerRadius: theme.radius.md)
            .shadow(
                color: theme.shadows.popover.color.color,
                radius: theme.shadows.popover.radius,
                x: theme.shadows.popover.x,
                y: theme.shadows.popover.y
            )
            .accessibilityElement(children: .combine)
    }
}

public extension View {
    /// Presents a plain text tooltip from a trigger view.
    func cnTooltip(
        _ text: String,
        arrowEdge: Edge = .top
    ) -> some View {
        help(text)
            .modifier(CNTooltipModifier(arrowEdge: arrowEdge) {
                Text(text)
            })
    }

    /// Presents custom tooltip content from a trigger view.
    func cnTooltip<TooltipContent: View>(
        arrowEdge: Edge = .top,
        @ViewBuilder content: @escaping () -> TooltipContent
    ) -> some View {
        modifier(CNTooltipModifier(arrowEdge: arrowEdge, tooltipContent: content))
    }
}

private struct CNTooltipModifier<TooltipContent: View>: ViewModifier {
    @State private var isPresented = false

    let arrowEdge: Edge
    let tooltipContent: () -> TooltipContent

    func body(content: Content) -> some View {
        content
            .contentShape(Rectangle())
            .onHover { isHovering in
                guard CNPlatform.supportsHover else {
                    return
                }

                isPresented = isHovering
            }
            .simultaneousGesture(
                TapGesture().onEnded {
                    isPresented.toggle()
                }
            )
            .popover(isPresented: $isPresented, arrowEdge: arrowEdge) {
                CNTooltip {
                    tooltipContent()
                }
            }
            .accessibilityHint("Shows a tooltip")
    }
}

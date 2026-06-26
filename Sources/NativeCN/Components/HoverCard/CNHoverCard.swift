import SwiftUI

/// A token-driven hover card content container.
public struct CNHoverCard<Content: View>: View {
    @Environment(\.cnTheme) private var theme

    private let content: Content

    /// Creates a hover card content container.
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    /// The hover card body.
    public var body: some View {
        content
            .padding(theme.space.x4)
            .frame(maxWidth: 320, alignment: .leading)
            .background(theme.colors.popover.color)
            .foregroundStyle(theme.colors.popoverForeground.color)
            .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
            .cnBorder(color: theme.colors.border, cornerRadius: theme.radius.lg)
            .accessibilityElement(children: .contain)
    }
}

public extension View {
    /// Presents a hover card from a trigger view.
    func cnHoverCard<HoverContent: View>(
        arrowEdge: Edge = .top,
        @ViewBuilder content: @escaping () -> HoverContent
    ) -> some View {
        modifier(CNHoverCardModifier(arrowEdge: arrowEdge, hoverContent: content))
    }
}

private struct CNHoverCardModifier<HoverContent: View>: ViewModifier {
    @State private var isPresented = false

    let arrowEdge: Edge
    let hoverContent: () -> HoverContent

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
                CNHoverCard {
                    hoverContent()
                }
            }
            .accessibilityHint("Shows more information")
    }
}

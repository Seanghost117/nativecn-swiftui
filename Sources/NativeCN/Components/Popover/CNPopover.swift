import SwiftUI

/// A token-driven popover content container.
public struct CNPopover<Content: View>: View {
    @Environment(\.cnTheme) private var theme

    private let content: Content

    /// Creates a popover content container.
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    /// The popover body.
    public var body: some View {
        content
            .padding(theme.space.x4)
            .frame(maxWidth: 320, alignment: .leading)
            .background(theme.colors.popover.color)
            .foregroundStyle(theme.colors.popoverForeground.color)
            .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
    }
}

public extension View {
    /// Presents a native SwiftUI popover containing NativeCN styled content.
    func cnPopover<PopoverContent: View>(
        isPresented: Binding<Bool>,
        arrowEdge: Edge = .top,
        @ViewBuilder content: @escaping () -> PopoverContent
    ) -> some View {
        popover(isPresented: isPresented, arrowEdge: arrowEdge) {
            CNPopover {
                content()
            }
        }
    }
}

import SwiftUI

/// A token-driven drawer surface for side-panel and task-panel flows.
public struct CNDrawer<Content: View>: View {
    @Environment(\.cnTheme) private var theme

    private let title: String?
    private let message: String?
    private let content: Content

    /// Creates a drawer content container.
    public init(
        title: String? = nil,
        message: String? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.message = message
        self.content = content()
    }

    /// The drawer body.
    public var body: some View {
        VStack(alignment: .leading, spacing: theme.space.x4) {
            if title != nil || message != nil {
                VStack(alignment: .leading, spacing: theme.space.x2) {
                    if let title {
                        Text(title)
                            .font(theme.typography.title3.font)
                            .foregroundStyle(theme.colors.foreground.color)
                            .accessibilityAddTraits(.isHeader)
                    }

                    if let message {
                        Text(message)
                            .font(theme.typography.body.font)
                            .foregroundStyle(theme.colors.mutedForeground.color)
                    }
                }
            }

            content
        }
        .padding(theme.space.x5)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(theme.colors.card.color)
        .cnBorder(color: theme.colors.border)
        .shadow(
            color: theme.shadows.sheet.color.color,
            radius: theme.shadows.sheet.radius,
            x: theme.shadows.sheet.x,
            y: theme.shadows.sheet.y
        )
        .accessibilityElement(children: .contain)
    }
}

/// A presenter that overlays a drawer above content.
public struct CNDrawerPresenter<Content: View, DrawerContent: View>: View {
    @Binding private var isPresented: Bool

    private let edge: Edge
    private let length: CGFloat
    private let allowsBackdropDismiss: Bool
    private let content: Content
    private let drawer: DrawerContent

    /// Creates a drawer presenter.
    public init(
        isPresented: Binding<Bool>,
        edge: Edge = .trailing,
        length: CGFloat = 360,
        allowsBackdropDismiss: Bool = true,
        @ViewBuilder drawer: () -> DrawerContent,
        @ViewBuilder content: () -> Content
    ) {
        self._isPresented = isPresented
        self.edge = edge
        self.length = Self.normalizedLength(length)
        self.allowsBackdropDismiss = allowsBackdropDismiss
        self.drawer = drawer()
        self.content = content()
    }

    /// The presenter body.
    public var body: some View {
        ZStack(alignment: Self.alignment(for: edge)) {
            content
                .disabled(isPresented)

            if isPresented {
                Color.black.opacity(0.28)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .accessibilityHidden(true)
                    .onTapGesture {
                        guard allowsBackdropDismiss else {
                            return
                        }

                        isPresented = false
                    }

                drawer
                    .frame(
                        maxWidth: Self.isSideEdge(edge) ? length : .infinity,
                        maxHeight: Self.isSideEdge(edge) ? .infinity : length
                    )
                    .transition(.move(edge: edge).combined(with: .opacity))
            }
        }
    }

    /// Returns a layout-safe drawer length.
    public static func normalizedLength(_ length: CGFloat) -> CGFloat {
        guard length.isFinite, length > 0 else {
            return 360
        }

        return length
    }

    /// Returns whether an edge presents as a side drawer.
    public static func isSideEdge(_ edge: Edge) -> Bool {
        switch edge {
        case .leading, .trailing:
            return true
        case .top, .bottom:
            return false
        }
    }

    private static func alignment(for edge: Edge) -> Alignment {
        switch edge {
        case .top:
            return .top
        case .bottom:
            return .bottom
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        }
    }
}

public extension View {
    /// Presents a token-driven drawer overlay.
    func cnDrawer<DrawerContent: View>(
        isPresented: Binding<Bool>,
        edge: Edge = .trailing,
        length: CGFloat = 360,
        allowsBackdropDismiss: Bool = true,
        title: String? = nil,
        message: String? = nil,
        @ViewBuilder content: @escaping () -> DrawerContent
    ) -> some View {
        CNDrawerPresenter(
            isPresented: isPresented,
            edge: edge,
            length: length,
            allowsBackdropDismiss: allowsBackdropDismiss
        ) {
            CNDrawer(title: title, message: message) {
                content()
            }
        } content: {
            self
        }
    }
}

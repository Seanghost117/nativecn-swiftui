import SwiftUI

/// A token-driven dialog surface for confirm flows.
public struct CNDialog<Content: View, Actions: View>: View {
    @Environment(\.cnTheme) private var theme

    private let title: String
    private let message: String?
    private let content: Content
    private let actions: Actions

    /// Creates a dialog surface.
    public init(
        title: String,
        message: String? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder actions: () -> Actions
    ) {
        self.title = title
        self.message = message
        self.content = content()
        self.actions = actions()
    }

    /// The dialog body.
    public var body: some View {
        VStack(alignment: .leading, spacing: theme.space.x4) {
            VStack(alignment: .leading, spacing: theme.space.x2) {
                Text(title)
                    .font(theme.typography.title3.font)
                    .foregroundStyle(theme.colors.foreground.color)
                    .accessibilityAddTraits(.isHeader)

                if let message {
                    Text(message)
                        .font(theme.typography.body.font)
                        .foregroundStyle(theme.colors.mutedForeground.color)
                }
            }

            content

            HStack(spacing: theme.space.x2) {
                Spacer()
                actions
            }
        }
        .padding(theme.space.x5)
        .frame(maxWidth: 420)
        .background(theme.colors.card.color)
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.x2l))
        .cnBorder(color: theme.colors.border, cornerRadius: theme.radius.x2l)
        .shadow(
            color: theme.shadows.sheet.color.color,
            radius: theme.shadows.sheet.radius,
            x: theme.shadows.sheet.x,
            y: theme.shadows.sheet.y
        )
        .accessibilityElement(children: .contain)
    }
}

public extension CNDialog where Content == EmptyView {
    /// Creates a dialog surface without custom body content.
    init(
        title: String,
        message: String? = nil,
        @ViewBuilder actions: () -> Actions
    ) {
        self.init(title: title, message: message) {
            EmptyView()
        } actions: {
            actions()
        }
    }
}

/// A presenter that overlays a `CNDialog` above content.
public struct CNDialogPresenter<Content: View, DialogContent: View>: View {
    @Binding private var isPresented: Bool
    private let content: Content
    private let dialog: DialogContent

    /// Creates a dialog presenter.
    public init(isPresented: Binding<Bool>, @ViewBuilder dialog: () -> DialogContent, @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.dialog = dialog()
        self.content = content()
    }

    /// The presenter body.
    public var body: some View {
        ZStack {
            content
                .disabled(isPresented)

            if isPresented {
                Color.black.opacity(0.28)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .accessibilityHidden(true)

                dialog
                    .padding()
                    .transition(.scale(scale: 0.96).combined(with: .opacity))
            }
        }
    }
}

public extension View {
    /// Presents a token-driven dialog overlay.
    func cnDialog<DialogContent: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder dialog: @escaping () -> DialogContent
    ) -> some View {
        CNDialogPresenter(isPresented: isPresented, dialog: dialog) {
            self
        }
    }
}

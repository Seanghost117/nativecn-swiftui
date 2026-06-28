import SwiftUI

/// A token-driven toast notification.
public struct CNToast: Identifiable, Sendable, Equatable {
    /// Toast visual variants.
    public enum Variant: String, CaseIterable, Sendable, Equatable {
        /// Neutral toast.
        case `default`

        /// Success toast.
        case success

        /// Warning toast.
        case warning

        /// Destructive or error toast.
        case destructive
    }

    /// Toast placement.
    public enum Placement: String, Sendable, Equatable {
        /// Top placement.
        case top

        /// Bottom placement.
        case bottom
    }

    /// Toast identifier.
    public var id: UUID

    /// Toast title.
    public var title: String

    /// Optional toast message.
    public var message: String?

    /// Visual variant.
    public var variant: Variant

    /// Toast placement.
    public var placement: Placement

    /// Creates a toast value.
    public init(
        id: UUID = UUID(),
        title: String,
        message: String? = nil,
        variant: Variant = .default,
        placement: Placement = .bottom
    ) {
        self.id = id
        self.title = title
        self.message = message
        self.variant = variant
        self.placement = placement
    }
}

/// A rendered toast view.
public struct CNToastView: View {
    @Environment(\.cnTheme) private var theme

    private let toast: CNToast
    private let onDismiss: (() -> Void)?

    /// Creates a toast view.
    public init(_ toast: CNToast, onDismiss: (() -> Void)? = nil) {
        self.toast = toast
        self.onDismiss = onDismiss
    }

    /// The toast body.
    public var body: some View {
        let style = toast.variant.alertVariant.style(in: theme)

        HStack(alignment: .top, spacing: theme.space.x3) {
            Image(systemName: toast.variant.alertVariant.defaultSystemImage)
                .foregroundStyle(style.foreground.color)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: theme.space.x1) {
                Text(toast.title)
                    .font(theme.typography.headline.font)
                    .foregroundStyle(style.foreground.color)

                if let message = toast.message {
                    Text(message)
                        .font(theme.typography.subheadline.font)
                        .foregroundStyle(style.messageForeground.color)
                }
            }

            Spacer(minLength: theme.space.x2)

            if let onDismiss {
                Button {
                    onDismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.caption.weight(.bold))
                }
                .buttonStyle(.plain)
                .foregroundStyle(style.messageForeground.color)
                .accessibilityLabel("Dismiss")
            }
        }
        .padding(theme.space.x4)
        .background(style.background.color)
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
        .cnBorder(color: style.border, cornerRadius: theme.radius.lg)
        .shadow(
            color: theme.shadows.popover.color.color,
            radius: theme.shadows.popover.radius,
            x: theme.shadows.popover.x,
            y: theme.shadows.popover.y
        )
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isStaticText)
    }
}

/// A toast presenter that overlays a single toast at the top or bottom of a view.
public struct CNToastPresenter<Content: View>: View {
    private let toast: Binding<CNToast?>
    private let content: Content

    /// Creates a toast presenter.
    public init(toast: Binding<CNToast?>, @ViewBuilder content: () -> Content) {
        self.toast = toast
        self.content = content()
    }

    /// The presenter body.
    public var body: some View {
        ZStack {
            content

            if let currentToast = toast.wrappedValue {
                VStack {
                    if currentToast.placement == .bottom {
                        Spacer()
                    }

                    CNToastView(currentToast) {
                        toast.wrappedValue = nil
                    }
                    .padding()
                    .transition(.move(edge: currentToast.placement == .top ? .top : .bottom).combined(with: .opacity))

                    if currentToast.placement == .top {
                        Spacer()
                    }
                }
            }
        }
    }
}

/// A toast presenter that overlays a stack of NativeCN toasts.
public struct CNToaster<Content: View>: View {
    @Environment(\.cnTheme) private var theme

    private let toasts: Binding<[CNToast]>
    private let placement: CNToast.Placement
    private let maxVisible: Int
    private let content: Content

    /// Creates a toast stack presenter.
    public init(
        toasts: Binding<[CNToast]>,
        placement: CNToast.Placement = .bottom,
        maxVisible: Int = 3,
        @ViewBuilder content: () -> Content
    ) {
        self.toasts = toasts
        self.placement = placement
        self.maxVisible = max(1, maxVisible)
        self.content = content()
    }

    /// The presenter body.
    public var body: some View {
        ZStack {
            content

            VStack {
                if placement == .bottom {
                    Spacer()
                }

                toastStack
                    .padding(theme.space.x4)

                if placement == .top {
                    Spacer()
                }
            }
        }
    }

    private var visibleToasts: [CNToast] {
        Array(toasts.wrappedValue.suffix(maxVisible))
    }

    private var toastStack: some View {
        VStack(spacing: theme.space.x3) {
            ForEach(visibleToasts) { toast in
                CNToastView(toast) {
                    dismiss(toast)
                }
                .transition(.move(edge: placement == .top ? .top : .bottom).combined(with: .opacity))
            }
        }
    }

    private func dismiss(_ toast: CNToast) {
        toasts.wrappedValue.removeAll { $0.id == toast.id }
    }
}

public extension View {
    /// Presents a NativeCN toast over this view.
    func cnToast(_ toast: Binding<CNToast?>) -> some View {
        CNToastPresenter(toast: toast) {
            self
        }
    }

    /// Presents a stack of NativeCN toasts over this view.
    func cnToaster(_ toasts: Binding<[CNToast]>, placement: CNToast.Placement = .bottom, maxVisible: Int = 3) -> some View {
        CNToaster(toasts: toasts, placement: placement, maxVisible: maxVisible) {
            self
        }
    }
}

private extension CNToast.Variant {
    var alertVariant: CNAlert<EmptyView>.Variant {
        switch self {
        case .default:
            return .default
        case .success:
            return .success
        case .warning:
            return .warning
        case .destructive:
            return .destructive
        }
    }
}

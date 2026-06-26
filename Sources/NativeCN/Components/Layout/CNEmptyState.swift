import SwiftUI

/// A centered empty-state layout with optional icon, message, and actions.
public struct CNEmptyState<Actions: View>: View {
    @Environment(\.cnTheme) private var theme

    private let title: String
    private let message: String?
    private let systemImage: String?
    private let actions: Actions

    /// Creates an empty state.
    public init(
        _ title: String,
        message: String? = nil,
        systemImage: String? = nil,
        @ViewBuilder actions: () -> Actions
    ) {
        self.title = title
        self.message = message
        self.systemImage = systemImage
        self.actions = actions()
    }

    /// The empty-state body.
    public var body: some View {
        VStack(spacing: theme.space.x4) {
            if let systemImage {
                Image(systemName: systemImage)
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundStyle(theme.colors.mutedForeground.color)
                    .accessibilityHidden(true)
            }

            VStack(spacing: theme.space.x2) {
                Text(title)
                    .font(theme.typography.headline.font)
                    .foregroundStyle(theme.colors.foreground.color)
                    .multilineTextAlignment(.center)

                if let message {
                    Text(message)
                        .font(theme.typography.body.font)
                        .foregroundStyle(theme.colors.mutedForeground.color)
                        .multilineTextAlignment(.center)
                }
            }

            actions
        }
        .padding(theme.space.x6)
        .frame(maxWidth: .infinity, alignment: .center)
        .accessibilityElement(children: .combine)
    }
}

public extension CNEmptyState where Actions == EmptyView {
    /// Creates an empty state without actions.
    init(_ title: String, message: String? = nil, systemImage: String? = nil) {
        self.init(title, message: message, systemImage: systemImage) {
            EmptyView()
        }
    }
}

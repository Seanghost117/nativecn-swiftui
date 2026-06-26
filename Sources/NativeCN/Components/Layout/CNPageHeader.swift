import SwiftUI

/// A page-level header with title, optional subtitle, and trailing actions.
public struct CNPageHeader<Actions: View>: View {
    @Environment(\.cnTheme) private var theme

    private let title: String
    private let subtitle: String?
    private let actions: Actions

    /// Creates a page header.
    public init(_ title: String, subtitle: String? = nil, @ViewBuilder actions: () -> Actions) {
        self.title = title
        self.subtitle = subtitle
        self.actions = actions()
    }

    /// The header body.
    public var body: some View {
        HStack(alignment: .top, spacing: theme.space.x4) {
            VStack(alignment: .leading, spacing: theme.space.x2) {
                Text(title)
                    .font(theme.typography.title2.font)
                    .foregroundStyle(theme.colors.foreground.color)
                    .accessibilityAddTraits(.isHeader)

                if let subtitle {
                    Text(subtitle)
                        .font(theme.typography.body.font)
                        .foregroundStyle(theme.colors.mutedForeground.color)
                }
            }

            Spacer(minLength: theme.space.x3)

            actions
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

public extension CNPageHeader where Actions == EmptyView {
    /// Creates a page header without actions.
    init(_ title: String, subtitle: String? = nil) {
        self.init(title, subtitle: subtitle) {
            EmptyView()
        }
    }
}

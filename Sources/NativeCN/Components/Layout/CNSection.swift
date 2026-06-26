import SwiftUI

/// A token-driven section for grouping related content in app screens.
public struct CNSection<Content: View, Footer: View>: View {
    @Environment(\.cnTheme) private var theme

    private let title: String?
    private let subtitle: String?
    private let content: Content
    private let footer: Footer

    /// Creates a section.
    public init(
        _ title: String? = nil,
        subtitle: String? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder footer: () -> Footer
    ) {
        self.title = title
        self.subtitle = subtitle
        self.content = content()
        self.footer = footer()
    }

    /// The section body.
    public var body: some View {
        VStack(alignment: .leading, spacing: theme.space.x3) {
            if title != nil || subtitle != nil {
                VStack(alignment: .leading, spacing: theme.space.x1) {
                    if let title {
                        Text(title)
                            .font(theme.typography.headline.font)
                            .foregroundStyle(theme.colors.foreground.color)
                            .accessibilityAddTraits(.isHeader)
                    }

                    if let subtitle {
                        Text(subtitle)
                            .font(theme.typography.subheadline.font)
                            .foregroundStyle(theme.colors.mutedForeground.color)
                    }
                }
            }

            VStack(spacing: 0) {
                content
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(theme.colors.card.color)
            .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
            .cnBorder(color: theme.colors.border, cornerRadius: theme.radius.lg)

            footer
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

public extension CNSection where Footer == EmptyView {
    /// Creates a section without footer content.
    init(_ title: String? = nil, subtitle: String? = nil, @ViewBuilder content: () -> Content) {
        self.init(title, subtitle: subtitle, content: content) {
            EmptyView()
        }
    }
}

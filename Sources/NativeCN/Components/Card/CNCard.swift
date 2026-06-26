import SwiftUI

/// A token-driven surface container for grouped content.
public struct CNCard<Content: View>: View {
    @Environment(\.cnTheme) private var theme

    private let padding: CGFloat?
    private let content: Content

    /// Creates a card.
    public init(padding: CGFloat? = nil, @ViewBuilder content: () -> Content) {
        self.padding = padding
        self.content = content()
    }

    /// The card body.
    public var body: some View {
        content
            .padding(padding ?? theme.space.x4)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(theme.colors.cardForeground.color)
            .background(theme.colors.card.color)
            .clipShape(RoundedRectangle(cornerRadius: theme.radius.xl))
            .cnBorder(color: theme.colors.border, cornerRadius: theme.radius.xl)
    }
}

/// A card header section.
public struct CNCardHeader<Content: View>: View {
    @Environment(\.cnTheme) private var theme

    private let content: Content

    /// Creates a card header.
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    /// The header body.
    public var body: some View {
        VStack(alignment: .leading, spacing: theme.space.x1) {
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, theme.space.x3)
    }
}

/// A card title.
public struct CNCardTitle: View {
    @Environment(\.cnTheme) private var theme

    private let title: String

    /// Creates a card title.
    public init(_ title: String) {
        self.title = title
    }

    /// The title body.
    public var body: some View {
        Text(title)
            .font(theme.typography.headline.font)
            .foregroundStyle(theme.colors.cardForeground.color)
            .accessibilityAddTraits(.isHeader)
    }
}

/// A card description.
public struct CNCardDescription: View {
    @Environment(\.cnTheme) private var theme

    private let description: String

    /// Creates a card description.
    public init(_ description: String) {
        self.description = description
    }

    /// The description body.
    public var body: some View {
        Text(description)
            .font(theme.typography.subheadline.font)
            .foregroundStyle(theme.colors.mutedForeground.color)
    }
}

/// A card content section.
public struct CNCardContent<Content: View>: View {
    private let content: Content

    /// Creates card content.
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    /// The content body.
    public var body: some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

/// A card footer section.
public struct CNCardFooter<Content: View>: View {
    @Environment(\.cnTheme) private var theme

    private let content: Content

    /// Creates a card footer.
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    /// The footer body.
    public var body: some View {
        HStack(spacing: theme.space.x2) {
            content
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.top, theme.space.x3)
    }
}

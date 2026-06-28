import SwiftUI

/// Semantic text styles for NativeCN content.
public enum CNTypographyStyle: String, CaseIterable, Sendable, Equatable {
    /// Large page title.
    case title

    /// Section heading.
    case heading

    /// Body copy.
    case body

    /// Muted supporting text.
    case muted

    /// Small caption text.
    case caption
}

/// A token-driven semantic text view.
public struct CNTypography: View {
    @Environment(\.cnTheme) private var theme

    private let text: String
    private let style: CNTypographyStyle

    /// Creates a typography text view.
    public init(_ text: String, style: CNTypographyStyle = .body) {
        self.text = text
        self.style = style
    }

    /// The typography body.
    public var body: some View {
        Text(text)
            .font(style.font(in: theme))
            .foregroundStyle(style.color(in: theme).color)
    }
}

public extension CNTypographyStyle {
    /// Resolves the SwiftUI font for this semantic text style.
    func font(in theme: CNTheme) -> Font {
        switch self {
        case .title:
            return theme.typography.title2.font
        case .heading:
            return theme.typography.headline.font
        case .body:
            return theme.typography.body.font
        case .muted:
            return theme.typography.subheadline.font
        case .caption:
            return theme.typography.caption.font
        }
    }

    /// Resolves the foreground color for this semantic text style.
    func color(in theme: CNTheme) -> CNColorToken {
        switch self {
        case .muted, .caption:
            return theme.colors.mutedForeground
        case .title, .heading, .body:
            return theme.colors.foreground
        }
    }
}


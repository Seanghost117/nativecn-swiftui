import SwiftUI

/// A quiet explanatory note for supporting text.
public struct CNNote<Content: View>: View {
    @Environment(\.cnTheme) private var theme

    private let title: String?
    private let content: Content

    /// Creates a note.
    public init(title: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    /// The note body.
    public var body: some View {
        VStack(alignment: .leading, spacing: theme.space.x2) {
            if let title {
                Text(title)
                    .font(theme.typography.subheadline.font.weight(.semibold))
                    .foregroundStyle(theme.colors.foreground.color)
            }

            content
                .font(theme.typography.subheadline.font)
                .foregroundStyle(theme.colors.mutedForeground.color)
        }
        .padding(theme.space.x4)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(theme.colors.muted.color)
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
        .accessibilityElement(children: .combine)
    }
}

public extension CNNote where Content == Text {
    /// Creates a text note.
    init(_ text: String, title: String? = nil) {
        self.init(title: title) {
            Text(text)
        }
    }
}

import SwiftUI

/// A key-value item for `CNDescriptionList`.
public struct CNDescriptionItem: Identifiable, Sendable, Equatable {
    /// Item identifier.
    public var id: String

    /// Item label.
    public var label: String

    /// Item value.
    public var value: String

    /// Creates a description item.
    public init(id: String, label: String, value: String) {
        self.id = id
        self.label = label
        self.value = value
    }
}

/// A token-driven key-value list for metadata and details.
public struct CNDescriptionList: View {
    @Environment(\.cnTheme) private var theme

    private let items: [CNDescriptionItem]

    /// Creates a description list.
    public init(_ items: [CNDescriptionItem]) {
        self.items = items
    }

    /// The description list body.
    public var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                HStack(alignment: .firstTextBaseline, spacing: theme.space.x4) {
                    Text(item.label)
                        .font(theme.typography.subheadline.font)
                        .foregroundStyle(theme.colors.mutedForeground.color)
                        .frame(maxWidth: 140, alignment: .leading)

                    Text(item.value)
                        .font(theme.typography.subheadline.font.weight(.medium))
                        .foregroundStyle(theme.colors.foreground.color)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal, theme.space.x4)
                .padding(.vertical, theme.space.x3)
                .accessibilityElement(children: .combine)

                if index < items.count - 1 {
                    CNSeparator()
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(theme.colors.card.color)
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
        .cnBorder(color: theme.colors.border, cornerRadius: theme.radius.lg)
    }
}

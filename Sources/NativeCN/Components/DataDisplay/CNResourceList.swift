import SwiftUI

/// A resource item for `CNResourceList`.
public struct CNResourceItem: Identifiable, Sendable, Equatable {
    /// Resource identifier.
    public var id: String

    /// Primary resource title.
    public var title: String

    /// Optional subtitle.
    public var subtitle: String?

    /// Optional metadata text.
    public var metadata: String?

    /// Optional SF Symbol name.
    public var systemImage: String?

    /// Optional status title.
    public var status: String?

    /// Status variant.
    public var statusVariant: CNStatusBadge.Variant

    /// Creates a resource item.
    public init(
        id: String,
        title: String,
        subtitle: String? = nil,
        metadata: String? = nil,
        systemImage: String? = nil,
        status: String? = nil,
        statusVariant: CNStatusBadge.Variant = .neutral
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.metadata = metadata
        self.systemImage = systemImage
        self.status = status
        self.statusVariant = statusVariant
    }
}

/// A token-driven list for app resources and records.
public struct CNResourceList: View {
    @Environment(\.cnTheme) private var theme

    private let items: [CNResourceItem]
    private let onSelect: (CNResourceItem) -> Void

    /// Creates a resource list.
    public init(_ items: [CNResourceItem], onSelect: @escaping (CNResourceItem) -> Void = { _ in }) {
        self.items = items
        self.onSelect = onSelect
    }

    /// The resource list body.
    public var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                Button {
                    onSelect(item)
                } label: {
                    HStack(spacing: theme.space.x3) {
                        if let systemImage = item.systemImage {
                            Image(systemName: systemImage)
                                .font(.body.weight(.semibold))
                                .foregroundStyle(theme.colors.mutedForeground.color)
                                .frame(width: 28, height: 28)
                                .background(theme.colors.muted.color)
                                .clipShape(RoundedRectangle(cornerRadius: theme.radius.md))
                                .accessibilityHidden(true)
                        }

                        VStack(alignment: .leading, spacing: theme.space.x1) {
                            Text(item.title)
                                .font(theme.typography.body.font.weight(.medium))
                                .foregroundStyle(theme.colors.foreground.color)

                            if let subtitle = item.subtitle {
                                Text(subtitle)
                                    .font(theme.typography.subheadline.font)
                                    .foregroundStyle(theme.colors.mutedForeground.color)
                            }
                        }

                        Spacer(minLength: theme.space.x3)

                        VStack(alignment: .trailing, spacing: theme.space.x2) {
                            if let status = item.status {
                                CNStatusBadge(status, variant: item.statusVariant)
                            }

                            if let metadata = item.metadata {
                                Text(metadata)
                                    .font(theme.typography.caption.font)
                                    .foregroundStyle(theme.colors.mutedForeground.color)
                            }
                        }
                    }
                    .padding(.horizontal, theme.space.x4)
                    .padding(.vertical, theme.space.x3)
                    .frame(maxWidth: .infinity, minHeight: 56, alignment: .leading)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
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

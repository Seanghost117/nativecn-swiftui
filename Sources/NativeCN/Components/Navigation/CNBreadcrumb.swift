import SwiftUI

/// A breadcrumb item.
public struct CNBreadcrumbItem: Identifiable, Sendable, Equatable {
    /// Item identifier.
    public var id: String

    /// Item title.
    public var title: String

    /// Optional SF Symbol name.
    public var systemImage: String?

    /// Whether this item represents the current location.
    public var isCurrent: Bool

    /// Creates a breadcrumb item.
    public init(id: String, title: String, systemImage: String? = nil, isCurrent: Bool = false) {
        self.id = id
        self.title = title
        self.systemImage = systemImage
        self.isCurrent = isCurrent
    }
}

/// A compact breadcrumb trail for hierarchical navigation.
public struct CNBreadcrumb: View {
    @Environment(\.cnTheme) private var theme

    private let items: [CNBreadcrumbItem]
    private let onSelect: (CNBreadcrumbItem) -> Void

    /// Creates a breadcrumb trail.
    public init(items: [CNBreadcrumbItem], onSelect: @escaping (CNBreadcrumbItem) -> Void = { _ in }) {
        self.items = items
        self.onSelect = onSelect
    }

    /// The breadcrumb body.
    public var body: some View {
        HStack(spacing: theme.space.x2) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                if index > 0 {
                    Image(systemName: "chevron.right")
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(theme.colors.mutedForeground.color)
                        .accessibilityHidden(true)
                }

                Button {
                    guard !item.isCurrent else { return }
                    onSelect(item)
                } label: {
                    HStack(spacing: theme.space.x1) {
                        if let systemImage = item.systemImage {
                            Image(systemName: systemImage)
                                .accessibilityHidden(true)
                        }

                        Text(item.title)
                    }
                    .font(theme.typography.subheadline.font.weight(item.isCurrent ? .semibold : .regular))
                    .lineLimit(1)
                    .foregroundStyle((item.isCurrent ? theme.colors.foreground : theme.colors.mutedForeground).color)
                }
                .buttonStyle(.plain)
                .disabled(item.isCurrent)
                .accessibilityValue(item.isCurrent ? Text("Current page") : Text(""))
            }
        }
        .accessibilityElement(children: .contain)
    }
}

import SwiftUI

/// A selectable sidebar navigation item.
public struct CNSidebarItem<Value: Hashable & Sendable>: Identifiable, Sendable, Equatable {
    /// Item title.
    public var title: String

    /// Item value.
    public var value: Value

    /// Optional SF Symbol name.
    public var systemImage: String?

    /// Optional compact badge text.
    public var badge: String?

    /// Whether the item is disabled.
    public var isDisabled: Bool

    /// Stable identifier.
    public var id: Value { value }

    /// Creates a sidebar item.
    public init(_ title: String, value: Value, systemImage: String? = nil, badge: String? = nil, isDisabled: Bool = false) {
        self.title = title
        self.value = value
        self.systemImage = systemImage
        self.badge = badge
        self.isDisabled = isDisabled
    }
}

/// A sidebar navigation group.
public struct CNSidebarSection<Value: Hashable & Sendable>: Identifiable, Sendable, Equatable {
    /// Stable group identifier.
    public var id: String

    /// Optional group title.
    public var title: String?

    /// Items in this group.
    public var items: [CNSidebarItem<Value>]

    /// Creates a sidebar section.
    public init(id: String, title: String? = nil, items: [CNSidebarItem<Value>]) {
        self.id = id
        self.title = title
        self.items = items
    }
}

/// A token-driven sidebar for app-shell navigation.
public struct CNSidebar<Value: Hashable & Sendable>: View {
    @Environment(\.cnTheme) private var theme

    private let title: String?
    @Binding private var selection: Value
    private let sections: [CNSidebarSection<Value>]
    private let isDisabled: Bool

    /// Creates a sidebar.
    public init(
        _ title: String? = nil,
        selection: Binding<Value>,
        sections: [CNSidebarSection<Value>],
        isDisabled: Bool = false
    ) {
        self.title = title
        self._selection = selection
        self.sections = sections
        self.isDisabled = isDisabled
    }

    /// The sidebar body.
    public var body: some View {
        VStack(alignment: .leading, spacing: theme.space.x4) {
            if let title {
                Text(title)
                    .font(theme.typography.headline.font)
                    .foregroundStyle(theme.colors.foreground.color)
                    .accessibilityAddTraits(.isHeader)
            }

            VStack(alignment: .leading, spacing: theme.space.x4) {
                ForEach(sections) { section in
                    sidebarSection(section)
                }
            }
        }
        .padding(theme.space.x3)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(theme.colors.card.color)
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
        .cnBorder(color: theme.colors.border, cornerRadius: theme.radius.lg)
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.55 : 1)
        .accessibilityElement(children: .contain)
    }

    private func sidebarSection(_ section: CNSidebarSection<Value>) -> some View {
        VStack(alignment: .leading, spacing: theme.space.x1) {
            if let title = section.title {
                Text(title)
                    .font(theme.typography.caption.font.weight(.semibold))
                    .foregroundStyle(theme.colors.mutedForeground.color)
                    .textCase(.uppercase)
                    .padding(.horizontal, theme.space.x2)
                    .padding(.bottom, theme.space.x1)
            }

            ForEach(section.items) { item in
                sidebarRow(item)
            }
        }
    }

    private func sidebarRow(_ item: CNSidebarItem<Value>) -> some View {
        let isSelected = selection == item.value

        return Button {
            selection = item.value
        } label: {
            HStack(spacing: theme.space.x2) {
                selectedIndicator(isSelected)

                if let systemImage = item.systemImage {
                    Image(systemName: systemImage)
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(foreground(isSelected: isSelected).color)
                        .frame(width: 18)
                        .accessibilityHidden(true)
                }

                Text(item.title)
                    .font(theme.typography.subheadline.font.weight(.medium))
                    .foregroundStyle(foreground(isSelected: isSelected).color)
                    .lineLimit(1)
                    .minimumScaleFactor(0.85)

                Spacer(minLength: theme.space.x2)

                if let badge = item.badge {
                    Text(badge)
                        .font(theme.typography.caption.font.weight(.semibold))
                        .foregroundStyle(badgeForeground(isSelected: isSelected).color)
                        .padding(.horizontal, theme.space.x2)
                        .frame(minHeight: 20)
                        .background(badgeBackground(isSelected: isSelected).color)
                        .clipShape(Capsule())
                }
            }
            .padding(.trailing, theme.space.x2)
            .frame(minHeight: 38)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(background(isSelected: isSelected).color)
            .clipShape(RoundedRectangle(cornerRadius: theme.radius.md))
            .contentShape(RoundedRectangle(cornerRadius: theme.radius.md))
            .opacity(item.isDisabled ? 0.45 : 1)
        }
        .buttonStyle(.plain)
        .disabled(item.isDisabled)
        .accessibilityValue(isSelected ? "Selected" : "Not selected")
        .accessibilityHint(item.isDisabled ? "Disabled" : "Navigates to \(item.title)")
    }

    private func selectedIndicator(_ isSelected: Bool) -> some View {
        Capsule()
            .fill(isSelected ? theme.colors.primary.color : Color.clear)
            .frame(width: 3, height: 22)
            .padding(.leading, theme.space.x1)
    }

    private func foreground(isSelected: Bool) -> CNColorToken {
        isSelected ? theme.colors.foreground : theme.colors.mutedForeground
    }

    private func background(isSelected: Bool) -> CNColorToken {
        isSelected ? theme.colors.muted : CNColorToken(red: 0, green: 0, blue: 0, opacity: 0)
    }

    private func badgeForeground(isSelected: Bool) -> CNColorToken {
        isSelected ? theme.colors.primaryForeground : theme.colors.mutedForeground
    }

    private func badgeBackground(isSelected: Bool) -> CNColorToken {
        isSelected ? theme.colors.primary : theme.colors.muted
    }
}

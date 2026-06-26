import SwiftUI

/// A child item inside a navigation menu group.
public struct CNNavigationMenuItem<Value: Hashable & Sendable>: Identifiable, Sendable, Equatable {
    /// Item title.
    public var title: String

    /// Item value.
    public var value: Value

    /// Optional supporting text.
    public var subtitle: String?

    /// Optional SF Symbol name.
    public var systemImage: String?

    /// Optional compact badge text.
    public var badge: String?

    /// Whether the item is disabled.
    public var isDisabled: Bool

    /// Stable identifier.
    public var id: Value { value }

    /// Creates a navigation menu item.
    public init(
        _ title: String,
        value: Value,
        subtitle: String? = nil,
        systemImage: String? = nil,
        badge: String? = nil,
        isDisabled: Bool = false
    ) {
        self.title = title
        self.value = value
        self.subtitle = subtitle
        self.systemImage = systemImage
        self.badge = badge
        self.isDisabled = isDisabled
    }
}

/// A top-level navigation menu group.
public struct CNNavigationMenuGroup<Value: Hashable & Sendable>: Identifiable, Sendable, Equatable {
    /// Stable group identifier.
    public var id: String

    /// Group title.
    public var title: String

    /// Optional SF Symbol name.
    public var systemImage: String?

    /// Optional direct navigation value. When nil, the group opens child items.
    public var value: Value?

    /// Child items.
    public var items: [CNNavigationMenuItem<Value>]

    /// Whether the group is disabled.
    public var isDisabled: Bool

    /// Creates a navigation menu group.
    public init(
        id: String,
        title: String,
        systemImage: String? = nil,
        value: Value? = nil,
        items: [CNNavigationMenuItem<Value>] = [],
        isDisabled: Bool = false
    ) {
        self.id = id
        self.title = title
        self.systemImage = systemImage
        self.value = value
        self.items = items
        self.isDisabled = isDisabled
    }
}

/// A token-driven top-level navigation menu.
public struct CNNavigationMenu<Value: Hashable & Sendable>: View {
    @Environment(\.cnTheme) private var theme

    @Binding private var selection: Value
    private let groups: [CNNavigationMenuGroup<Value>]
    private let isDisabled: Bool

    /// Creates a navigation menu.
    public init(selection: Binding<Value>, groups: [CNNavigationMenuGroup<Value>], isDisabled: Bool = false) {
        self._selection = selection
        self.groups = groups
        self.isDisabled = isDisabled
    }

    /// The navigation menu body.
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: theme.space.x1) {
                ForEach(groups) { group in
                    if group.items.isEmpty, let value = group.value {
                        directButton(group, value: value)
                    } else {
                        menuButton(group)
                    }
                }
            }
            .padding(theme.space.x1)
        }
        .background(theme.colors.muted.color)
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.55 : 1)
        .accessibilityElement(children: .contain)
    }

    private func directButton(_ group: CNNavigationMenuGroup<Value>, value: Value) -> some View {
        Button {
            selection = value
        } label: {
            triggerLabel(
                title: group.title,
                systemImage: group.systemImage,
                isSelected: selection == value,
                showsDisclosure: false
            )
        }
        .buttonStyle(.plain)
        .disabled(group.isDisabled)
        .opacity(group.isDisabled ? 0.45 : 1)
        .accessibilityValue(selection == value ? "Selected" : "Not selected")
    }

    private func menuButton(_ group: CNNavigationMenuGroup<Value>) -> some View {
        Menu {
            ForEach(group.items) { item in
                Button {
                    selection = item.value
                } label: {
                    if let systemImage = item.systemImage {
                        SwiftUI.Label(itemLabel(for: item), systemImage: systemImage)
                    } else {
                        Text(itemLabel(for: item))
                    }
                }
                .disabled(item.isDisabled)
            }
        } label: {
            triggerLabel(
                title: group.title,
                systemImage: group.systemImage,
                isSelected: isGroupSelected(group),
                showsDisclosure: true
            )
        }
        .disabled(group.isDisabled)
        .opacity(group.isDisabled ? 0.45 : 1)
        .accessibilityValue(isGroupSelected(group) ? "Selected" : "Not selected")
    }

    private func triggerLabel(title: String, systemImage: String?, isSelected: Bool, showsDisclosure: Bool) -> some View {
        HStack(spacing: theme.space.x2) {
            if let systemImage {
                Image(systemName: systemImage)
                    .accessibilityHidden(true)
            }

            Text(title)

            if showsDisclosure {
                Image(systemName: "chevron.down")
                    .font(.caption2.weight(.semibold))
                    .accessibilityHidden(true)
            }
        }
        .font(theme.typography.subheadline.font.weight(.medium))
        .lineLimit(1)
        .minimumScaleFactor(0.85)
        .foregroundStyle((isSelected ? theme.colors.foreground : theme.colors.mutedForeground).color)
        .padding(.horizontal, theme.space.x3)
        .frame(minHeight: 34)
        .background((isSelected ? theme.colors.background : CNColorToken(red: 0, green: 0, blue: 0, opacity: 0)).color)
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.md))
        .contentShape(RoundedRectangle(cornerRadius: theme.radius.md))
    }

    private func isGroupSelected(_ group: CNNavigationMenuGroup<Value>) -> Bool {
        if let value = group.value, selection == value {
            return true
        }

        return group.items.contains { $0.value == selection }
    }

    private func itemLabel(for item: CNNavigationMenuItem<Value>) -> String {
        if let badge = item.badge {
            return "\(item.title) \(badge)"
        }

        return item.title
    }
}

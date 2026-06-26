import SwiftUI

/// A command item inside a NativeCN menubar menu.
public struct CNMenubarItem: Identifiable, Sendable, Equatable {
    /// Item identifier.
    public var id: String

    /// Item title.
    public var title: String

    /// Optional SF Symbol name.
    public var systemImage: String?

    /// Optional shortcut label.
    public var shortcut: String?

    /// Whether the command is destructive.
    public var isDestructive: Bool

    /// Whether the command is disabled.
    public var isDisabled: Bool

    /// Creates a menubar command item.
    public init(
        id: String,
        title: String,
        systemImage: String? = nil,
        shortcut: String? = nil,
        isDestructive: Bool = false,
        isDisabled: Bool = false
    ) {
        self.id = id
        self.title = title
        self.systemImage = systemImage
        self.shortcut = shortcut
        self.isDestructive = isDestructive
        self.isDisabled = isDisabled
    }
}

/// A top-level NativeCN menubar menu.
public struct CNMenubarMenu: Identifiable, Sendable, Equatable {
    /// Stable menu identifier.
    public var id: String

    /// Menu title.
    public var title: String

    /// Optional SF Symbol name.
    public var systemImage: String?

    /// Command items in this menu.
    public var items: [CNMenubarItem]

    /// Whether this menu is disabled.
    public var isDisabled: Bool

    /// Creates a menubar menu.
    public init(id: String, title: String, systemImage: String? = nil, items: [CNMenubarItem], isDisabled: Bool = false) {
        self.id = id
        self.title = title
        self.systemImage = systemImage
        self.items = items
        self.isDisabled = isDisabled
    }
}

/// A token-driven menu bar for compact command clusters.
public struct CNMenubar: View {
    @Environment(\.cnTheme) private var theme

    private let menus: [CNMenubarMenu]
    private let isDisabled: Bool
    private let onSelect: (CNMenubarItem) -> Void

    /// Creates a menubar.
    public init(menus: [CNMenubarMenu], isDisabled: Bool = false, onSelect: @escaping (CNMenubarItem) -> Void) {
        self.menus = menus
        self.isDisabled = isDisabled
        self.onSelect = onSelect
    }

    /// The menubar body.
    public var body: some View {
        HStack(spacing: theme.space.x1) {
            ForEach(menus) { menu in
                Menu {
                    ForEach(menu.items) { item in
                        Button(role: item.isDestructive ? .destructive : nil) {
                            onSelect(item)
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
                    HStack(spacing: theme.space.x2) {
                        if let systemImage = menu.systemImage {
                            Image(systemName: systemImage)
                                .accessibilityHidden(true)
                        }

                        Text(menu.title)

                        Image(systemName: "chevron.down")
                            .font(.caption2.weight(.semibold))
                            .accessibilityHidden(true)
                    }
                    .font(theme.typography.subheadline.font.weight(.medium))
                    .foregroundStyle(theme.colors.foreground.color)
                    .padding(.horizontal, theme.space.x3)
                    .frame(minHeight: 32)
                    .background(theme.colors.background.color)
                    .clipShape(RoundedRectangle(cornerRadius: theme.radius.md))
                    .contentShape(RoundedRectangle(cornerRadius: theme.radius.md))
                }
                .disabled(menu.isDisabled)
                .opacity(menu.isDisabled ? 0.45 : 1)
            }
        }
        .padding(theme.space.x1)
        .background(theme.colors.muted.color)
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
        .cnBorder(color: theme.colors.border, cornerRadius: theme.radius.lg)
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.55 : 1)
        .accessibilityElement(children: .contain)
    }

    private func itemLabel(for item: CNMenubarItem) -> String {
        guard let shortcut = item.shortcut else {
            return item.title
        }

        return "\(item.title) \(shortcut)"
    }
}

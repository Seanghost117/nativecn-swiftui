import SwiftUI

/// A dropdown menu item.
public struct CNDropdownMenuItem: Identifiable, Sendable, Equatable {
    /// Item identifier.
    public var id: String

    /// Item title.
    public var title: String

    /// Optional SF Symbol name.
    public var systemImage: String?

    /// Whether the menu item is destructive.
    public var isDestructive: Bool

    /// Creates a dropdown menu item.
    public init(id: String, title: String, systemImage: String? = nil, isDestructive: Bool = false) {
        self.id = id
        self.title = title
        self.systemImage = systemImage
        self.isDestructive = isDestructive
    }
}

/// A native menu-backed dropdown menu.
public struct CNDropdownMenu<Label: View>: View {
    private let items: [CNDropdownMenuItem]
    private let onSelect: (CNDropdownMenuItem) -> Void
    private let label: Label

    /// Creates a dropdown menu.
    public init(
        items: [CNDropdownMenuItem],
        onSelect: @escaping (CNDropdownMenuItem) -> Void,
        @ViewBuilder label: () -> Label
    ) {
        self.items = items
        self.onSelect = onSelect
        self.label = label()
    }

    /// The dropdown menu body.
    public var body: some View {
        Menu {
            ForEach(items) { item in
                Button(role: item.isDestructive ? .destructive : nil) {
                    onSelect(item)
                } label: {
                    if let systemImage = item.systemImage {
                        SwiftUI.Label(item.title, systemImage: systemImage)
                    } else {
                        Text(item.title)
                    }
                }
            }
        } label: {
            label
        }
    }
}

public extension CNDropdownMenu where Label == CNButton<Text> {
    /// Creates a dropdown menu with a default trigger button.
    init(_ title: String, items: [CNDropdownMenuItem], onSelect: @escaping (CNDropdownMenuItem) -> Void) {
        self.init(items: items, onSelect: onSelect) {
            CNButton(title, variant: .outline) {}
        }
    }
}

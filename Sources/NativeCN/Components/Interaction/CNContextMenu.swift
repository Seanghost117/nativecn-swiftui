import SwiftUI

/// A context menu action.
public struct CNContextMenuItem: Identifiable, Sendable, Equatable {
    /// Item identifier.
    public var id: String

    /// Item title.
    public var title: String

    /// Optional SF Symbol name.
    public var systemImage: String?

    /// Whether the item should use a destructive role.
    public var isDestructive: Bool

    /// Creates a context menu item.
    public init(id: String, title: String, systemImage: String? = nil, isDestructive: Bool = false) {
        self.id = id
        self.title = title
        self.systemImage = systemImage
        self.isDestructive = isDestructive
    }
}

public extension View {
    /// Adds a native context menu using NativeCN item metadata.
    func cnContextMenu(
        items: [CNContextMenuItem],
        onSelect: @escaping (CNContextMenuItem) -> Void
    ) -> some View {
        contextMenu {
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
        }
    }
}

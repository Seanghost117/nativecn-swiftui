import SwiftUI

/// A horizontally paged carousel for custom item content.
public struct CNCarousel<Item: Identifiable, Content: View>: View where Item.ID: Hashable {
    @Environment(\.cnTheme) private var theme

    @State private var internalSelection: Item.ID?

    private let items: [Item]
    private let selection: Binding<Item.ID?>?
    private let itemWidth: CGFloat
    private let spacing: CGFloat
    private let showsControls: Bool
    private let showsIndicators: Bool
    private let content: (Item) -> Content

    /// Creates a carousel.
    public init(
        items: [Item],
        selection: Binding<Item.ID?>? = nil,
        itemWidth: CGFloat = 260,
        spacing: CGFloat = 12,
        showsControls: Bool = true,
        showsIndicators: Bool = true,
        @ViewBuilder content: @escaping (Item) -> Content
    ) {
        self.items = items
        self.selection = selection
        self.itemWidth = itemWidth
        self.spacing = spacing
        self.showsControls = showsControls
        self.showsIndicators = showsIndicators
        self.content = content
    }

    /// The carousel body.
    public var body: some View {
        ScrollViewReader { proxy in
            VStack(alignment: .leading, spacing: theme.space.x3) {
                if showsControls {
                    controls(proxy: proxy)
                }

                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(spacing: spacing) {
                        ForEach(items) { item in
                            content(item)
                                .frame(width: itemWidth)
                                .contentShape(RoundedRectangle(cornerRadius: theme.radius.lg))
                                .id(item.id)
                                .onTapGesture {
                                    setSelection(item.id, proxy: proxy)
                                }
                        }
                    }
                    .padding(.horizontal, theme.space.x1)
                    .padding(.vertical, theme.space.x1)
                }

                if showsIndicators {
                    indicators(proxy: proxy)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .onAppear {
                if selectedID == nil {
                    setSelection(items.first?.id, proxy: proxy)
                }
            }
        }
    }

    /// Returns the selected item index, if present.
    public static func index(of id: Item.ID?, in items: [Item]) -> Int? {
        guard let id else {
            return nil
        }

        return items.firstIndex { $0.id == id }
    }

    /// Returns the previous item id.
    public static func previousID(before id: Item.ID?, in items: [Item]) -> Item.ID? {
        guard !items.isEmpty else {
            return nil
        }

        guard let index = index(of: id, in: items) else {
            return items.first?.id
        }

        return items[max(index - 1, 0)].id
    }

    /// Returns the next item id.
    public static func nextID(after id: Item.ID?, in items: [Item]) -> Item.ID? {
        guard !items.isEmpty else {
            return nil
        }

        guard let index = index(of: id, in: items) else {
            return items.first?.id
        }

        return items[min(index + 1, items.count - 1)].id
    }

    private var selectedID: Item.ID? {
        selection?.wrappedValue ?? internalSelection
    }

    private var selectedIndex: Int? {
        Self.index(of: selectedID, in: items)
    }

    private func controls(proxy: ScrollViewProxy) -> some View {
        HStack(spacing: theme.space.x2) {
            Text(progressText)
                .font(theme.typography.subheadline.font.weight(.medium))
                .foregroundStyle(theme.colors.mutedForeground.color)

            Spacer(minLength: theme.space.x3)

            controlButton(systemImage: "chevron.left", label: "Previous item", isDisabled: selectedIndex == nil || selectedIndex == 0) {
                setSelection(Self.previousID(before: selectedID, in: items), proxy: proxy)
            }

            controlButton(systemImage: "chevron.right", label: "Next item", isDisabled: selectedIndex == nil || selectedIndex == items.count - 1) {
                setSelection(Self.nextID(after: selectedID, in: items), proxy: proxy)
            }
        }
    }

    private func indicators(proxy: ScrollViewProxy) -> some View {
        HStack(spacing: theme.space.x1) {
            ForEach(items) { item in
                Button {
                    setSelection(item.id, proxy: proxy)
                } label: {
                    Circle()
                        .fill((item.id == selectedID ? theme.colors.primary : theme.colors.border).color)
                        .frame(width: 7, height: 7)
                        .padding(theme.space.x1)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Show item")
                .accessibilityValue(item.id == selectedID ? "Selected" : "Not selected")
            }
        }
    }

    private func controlButton(systemImage: String, label: String, isDisabled: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.caption.weight(.semibold))
                .foregroundStyle(theme.colors.mutedForeground.color)
                .frame(width: 32, height: 30)
                .background(theme.colors.card.color)
                .clipShape(RoundedRectangle(cornerRadius: theme.radius.md))
                .cnBorder(color: theme.colors.border, cornerRadius: theme.radius.md)
        }
        .buttonStyle(.plain)
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.45 : 1)
        .accessibilityLabel(label)
    }

    private var progressText: String {
        guard let selectedIndex else {
            return items.isEmpty ? "0 of 0" : "1 of \(items.count)"
        }

        return "\(selectedIndex + 1) of \(items.count)"
    }

    private func setSelection(_ id: Item.ID?, proxy: ScrollViewProxy) {
        if let selection {
            selection.wrappedValue = id
        } else {
            internalSelection = id
        }

        if let id {
            withAnimation(.easeInOut(duration: 0.2)) {
                proxy.scrollTo(id, anchor: .center)
            }
        }
    }
}

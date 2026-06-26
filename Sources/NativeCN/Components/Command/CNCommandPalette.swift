import SwiftUI

/// A selectable command palette item.
public struct CNCommandItem: Identifiable, Sendable, Equatable {
    /// Item identifier.
    public var id: String

    /// Primary command title.
    public var title: String

    /// Optional supporting text.
    public var subtitle: String?

    /// Optional group title.
    public var group: String?

    /// Optional SF Symbol name.
    public var systemImage: String?

    /// Extra search terms.
    public var keywords: [String]

    /// Whether the command is disabled.
    public var isDisabled: Bool

    /// Creates a command item.
    public init(
        id: String,
        title: String,
        subtitle: String? = nil,
        group: String? = nil,
        systemImage: String? = nil,
        keywords: [String] = [],
        isDisabled: Bool = false
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.group = group
        self.systemImage = systemImage
        self.keywords = keywords
        self.isDisabled = isDisabled
    }

    /// Returns whether the command matches a search query.
    public func matches(_ query: String) -> Bool {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedQuery.isEmpty else {
            return true
        }

        let searchableText = ([title, subtitle, group] + keywords)
            .compactMap { $0 }
            .joined(separator: " ")

        return searchableText.localizedCaseInsensitiveContains(trimmedQuery)
    }
}

/// A searchable command palette surface.
public struct CNCommandPalette: View {
    @Environment(\.cnTheme) private var theme
    @FocusState private var isSearchFocused: Bool

    @State private var query = ""

    private let title: String
    private let placeholder: String
    private let emptyTitle: String
    private let items: [CNCommandItem]
    private let onSelect: (CNCommandItem) -> Void

    /// Creates a command palette.
    public init(
        title: String = "Command Palette",
        placeholder: String = "Search commands",
        emptyTitle: String = "No commands found",
        items: [CNCommandItem],
        onSelect: @escaping (CNCommandItem) -> Void
    ) {
        self.title = title
        self.placeholder = placeholder
        self.emptyTitle = emptyTitle
        self.items = items
        self.onSelect = onSelect
    }

    /// The command palette body.
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header

            searchField

            CNSeparator()

            if groupedItems.isEmpty {
                emptyState
            } else {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: theme.space.x3) {
                        ForEach(groupedItems) { group in
                            commandGroup(group)
                        }
                    }
                    .padding(theme.space.x3)
                }
            }
        }
        .frame(maxWidth: .infinity, minHeight: 420, alignment: .topLeading)
        .background(theme.colors.background.color)
        .onAppear {
            isSearchFocused = true
        }
    }

    private var header: some View {
        HStack(spacing: theme.space.x3) {
            Text(title)
                .font(theme.typography.title3.font)
                .foregroundStyle(theme.colors.foreground.color)
                .accessibilityAddTraits(.isHeader)

            Spacer(minLength: theme.space.x3)

            CNKeyboardShortcut("Command", "K")
        }
        .padding(.horizontal, theme.space.x4)
        .padding(.top, theme.space.x4)
        .padding(.bottom, theme.space.x3)
    }

    private var searchField: some View {
        HStack(spacing: theme.space.x2) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(theme.colors.mutedForeground.color)
                .accessibilityHidden(true)

            TextField(placeholder, text: $query)
                .textFieldStyle(.plain)
                .font(theme.typography.body.font)
                .focused($isSearchFocused)

            if !query.isEmpty {
                Button {
                    query = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(theme.colors.mutedForeground.color)
                        .accessibilityLabel("Clear search")
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, theme.space.x3)
        .frame(minHeight: 44)
        .background(theme.colors.card.color)
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.md))
        .cnBorder(color: theme.colors.border, cornerRadius: theme.radius.md)
        .padding(.horizontal, theme.space.x4)
        .padding(.bottom, theme.space.x4)
    }

    private var emptyState: some View {
        VStack(alignment: .center, spacing: theme.space.x2) {
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundStyle(theme.colors.mutedForeground.color)
                .accessibilityHidden(true)

            Text(emptyTitle)
                .font(theme.typography.subheadline.font.weight(.medium))
                .foregroundStyle(theme.colors.mutedForeground.color)
        }
        .frame(maxWidth: .infinity, minHeight: 220)
        .accessibilityElement(children: .combine)
    }

    private func commandGroup(_ group: CNCommandGroup) -> some View {
        VStack(alignment: .leading, spacing: theme.space.x1) {
            if let title = group.title {
                Text(title)
                    .font(theme.typography.caption.font.weight(.semibold))
                    .foregroundStyle(theme.colors.mutedForeground.color)
                    .textCase(.uppercase)
                    .padding(.horizontal, theme.space.x2)
            }

            VStack(spacing: theme.space.x1) {
                ForEach(group.items) { item in
                    commandRow(item)
                }
            }
        }
    }

    private func commandRow(_ item: CNCommandItem) -> some View {
        Button {
            onSelect(item)
        } label: {
            HStack(spacing: theme.space.x3) {
                if let systemImage = item.systemImage {
                    Image(systemName: systemImage)
                        .font(.body.weight(.medium))
                        .foregroundStyle(theme.colors.mutedForeground.color)
                        .frame(width: 22)
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

                Image(systemName: "return")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(theme.colors.mutedForeground.color)
                    .accessibilityHidden(true)
            }
            .padding(.horizontal, theme.space.x3)
            .padding(.vertical, theme.space.x2)
            .frame(maxWidth: .infinity, minHeight: 48, alignment: .leading)
            .background(theme.colors.card.color)
            .clipShape(RoundedRectangle(cornerRadius: theme.radius.md))
            .contentShape(RoundedRectangle(cornerRadius: theme.radius.md))
            .opacity(item.isDisabled ? 0.5 : 1)
        }
        .buttonStyle(.plain)
        .disabled(item.isDisabled)
        .accessibilityHint(item.isDisabled ? "Disabled" : "Runs command")
    }

    private var groupedItems: [CNCommandGroup] {
        let matches = items.filter { $0.matches(query) }
        var groups: [CNCommandGroup] = []

        for item in matches {
            let groupID = item.group ?? "Commands"

            if let index = groups.firstIndex(where: { $0.id == groupID }) {
                groups[index].items.append(item)
            } else {
                groups.append(CNCommandGroup(id: groupID, title: item.group, items: [item]))
            }
        }

        return groups
    }
}

public extension View {
    /// Presents a native sheet containing a command palette.
    func cnCommandPalette(
        isPresented: Binding<Bool>,
        title: String = "Command Palette",
        placeholder: String = "Search commands",
        emptyTitle: String = "No commands found",
        items: [CNCommandItem],
        onSelect: @escaping (CNCommandItem) -> Void
    ) -> some View {
        sheet(isPresented: isPresented) {
            CNCommandPalette(
                title: title,
                placeholder: placeholder,
                emptyTitle: emptyTitle,
                items: items,
                onSelect: onSelect
            )
            .presentationDetents([.medium, .large])
        }
    }
}

private struct CNCommandGroup: Identifiable {
    var id: String
    var title: String?
    var items: [CNCommandItem]
}

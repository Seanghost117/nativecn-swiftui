import SwiftUI

/// A searchable option for `CNCombobox`.
public struct CNComboboxOption<Value: Hashable & Sendable>: Identifiable, Sendable, Equatable {
    /// Option title.
    public var title: String

    /// Option value.
    public var value: Value

    /// Optional supporting text.
    public var subtitle: String?

    /// Optional SF Symbol name.
    public var systemImage: String?

    /// Extra search terms.
    public var keywords: [String]

    /// Stable identifier.
    public var id: Value { value }

    /// Creates a combobox option.
    public init(
        _ title: String,
        value: Value,
        subtitle: String? = nil,
        systemImage: String? = nil,
        keywords: [String] = []
    ) {
        self.title = title
        self.value = value
        self.subtitle = subtitle
        self.systemImage = systemImage
        self.keywords = keywords
    }

    /// Returns whether the option matches a search query.
    public func matches(_ query: String) -> Bool {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedQuery.isEmpty else {
            return true
        }

        let searchableText = ([title, subtitle] + keywords)
            .compactMap { $0 }
            .joined(separator: " ")

        return searchableText.localizedCaseInsensitiveContains(trimmedQuery)
    }
}

/// A searchable select control backed by native popover presentation.
public struct CNCombobox<Value: Hashable & Sendable>: View {
    @Environment(\.cnTheme) private var theme
    @FocusState private var isSearchFocused: Bool

    @State private var isPresented = false
    @State private var query = ""

    private let placeholder: String
    @Binding private var selection: Value?
    private let options: [CNComboboxOption<Value>]
    private let searchPlaceholder: String
    private let emptyTitle: String
    private let isDisabled: Bool

    /// Creates a combobox control.
    public init(
        _ placeholder: String,
        selection: Binding<Value?>,
        options: [CNComboboxOption<Value>],
        searchPlaceholder: String = "Search",
        emptyTitle: String = "No results found",
        isDisabled: Bool = false
    ) {
        self.placeholder = placeholder
        self._selection = selection
        self.options = options
        self.searchPlaceholder = searchPlaceholder
        self.emptyTitle = emptyTitle
        self.isDisabled = isDisabled
    }

    /// The combobox body.
    public var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            HStack(spacing: theme.space.x3) {
                Text(selectedOption?.title ?? placeholder)
                    .font(theme.typography.body.font)
                    .foregroundStyle(selectedOption == nil ? theme.colors.mutedForeground.color : theme.colors.foreground.color)
                    .lineLimit(1)

                Spacer(minLength: theme.space.x3)

                Image(systemName: "chevron.up.chevron.down")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(theme.colors.mutedForeground.color)
                    .accessibilityHidden(true)
            }
            .padding(.horizontal, theme.space.x4)
            .frame(minHeight: CNControlSize.md.metrics(in: theme).height)
            .background(theme.colors.background.color)
            .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
            .cnBorder(color: theme.colors.input, cornerRadius: theme.radius.lg)
            .contentShape(RoundedRectangle(cornerRadius: theme.radius.lg))
        }
        .buttonStyle(.plain)
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.55 : 1)
        .popover(isPresented: $isPresented, arrowEdge: .bottom) {
            panel
        }
        .accessibilityLabel(placeholder)
        .accessibilityValue(selectedOption?.title ?? "No selection")
    }

    private var panel: some View {
        VStack(alignment: .leading, spacing: 0) {
            searchField

            CNSeparator()

            if filteredOptions.isEmpty {
                emptyState
            } else {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: theme.space.x1) {
                        ForEach(filteredOptions) { option in
                            optionRow(option)
                        }
                    }
                    .padding(theme.space.x2)
                }
                .frame(maxHeight: 260)
            }
        }
        .frame(width: 320, alignment: .topLeading)
        .background(theme.colors.popover.color)
        .foregroundStyle(theme.colors.popoverForeground.color)
        .onAppear {
            isSearchFocused = true
        }
    }

    private var searchField: some View {
        HStack(spacing: theme.space.x2) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(theme.colors.mutedForeground.color)
                .accessibilityHidden(true)

            TextField(searchPlaceholder, text: $query)
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
        .padding(theme.space.x2)
    }

    private var emptyState: some View {
        VStack(spacing: theme.space.x2) {
            Image(systemName: "magnifyingglass")
                .font(.title3)
                .foregroundStyle(theme.colors.mutedForeground.color)
                .accessibilityHidden(true)

            Text(emptyTitle)
                .font(theme.typography.subheadline.font.weight(.medium))
                .foregroundStyle(theme.colors.mutedForeground.color)
        }
        .frame(maxWidth: .infinity, minHeight: 140)
        .accessibilityElement(children: .combine)
    }

    private func optionRow(_ option: CNComboboxOption<Value>) -> some View {
        Button {
            selection = option.value
            query = ""
            isPresented = false
        } label: {
            HStack(spacing: theme.space.x3) {
                if let systemImage = option.systemImage {
                    Image(systemName: systemImage)
                        .font(.body.weight(.medium))
                        .foregroundStyle(theme.colors.mutedForeground.color)
                        .frame(width: 20)
                        .accessibilityHidden(true)
                }

                VStack(alignment: .leading, spacing: theme.space.x1) {
                    Text(option.title)
                        .font(theme.typography.body.font.weight(.medium))
                        .foregroundStyle(theme.colors.foreground.color)

                    if let subtitle = option.subtitle {
                        Text(subtitle)
                            .font(theme.typography.caption.font)
                            .foregroundStyle(theme.colors.mutedForeground.color)
                    }
                }

                Spacer(minLength: theme.space.x3)

                if selection == option.value {
                    Image(systemName: "checkmark")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(theme.colors.primary.color)
                        .accessibilityHidden(true)
                }
            }
            .padding(.horizontal, theme.space.x3)
            .padding(.vertical, theme.space.x2)
            .frame(maxWidth: .infinity, minHeight: 44, alignment: .leading)
            .background(selection == option.value ? theme.colors.accent.color : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: theme.radius.md))
            .contentShape(RoundedRectangle(cornerRadius: theme.radius.md))
        }
        .buttonStyle(.plain)
        .accessibilityHint(selection == option.value ? "Selected" : "Selects option")
    }

    private var filteredOptions: [CNComboboxOption<Value>] {
        options.filter { $0.matches(query) }
    }

    private var selectedOption: CNComboboxOption<Value>? {
        guard let selection else { return nil }
        return options.first { $0.value == selection }
    }
}

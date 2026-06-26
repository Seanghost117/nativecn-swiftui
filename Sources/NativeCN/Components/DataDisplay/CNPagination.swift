import SwiftUI

/// An item rendered by `CNPagination`.
public enum CNPaginationItem: Identifiable, Sendable, Equatable {
    /// Previous-page control.
    case previous

    /// Next-page control.
    case next

    /// Numbered page control.
    case page(Int)

    /// Non-interactive ellipsis.
    case ellipsis(String)

    /// Stable identifier.
    public var id: String {
        switch self {
        case .previous:
            return "previous"
        case .next:
            return "next"
        case let .page(page):
            return "page-\(page)"
        case let .ellipsis(id):
            return "ellipsis-\(id)"
        }
    }
}

/// A compact pagination control for paged lists and tables.
public struct CNPagination: View {
    @Environment(\.cnTheme) private var theme

    @Binding private var currentPage: Int
    private let totalPages: Int
    private let siblingCount: Int
    private let boundaryCount: Int
    private let isDisabled: Bool

    /// Creates a pagination control.
    public init(
        currentPage: Binding<Int>,
        totalPages: Int,
        siblingCount: Int = 1,
        boundaryCount: Int = 1,
        isDisabled: Bool = false
    ) {
        self._currentPage = currentPage
        self.totalPages = max(totalPages, 1)
        self.siblingCount = max(siblingCount, 0)
        self.boundaryCount = max(boundaryCount, 0)
        self.isDisabled = isDisabled
    }

    /// The pagination body.
    public var body: some View {
        HStack(spacing: theme.space.x1) {
            ForEach(items) { item in
                paginationItem(item)
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

    /// Builds pagination items for the supplied state.
    public static func items(currentPage: Int, totalPages: Int, siblingCount: Int = 1, boundaryCount: Int = 1) -> [CNPaginationItem] {
        let totalPages = max(totalPages, 1)
        let currentPage = min(max(currentPage, 1), totalPages)
        let siblingCount = max(siblingCount, 0)
        let boundaryCount = max(boundaryCount, 0)
        let visibleNumberCount = (boundaryCount * 2) + (siblingCount * 2) + 3

        if totalPages <= visibleNumberCount {
            return [.previous] + (1...totalPages).map(CNPaginationItem.page) + [.next]
        }

        let leftBoundary = boundaryCount > 0 ? Array(1...boundaryCount) : []
        let rightBoundaryStart = max(totalPages - boundaryCount + 1, 1)
        let rightBoundary = boundaryCount > 0 ? Array(rightBoundaryStart...totalPages) : []
        let siblingStart = max(currentPage - siblingCount, boundaryCount + 1)
        let siblingEnd = min(currentPage + siblingCount, totalPages - boundaryCount)

        var pages: [CNPaginationItem] = [.previous]
        pages.append(contentsOf: leftBoundary.map(CNPaginationItem.page))

        if siblingStart > boundaryCount + 1 {
            pages.append(.ellipsis("leading"))
        }

        if siblingStart <= siblingEnd {
            pages.append(contentsOf: (siblingStart...siblingEnd).map(CNPaginationItem.page))
        }

        if siblingEnd < totalPages - boundaryCount {
            pages.append(.ellipsis("trailing"))
        }

        pages.append(contentsOf: rightBoundary.map(CNPaginationItem.page))
        pages.append(.next)

        return pages
    }

    private var items: [CNPaginationItem] {
        Self.items(currentPage: currentPage, totalPages: totalPages, siblingCount: siblingCount, boundaryCount: boundaryCount)
    }

    @ViewBuilder
    private func paginationItem(_ item: CNPaginationItem) -> some View {
        switch item {
        case .previous:
            controlButton(systemImage: "chevron.left", label: "Previous page", isDisabled: clampedCurrentPage <= 1) {
                currentPage = max(clampedCurrentPage - 1, 1)
            }
        case .next:
            controlButton(systemImage: "chevron.right", label: "Next page", isDisabled: clampedCurrentPage >= totalPages) {
                currentPage = min(clampedCurrentPage + 1, totalPages)
            }
        case let .page(page):
            pageButton(page)
        case .ellipsis:
            Text("...")
                .font(theme.typography.subheadline.font.weight(.medium))
                .foregroundStyle(theme.colors.mutedForeground.color)
                .frame(width: 34, height: 32)
                .accessibilityLabel("More pages")
        }
    }

    private func pageButton(_ page: Int) -> some View {
        Button {
            currentPage = page
        } label: {
            Text("\(page)")
                .font(theme.typography.subheadline.font.weight(.medium))
                .foregroundStyle(foreground(isSelected: page == clampedCurrentPage).color)
                .frame(width: 34, height: 32)
                .background(background(isSelected: page == clampedCurrentPage).color)
                .clipShape(RoundedRectangle(cornerRadius: theme.radius.md))
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Page \(page)")
        .accessibilityValue(page == clampedCurrentPage ? "Current page" : "")
    }

    private func controlButton(systemImage: String, label: String, isDisabled: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.caption.weight(.semibold))
                .foregroundStyle(theme.colors.mutedForeground.color)
                .frame(width: 34, height: 32)
                .clipShape(RoundedRectangle(cornerRadius: theme.radius.md))
        }
        .buttonStyle(.plain)
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.45 : 1)
        .accessibilityLabel(label)
    }

    private var clampedCurrentPage: Int {
        min(max(currentPage, 1), totalPages)
    }

    private func foreground(isSelected: Bool) -> CNColorToken {
        isSelected ? theme.colors.foreground : theme.colors.mutedForeground
    }

    private func background(isSelected: Bool) -> CNColorToken {
        isSelected ? theme.colors.background : CNColorToken(red: 0, green: 0, blue: 0, opacity: 0)
    }
}

import SwiftUI
import XCTest

@testable import NativeCN

final class DataDisplayTests: XCTestCase {
    func testDescriptionAndTimelineItemsExposeStableIdentifiers() {
        let description = CNDescriptionItem(id: "plan", label: "Plan", value: "Pro")
        let event = CNTimelineItem(id: "created", title: "Created", detail: "Workspace initialized.", timestamp: "9:12 AM", systemImage: "plus")
        let resource = CNResourceItem(
            id: "ios",
            title: "iOS App",
            subtitle: "Production",
            metadata: "Updated today",
            systemImage: "iphone",
            status: "Healthy",
            statusVariant: .success
        )
        let column = CNDataTableColumn(id: "usage", title: "Usage", minWidth: 100, alignment: .trailing)
        let row = CNDataTableRow(id: "ios", values: ["name": "iOS App", "usage": "82%"])
        let pageItem = CNPaginationItem.page(3)

        XCTAssertEqual(description.id, "plan")
        XCTAssertEqual(description.label, "Plan")
        XCTAssertEqual(description.value, "Pro")
        XCTAssertEqual(event.id, "created")
        XCTAssertEqual(event.title, "Created")
        XCTAssertEqual(event.systemImage, "plus")
        XCTAssertEqual(resource.id, "ios")
        XCTAssertEqual(resource.status, "Healthy")
        XCTAssertEqual(resource.statusVariant, .success)
        XCTAssertEqual(column.id, "usage")
        XCTAssertEqual(column.alignment, .trailing)
        XCTAssertEqual(row.id, "ios")
        XCTAssertEqual(row.values["usage"], "82%")
        XCTAssertEqual(pageItem.id, "page-3")
    }

    func testStatusBadgeVariantsCoverSemanticStates() {
        XCTAssertEqual(CNStatusBadge.Variant.allCases, [.neutral, .success, .warning, .destructive])
    }

    func testPaginationItemsUseWindowedPagesAndEllipses() {
        XCTAssertEqual(
            CNPagination.items(currentPage: 5, totalPages: 10),
            [.previous, .page(1), .ellipsis("leading"), .page(4), .page(5), .page(6), .ellipsis("trailing"), .page(10), .next]
        )

        XCTAssertEqual(
            CNPagination.items(currentPage: 1, totalPages: 4),
            [.previous, .page(1), .page(2), .page(3), .page(4), .next]
        )
    }

    func testDataDisplayComponentsCompileTogetherInDashboard() {
        _ = DataDisplaySmokeView()
    }
}

private struct DataDisplaySmokeView: View {
    @State private var page = 1

    var body: some View {
        CNThemeProvider {
            VStack {
                CNStat("Revenue", value: "$12.4k", detail: "from last month", trend: "+12%") {
                    CNStatusBadge("Healthy", variant: .success)
                }

                CNDescriptionList([
                    CNDescriptionItem(id: "plan", label: "Plan", value: "Pro"),
                    CNDescriptionItem(id: "owner", label: "Owner", value: "Taylor Lee"),
                ])

                CNTimeline([
                    CNTimelineItem(id: "created", title: "Project created", timestamp: "9:12 AM"),
                    CNTimelineItem(id: "updated", title: "Tokens updated", detail: "Theme values synced."),
                ])

                CNResourceList([
                    CNResourceItem(id: "ios", title: "iOS App", subtitle: "Production", metadata: "Updated today", systemImage: "iphone", status: "Healthy", statusVariant: .success),
                    CNResourceItem(id: "api", title: "API", subtitle: "Staging", metadata: "3 alerts", systemImage: "server.rack", status: "Warning", statusVariant: .warning),
                ])

                CNDataTable(
                    columns: [
                        CNDataTableColumn(id: "name", title: "Name"),
                        CNDataTableColumn(id: "usage", title: "Usage", alignment: .trailing),
                    ],
                    rows: [
                        CNDataTableRow(id: "ios", values: ["name": "iOS App", "usage": "82%"]),
                        CNDataTableRow(id: "api", values: ["name": "API", "usage": "64%"]),
                    ]
                )

                CNPagination(currentPage: $page, totalPages: 8)
            }
        }
    }
}

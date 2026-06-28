import NativeCN
import Charts
import SwiftUI

struct CatalogDataDisplayPage: View {
    @Environment(\.cnTheme) private var theme

    @State private var selectedResource = "None"
    @State private var selectedTableRow = "None"
    @State private var tablePage = 2

    var body: some View {
        CatalogPage(
            title: "Data Display",
            subtitle: "Stats, metadata, and activity patterns for product screens."
        ) {
            CNPageHeader("Workspace", subtitle: "A dashboard-style summary built from data display components.") {
                CNButton("Export", variant: .outline, size: .sm) {}
            }

            VStack(spacing: 12) {
                HStack(spacing: 12) {
                    CNStat("Revenue", value: "$12.4k", detail: "from last month", trend: "+12%") {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                            .foregroundStyle(.secondary)
                    }

                    CNStat("Active users", value: "1,248", detail: "across workspaces", trend: "+8%") {
                        Image(systemName: "person.2")
                            .foregroundStyle(.secondary)
                    }
                }

                HStack(spacing: 12) {
                    CNStat("Errors", value: "3", detail: "needs review", trend: "-2") {
                        CNStatusBadge("Warning", variant: .warning)
                    }

                    CNStat("Deploys", value: "18", detail: "this week", trend: "+5") {
                        Image(systemName: "arrow.up.forward.app")
                            .foregroundStyle(.secondary)
                    }
                }
            }

            CNSection("Charts", subtitle: "Tokenized containers and legends around Apple Charts.") {
                VStack(spacing: 16) {
                    CNChartContainer(title: "Revenue", subtitle: "Trailing 6 months", height: 220) {
                        Chart(chartPoints) { point in
                            BarMark(
                                x: .value("Month", point.month),
                                y: .value("Revenue", point.revenue)
                            )
                            .foregroundStyle(by: .value("Series", point.series))
                            .cornerRadius(4)
                        }
                        .chartForegroundStyleScale([
                            "Web": CNChartPalette.color(at: 0, in: theme).color,
                            "iOS": CNChartPalette.color(at: 1, in: theme).color,
                        ])
                    } footer: {
                        CNChartLegend([
                            CNChartSeries(id: "web", title: "Web", colorIndex: 0, detail: "$42.8k"),
                            CNChartSeries(id: "ios", title: "iOS", colorIndex: 1, detail: "$36.2k"),
                        ])
                    }

                    HStack(spacing: 12) {
                        CNChartContainer(
                            title: "Loading",
                            state: .loading,
                            height: 160
                        ) {
                            EmptyView()
                        }

                        CNChartContainer(
                            title: "No Data",
                            state: .empty(title: "No chart data", message: "Data will appear when usage starts."),
                            height: 160
                        ) {
                            EmptyView()
                        }
                    }
                }
                .padding(16)
            }

            CNSection("Resources", subtitle: "Record lists with status and metadata.") {
                CNResourceList([
                    CNResourceItem(id: "ios", title: "iOS App", subtitle: "Production workspace", metadata: "Updated today", systemImage: "iphone", status: "Healthy", statusVariant: .success),
                    CNResourceItem(id: "api", title: "API", subtitle: "Staging cluster", metadata: "3 alerts", systemImage: "server.rack", status: "Warning", statusVariant: .warning),
                    CNResourceItem(id: "billing", title: "Billing", subtitle: "Stripe integration", metadata: "Paused", systemImage: "creditcard", status: "Needs review", statusVariant: .destructive),
                ]) { item in
                    selectedResource = item.title
                }
                .padding(16)
            } footer: {
                Text("Selected resource: \(selectedResource)")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            CNSection("Details", subtitle: "Description lists for metadata and records.") {
                CNDescriptionList([
                    CNDescriptionItem(id: "plan", label: "Plan", value: "Pro"),
                    CNDescriptionItem(id: "renewal", label: "Renewal", value: "July 18, 2026"),
                    CNDescriptionItem(id: "owner", label: "Owner", value: "Taylor Lee"),
                    CNDescriptionItem(id: "region", label: "Region", value: "US East"),
                ])
                .padding(16)
            }

            CNSection("Data Table", subtitle: "A lightweight comparison table for compact datasets.") {
                CNDataTable(
                    columns: [
                        CNDataTableColumn(id: "name", title: "Name", minWidth: 160),
                        CNDataTableColumn(id: "status", title: "Status", minWidth: 120),
                        CNDataTableColumn(id: "owner", title: "Owner", minWidth: 140),
                        CNDataTableColumn(id: "usage", title: "Usage", minWidth: 100, alignment: .trailing),
                    ],
                    rows: [
                        CNDataTableRow(id: "ios", values: ["name": "iOS App", "status": "Healthy", "owner": "Taylor", "usage": "82%"]),
                        CNDataTableRow(id: "api", values: ["name": "API", "status": "Warning", "owner": "Morgan", "usage": "64%"]),
                        CNDataTableRow(id: "billing", values: ["name": "Billing", "status": "Needs review", "owner": "Riley", "usage": "41%"]),
                    ]
                ) { row in
                    selectedTableRow = row.values["name"] ?? row.id
                }
                .padding(16)
            } footer: {
                HStack {
                    Text("Selected row: \(selectedTableRow)")
                        .font(.footnote)
                        .foregroundStyle(.secondary)

                    Spacer()

                    CNPagination(currentPage: $tablePage, totalPages: 8)
                }
            }

            CNSection("Table", subtitle: "Static reference tables with the same visual system.") {
                CNTable(
                    columns: [
                        CNTableColumn(id: "component", title: "Component", minWidth: 160),
                        CNTableColumn(id: "area", title: "Area", minWidth: 130),
                        CNTableColumn(id: "status", title: "Status", minWidth: 120),
                    ],
                    rows: [
                        CNTableRow(id: "button-group", values: ["component": "Button Group", "area": "Actions", "status": "Stable"]),
                        CNTableRow(id: "input-group", values: ["component": "Input Group", "area": "Forms", "status": "Stable"]),
                        CNTableRow(id: "typography", values: ["component": "Typography", "area": "Content", "status": "Stable"]),
                    ]
                )
                .padding(16)
            }

            CNSection("Activity", subtitle: "A timeline for recent events.") {
                CNTimeline([
                    CNTimelineItem(id: "created", title: "Project created", detail: "NativeCN workspace initialized.", timestamp: "9:12 AM", systemImage: "plus"),
                    CNTimelineItem(id: "tokens", title: "Tokens updated", detail: "Radius and color tokens synced.", timestamp: "10:04 AM", systemImage: "paintpalette"),
                    CNTimelineItem(id: "registry", title: "Registry generated", detail: "Component metadata was refreshed.", timestamp: "11:40 AM", systemImage: "shippingbox"),
                ])
                .padding(16)
            }
        }
    }

    private var chartPoints: [CatalogChartPoint] {
        [
            CatalogChartPoint(id: "jan-web", month: "Jan", series: "Web", revenue: 6.4),
            CatalogChartPoint(id: "jan-ios", month: "Jan", series: "iOS", revenue: 5.1),
            CatalogChartPoint(id: "feb-web", month: "Feb", series: "Web", revenue: 7.2),
            CatalogChartPoint(id: "feb-ios", month: "Feb", series: "iOS", revenue: 5.8),
            CatalogChartPoint(id: "mar-web", month: "Mar", series: "Web", revenue: 6.9),
            CatalogChartPoint(id: "mar-ios", month: "Mar", series: "iOS", revenue: 6.3),
            CatalogChartPoint(id: "apr-web", month: "Apr", series: "Web", revenue: 8.1),
            CatalogChartPoint(id: "apr-ios", month: "Apr", series: "iOS", revenue: 6.7),
            CatalogChartPoint(id: "may-web", month: "May", series: "Web", revenue: 7.9),
            CatalogChartPoint(id: "may-ios", month: "May", series: "iOS", revenue: 5.9),
            CatalogChartPoint(id: "jun-web", month: "Jun", series: "Web", revenue: 6.3),
            CatalogChartPoint(id: "jun-ios", month: "Jun", series: "iOS", revenue: 6.4),
        ]
    }
}

private struct CatalogChartPoint: Identifiable {
    var id: String
    var month: String
    var series: String
    var revenue: Double
}

import SwiftUI

struct CNDataDisplay_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            CNDataDisplayPreviewContent()
        }
        .previewLayout(.sizeThatFits)
    }
}

private struct CNDataDisplayPreviewContent: View {
    @State private var page = 2

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
                CNStat("Revenue", value: "$12.4k", detail: "from last month", trend: "+12%") {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .foregroundStyle(.secondary)
                }

                CNDescriptionList([
                    CNDescriptionItem(id: "plan", label: "Plan", value: "Pro"),
                    CNDescriptionItem(id: "renewal", label: "Renewal", value: "July 18, 2026"),
                    CNDescriptionItem(id: "owner", label: "Owner", value: "Taylor Lee"),
                ])

                CNTimeline([
                    CNTimelineItem(id: "created", title: "Project created", detail: "NativeCN workspace initialized.", timestamp: "9:12 AM", systemImage: "plus"),
                    CNTimelineItem(id: "updated", title: "Tokens updated", detail: "Radius and color tokens synced.", timestamp: "10:04 AM", systemImage: "paintpalette"),
                ])

                CNResourceList([
                    CNResourceItem(id: "ios", title: "iOS App", subtitle: "Production workspace", metadata: "Updated today", systemImage: "iphone", status: "Healthy", statusVariant: .success),
                    CNResourceItem(id: "api", title: "API", subtitle: "Staging cluster", metadata: "3 alerts", systemImage: "server.rack", status: "Warning", statusVariant: .warning),
                ])

                CNDataTable(
                    columns: [
                        CNDataTableColumn(id: "name", title: "Name", minWidth: 160),
                        CNDataTableColumn(id: "status", title: "Status", minWidth: 120),
                        CNDataTableColumn(id: "usage", title: "Usage", minWidth: 100, alignment: .trailing),
                    ],
                    rows: [
                        CNDataTableRow(id: "ios", values: ["name": "iOS App", "status": "Healthy", "usage": "82%"]),
                        CNDataTableRow(id: "api", values: ["name": "API", "status": "Warning", "usage": "64%"]),
                    ]
                )

                CNPagination(currentPage: $page, totalPages: 8)
            }
            .padding()
    }
}

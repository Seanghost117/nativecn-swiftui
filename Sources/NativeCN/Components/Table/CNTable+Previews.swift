import SwiftUI

struct CNTable_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            CNTable(
                columns: [
                    CNTableColumn(id: "name", title: "Name"),
                    CNTableColumn(id: "status", title: "Status"),
                ],
                rows: [
                    CNTableRow(id: "ios", values: ["name": "iOS App", "status": "Healthy"]),
                    CNTableRow(id: "api", values: ["name": "API", "status": "Warning"]),
                ]
            )
            .padding()
        }
    }
}


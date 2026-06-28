import SwiftUI

struct CNChart_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            VStack(spacing: 16) {
                CNChartContainer(title: "Revenue", subtitle: "Tokenized chart surface") {
                    CNChartLoadingState()
                } footer: {
                    CNChartLegend([
                        CNChartSeries(id: "web", title: "Web", colorIndex: 0),
                        CNChartSeries(id: "ios", title: "iOS", colorIndex: 1),
                    ])
                }

                CNChartContainer(
                    title: "Empty",
                    state: .empty(title: "No chart data", message: "Data will appear when the first event arrives.")
                ) {
                    EmptyView()
                }
            }
            .padding()
        }
    }
}


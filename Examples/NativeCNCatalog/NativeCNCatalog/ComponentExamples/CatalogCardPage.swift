import NativeCN
import SwiftUI

struct CatalogCardPage: View {
    var body: some View {
        CatalogPage(
            title: "Card",
            subtitle: "Composable surfaces for settings, dashboards, and grouped content."
        ) {
            CNCard {
                CNCardHeader {
                    CNCardTitle("Settings Card")
                    CNCardDescription("Header, content, and footer compose without a monolithic initializer.")
                }

                CNCardContent {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Notifications")
                            Spacer()
                            CNBadge("Enabled", variant: .secondary)
                        }

                        CNSeparator()

                        Text("Use cards for surfaces that need clear grouping and tokenized borders.")
                    }
                }

                CNCardFooter {
                    CNButton("Cancel", variant: .outline) {}
                    CNButton("Save") {}
                }
            }

            CNCard(padding: 12) {
                CNCardHeader {
                    CNCardTitle("Compact Card")
                    CNCardDescription("Cards accept padding overrides for denser layouts.")
                }
            }
        }
    }
}

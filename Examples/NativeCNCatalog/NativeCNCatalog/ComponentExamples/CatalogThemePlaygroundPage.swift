import NativeCN
import SwiftUI

struct CatalogThemePlaygroundPage: View {
    @Binding var useDarkTheme: Bool
    @Environment(\.cnTheme) private var theme

    var body: some View {
        CatalogPage(
            title: "Theme Playground",
            subtitle: "Switch the active theme and inspect how components respond through the SwiftUI environment."
        ) {
            CNCard {
                CNCardHeader {
                    CNCardTitle("Appearance")
                    CNCardDescription("The catalog wraps screens in CNThemeProvider.")
                }

                CNCardContent {
                    Toggle("Use dark theme", isOn: $useDarkTheme)
                }
            }

            CNCard {
                CNCardHeader {
                    CNCardTitle("Live Preview")
                    CNCardDescription(useDarkTheme ? "nativeCNDark" : "nativeCNLight")
                }

                CNCardContent {
                    HStack {
                        CNButton("Primary") {}
                        CNButton("Outline", variant: .outline) {}
                        CNBadge("Tokenized", variant: .secondary)
                    }
                }
            }
        }
    }
}

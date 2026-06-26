import SwiftUI

struct CNContent_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            VStack(alignment: .leading, spacing: 20) {
                CNCallout("Heads up", message: "Use callouts for contextual guidance.", variant: .info) {
                    CNButton("Review", variant: .outline, size: .sm) {}
                }

                CNNote("Copy mode keeps source ownership inside your app.", title: "Registry note")

                CNCodeBlock(
                    """
                    swift build
                    swift test
                    """,
                    language: "bash",
                    title: "Terminal"
                )

                HStack {
                    Text("Use")
                    CNInlineCode("CNThemeProvider")
                    Text("near the app root.")
                }

                CNKeyboardShortcut("Command", "K")
            }
            .padding()
        }
        .previewLayout(.sizeThatFits)
    }
}

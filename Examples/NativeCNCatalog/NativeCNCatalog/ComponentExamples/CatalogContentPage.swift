import NativeCN
import SwiftUI

struct CatalogContentPage: View {
    var body: some View {
        CatalogPage(
            title: "Content",
            subtitle: "Explanatory surfaces for guidance, notes, and developer snippets."
        ) {
            CNSection("Callouts", subtitle: "Contextual guidance with variants and actions.") {
                VStack(alignment: .leading, spacing: 12) {
                    CNCallout("Heads up", message: "Use callouts to explain decisions without interrupting the user.", variant: .info) {
                        CNButton("Review", variant: .outline, size: .sm) {}
                    }

                    CNCallout("Deployment ready", message: "All required checks passed.", variant: .success)

                    CNCallout("Needs attention", message: "Two records require a manual review before launch.", variant: .warning)
                }
                .padding(16)
            }

            CNSection("Notes", subtitle: "Quiet supporting content.") {
                VStack(alignment: .leading, spacing: 12) {
                    CNNote("Copy mode keeps source ownership inside your app.", title: "Registry note")

                    CNNote(title: "Design note") {
                        HStack(spacing: 4) {
                            Text("Mount")
                            CNInlineCode("CNThemeProvider")
                            Text("near the app root.")
                        }
                    }
                }
                .padding(16)
            }

            CNSection("Code Blocks", subtitle: "Commands and snippets for developer surfaces.") {
                VStack(alignment: .leading, spacing: 12) {
                    CNCodeBlock(
                        """
                        swift build
                        swift test
                        swift run NativeCNCatalog
                        """,
                        language: "bash",
                        title: "Terminal"
                    )

                    HStack(spacing: 8) {
                        Text("Open command palette")
                            .font(.subheadline)
                        CNKeyboardShortcut("Command", "K")
                    }
                }
                .padding(16)
            }

            CNSection("Typography", subtitle: "Semantic text styles backed by theme tokens.") {
                VStack(alignment: .leading, spacing: 10) {
                    CNTypography("NativeCN", style: .title)
                    CNTypography("Composable SwiftUI components", style: .heading)
                    CNTypography("Use semantic text styles for product hierarchy.", style: .body)
                    CNTypography("Muted copy supports metadata and helper text.", style: .muted)
                    CNTypography("Caption", style: .caption)
                }
                .padding(16)
            }
        }
    }
}

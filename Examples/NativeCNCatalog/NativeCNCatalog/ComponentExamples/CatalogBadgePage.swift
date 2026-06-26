import NativeCN
import SwiftUI

struct CatalogBadgePage: View {
    var body: some View {
        CatalogPage(
            title: "Badge",
            subtitle: "Compact metadata labels that support text and custom SwiftUI content."
        ) {
            CNCard {
                CNCardHeader {
                    CNCardTitle("Variants")
                    CNCardDescription("Primary, secondary, destructive, and outline badges.")
                }

                CNCardContent {
                    FlowLayout(spacing: 10) {
                        ForEach(CNBadge<Text>.Variant.allCases, id: \.self) { variant in
                            CNBadge(variant.rawValue.capitalized, variant: variant)
                        }

                        CNBadge(variant: .outline) {
                            Label("Synced", systemImage: "checkmark.circle")
                        }
                    }
                }
            }
        }
    }
}

private struct FlowLayout<Content: View>: View {
    let spacing: CGFloat
    let content: Content

    init(spacing: CGFloat, @ViewBuilder content: () -> Content) {
        self.spacing = spacing
        self.content = content()
    }

    var body: some View {
        HStack(spacing: spacing) {
            content
        }
    }
}

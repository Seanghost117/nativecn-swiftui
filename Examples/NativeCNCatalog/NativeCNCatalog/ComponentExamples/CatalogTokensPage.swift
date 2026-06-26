import NativeCN
import SwiftUI

struct CatalogTokensPage: View {
    @Environment(\.cnTheme) private var theme

    var body: some View {
        CatalogPage(
            title: "Tokens",
            subtitle: "Semantic color, radius, spacing, typography, shadow, and motion values used by every component."
        ) {
            CNCard {
                CNCardHeader {
                    CNCardTitle("Colors")
                    CNCardDescription("Components use semantic tokens, not one-off colors.")
                }

                CNCardContent {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 130), spacing: 12)], spacing: 12) {
                        swatch("Background", theme.colors.background)
                        swatch("Foreground", theme.colors.foreground)
                        swatch("Primary", theme.colors.primary)
                        swatch("Secondary", theme.colors.secondary)
                        swatch("Muted", theme.colors.muted)
                        swatch("Destructive", theme.colors.destructive)
                        swatch("Border", theme.colors.border)
                        swatch("Ring", theme.colors.ring)
                    }
                }
            }

            CNCard {
                CNCardHeader {
                    CNCardTitle("Spacing & Radius")
                    CNCardDescription("Shared scales make layouts consistent.")
                }

                CNCardContent {
                    VStack(alignment: .leading, spacing: theme.space.x3) {
                        Text("space.x4 = \(Int(theme.space.x4))")
                        Text("radius.lg = \(Int(theme.radius.lg))")
                        Text("motion.normal = \(theme.motion.normal, specifier: "%.2f")s")
                    }
                    .font(theme.typography.body.font)
                }
            }
        }
    }

    private func swatch(_ name: String, _ token: CNColorToken) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            RoundedRectangle(cornerRadius: theme.radius.md)
                .fill(token.color)
                .frame(height: 44)
                .cnBorder(cornerRadius: theme.radius.md)

            Text(name)
                .font(theme.typography.caption.font)
        }
    }
}

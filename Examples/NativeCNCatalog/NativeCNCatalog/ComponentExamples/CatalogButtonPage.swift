import NativeCN
import SwiftUI

struct CatalogButtonPage: View {
    var body: some View {
        CatalogPage(
            title: "Button",
            subtitle: "Actions with token-driven variants, sizes, loading, disabled, and icon-only states."
        ) {
            CNCard {
                CNCardHeader {
                    CNCardTitle("Variants")
                    CNCardDescription("Semantic button styles mapped through CNTheme.")
                }

                CNCardContent {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(CNButton<Text>.Variant.allCases, id: \.self) { variant in
                            CNButton(variant.rawValue.capitalized, variant: variant) {}
                        }
                    }
                }
            }

            CNCard {
                CNCardHeader {
                    CNCardTitle("Sizes")
                    CNCardDescription("Shared control metrics from CNControlSize.")
                }

                CNCardContent {
                    HStack {
                        CNButton("Small", size: .sm) {}
                        CNButton("Medium", size: .md) {}
                        CNButton("Large", size: .lg) {}
                        CNButton(variant: .outline, size: .icon) {} label: {
                            Image(systemName: "gearshape")
                        }
                        .accessibilityLabel("Settings")
                    }
                }
            }

            CNPreviewMatrix("States") { state in
                CNButton(
                    state.name,
                    variant: state.controlState.isInvalid ? .destructive : .primary,
                    isLoading: state.controlState.isLoading,
                    isDisabled: !state.controlState.isEnabled
                ) {}
            }
        }
    }
}

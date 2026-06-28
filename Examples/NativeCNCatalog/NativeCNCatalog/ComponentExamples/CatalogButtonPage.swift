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

            CNCard {
                CNCardHeader {
                    CNCardTitle("Button Group")
                    CNCardDescription("Related actions arranged as a compact cluster.")
                }

                CNCardContent {
                    VStack(alignment: .leading, spacing: 12) {
                        CNButtonGroup {
                            CNButton("Preview", variant: .outline, size: .sm) {}
                            CNButton("Share", variant: .outline, size: .sm) {}
                            CNButton("Publish", size: .sm) {}
                        }

                        CNButtonGroup(orientation: .vertical) {
                            CNButton("Duplicate", variant: .ghost, size: .sm) {}
                            CNButton("Archive", variant: .ghost, size: .sm) {}
                        }
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

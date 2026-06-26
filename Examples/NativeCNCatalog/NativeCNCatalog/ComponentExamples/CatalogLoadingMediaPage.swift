import NativeCN
import SwiftUI

struct CatalogLoadingMediaPage: View {
    @State private var progress = 0.68

    var body: some View {
        CatalogPage(
            title: "Loading & Media",
            subtitle: "Avatar, skeleton, progress, and spinner components for loading and media states."
        ) {
            CNCard {
                CNCardHeader {
                    CNCardTitle("Avatar")
                    CNCardDescription("Image, initials, placeholder, and graceful remote failure fallback.")
                }

                CNCardContent {
                    HStack(spacing: 16) {
                        CNAvatar(fallback: "JD", size: .sm, accessibilityLabel: "Jordan Doe")
                        CNAvatar(fallback: "AL", size: .md, accessibilityLabel: "Avery Lee")
                        CNAvatar(fallback: "Native", size: .lg)
                        CNAvatar(size: .xl)
                        CNAvatar(url: URL(string: "https://example.invalid/avatar.png"), fallback: "ER", size: .lg)
                    }
                }
            }

            CNCard {
                CNCardHeader {
                    CNCardTitle("Skeleton")
                    CNCardDescription("Composable loading placeholders with Reduce Motion-aware shimmer.")
                }

                CNCardContent {
                    VStack(alignment: .leading, spacing: 14) {
                        CNSkeleton(width: 180, height: 18)
                        CNSkeleton(width: 260, height: 18)
                        HStack {
                            CNSkeleton(shape: .circle, size: 48)
                            VStack(alignment: .leading, spacing: 8) {
                                CNSkeleton(width: 160, height: 16)
                                CNSkeleton(width: 220, height: 16)
                            }
                        }
                    }
                }
            }

            CNCard {
                CNCardHeader {
                    CNCardTitle("Progress")
                    CNCardDescription("Determinate values clamp to the supported 0...1 range.")
                }

                CNCardContent {
                    VStack(alignment: .leading, spacing: 12) {
                        CNProgress(value: progress, label: "Upload progress")
                        Slider(value: $progress, in: -0.25...1.25)
                    }
                }
            }

            CNCard {
                CNCardHeader {
                    CNCardTitle("Spinner")
                    CNCardDescription("Native circular progress with theme tint.")
                }

                CNCardContent {
                    HStack(spacing: 18) {
                        CNSpinner(size: 16)
                        CNSpinner(size: 24)
                        CNSpinner(size: 36, label: "Loading preview")
                    }
                }
            }

            CatalogLoadingScreenExample()
        }
    }
}

struct CatalogLoadingScreenExample: View {
    var body: some View {
        CNCard {
            CNCardHeader {
                CNCardTitle("Loading Screen")
                CNCardDescription("A placeholder profile screen built from Phase 5 components.")
            }

            CNCardContent {
                VStack(alignment: .leading, spacing: 18) {
                    HStack(spacing: 14) {
                        CNSkeleton(shape: .circle, size: 56)
                        VStack(alignment: .leading, spacing: 8) {
                            CNSkeleton(width: 160, height: 18)
                            CNSkeleton(width: 220, height: 16)
                        }
                    }

                    CNSeparator()

                    VStack(alignment: .leading, spacing: 10) {
                        CNSkeleton(width: 280, height: 16)
                        CNSkeleton(width: 240, height: 16)
                        CNSkeleton(width: 300, height: 16)
                    }

                    HStack {
                        CNSpinner(size: 18, label: "Loading profile")
                        Text("Loading profile")
                            .font(.callout)
                    }

                    CNProgress(value: 0.42, label: "Profile loading progress")
                }
            }
        }
    }
}

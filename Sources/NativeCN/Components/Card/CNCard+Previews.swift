import SwiftUI

struct CNCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CNThemeProvider(.nativeCNLight) {
                cardPreviewContent
            }
            .previewDisplayName("Cards Light")

            CNThemeProvider(.nativeCNDark) {
                cardPreviewContent
            }
            .previewDisplayName("Cards Dark")
            .preferredColorScheme(.dark)
        }
    }

    private static var cardPreviewContent: some View {
        ScrollView {
            VStack(spacing: 16) {
                CNCard {
                    CNCardHeader {
                        CNCardTitle("Settings")
                        CNCardDescription("Manage app preferences.")
                    }
                    CNCardContent {
                        Text("Cards compose naturally with arbitrary SwiftUI content.")
                    }
                    CNCardFooter {
                        CNButton("Save") {}
                    }
                }

                CNCard {
                    CNCardHeader {
                        CNCardTitle("Billing")
                        CNCardDescription("Review your current plan.")
                    }
                    CNCardContent {
                        HStack {
                            Text("Pro")
                            Spacer()
                            CNBadge("Active", variant: .secondary)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

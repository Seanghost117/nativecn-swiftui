import SwiftUI

struct CNCarousel_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            CNCarousel(items: CNCarouselPreviewItem.samples, itemWidth: 240) { item in
                CNCard {
                    CNCardHeader {
                        Image(systemName: item.systemImage)
                            .font(.title2)
                            .foregroundStyle(.secondary)
                        CNCardTitle(item.title)
                        CNCardDescription(item.subtitle)
                    }
                }
            }
            .padding()
        }
        .previewLayout(.sizeThatFits)
    }
}

private struct CNCarouselPreviewItem: Identifiable {
    var id: String
    var title: String
    var subtitle: String
    var systemImage: String

    static let samples = [
        Self(id: "tokens", title: "Tokens", subtitle: "Semantic design values.", systemImage: "paintpalette"),
        Self(id: "components", title: "Components", subtitle: "Copy-owned SwiftUI views.", systemImage: "square.grid.2x2"),
        Self(id: "registry", title: "Registry", subtitle: "Source dependency metadata.", systemImage: "shippingbox"),
    ]
}

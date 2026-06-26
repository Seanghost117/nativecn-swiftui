import SwiftUI

struct CNLayout_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            CNLayoutPreviewContent()
        }
        .previewLayout(.sizeThatFits)
    }
}

private struct CNLayoutPreviewContent: View {
    @State private var carouselSelection: String? = "tokens"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                CNPageHeader("Layout", subtitle: "Screen structure primitives.") {
                    CNButton("New", size: .sm) {}
                }

                CNSection("Account", subtitle: "Grouped rows") {
                    CNListRow("Profile", subtitle: "Name, avatar, and handle", systemImage: "person.crop.circle") {
                    }

                    CNSeparator()

                    CNListRow("Notifications", subtitle: "Email and push preferences") {
                        Image(systemName: "bell")
                    } trailing: {
                        CNBadge("On", variant: .secondary)
                    }
                }

                CNCarousel(items: CNLayoutCarouselItem.samples, selection: $carouselSelection, itemWidth: 240) { item in
                    CNCard {
                        CNCardHeader {
                            CNCardTitle(item.title)
                            CNCardDescription(item.subtitle)
                        }
                    }
                }

                CNAspectRatio(16.0 / 9.0) {
                    ZStack {
                        Rectangle()
                            .fill(.quaternary)

                        Label("16:9 preview", systemImage: "photo")
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(width: 320)

                CNScrollArea(maxHeight: 140) {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(1...6, id: \.self) { index in
                            Text("Activity item \(index)")
                                .font(.subheadline)
                        }
                    }
                    .padding()
                }
                .frame(width: 320)
                .cnBorder(cornerRadius: 12)

                CNResizablePanels(initialFraction: 0.4) {
                    Text("Sidebar")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.quaternary.opacity(0.3))
                } secondary: {
                    Text("Detail")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: 320, height: 160)
                .cnBorder(cornerRadius: 12)

                CNEmptyState("No projects", message: "Create a project to get started.", systemImage: "tray") {
                    CNButton("Create project", size: .sm) {}
                }
            }
            .padding()
        }
    }
}

private struct CNLayoutCarouselItem: Identifiable {
    var id: String
    var title: String
    var subtitle: String

    static let samples = [
        Self(id: "tokens", title: "Tokens", subtitle: "Semantic design values."),
        Self(id: "components", title: "Components", subtitle: "Copy-owned SwiftUI views."),
        Self(id: "registry", title: "Registry", subtitle: "Source dependency metadata."),
    ]
}

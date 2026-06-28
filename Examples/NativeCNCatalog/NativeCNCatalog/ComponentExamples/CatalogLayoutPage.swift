import NativeCN
import SwiftUI

struct CatalogLayoutPage: View {
    @State private var selectedRow = "None"
    @State private var selectedCarouselItem: String? = "tokens"

    var body: some View {
        CatalogPage(
            title: "Layout",
            subtitle: "Reusable screen structure for app pages, sections, rows, and empty states."
        ) {
            CNPageHeader("Projects", subtitle: "A page header with compact trailing actions.") {
                CNButton("New", size: .sm) {}
            }

            CNSection("Items", subtitle: "Flexible rows for static settings and command surfaces.") {
                VStack(spacing: 10) {
                    CNItem("Billing", subtitle: "Invoices and payment methods", systemImage: "creditcard")
                    CNItem("Access", subtitle: "Members, roles, and invitations") {
                        Image(systemName: "person.2")
                    } trailing: {
                        CNStatusBadge("Team", variant: .success)
                    }
                }
                .padding(16)
            }

            CNSection("Account", subtitle: "Settings-style grouped rows.") {
                CNListRow("Profile", subtitle: "Name, avatar, and handle", systemImage: "person.crop.circle") {
                    selectedRow = "Profile"
                }

                CNSeparator()

                CNListRow("Notifications", subtitle: "Email and push preferences") {
                    Image(systemName: "bell")
                        .foregroundStyle(.secondary)
                } trailing: {
                    CNBadge("On", variant: .secondary)
                }

                CNSeparator()

                CNListRow("Security", subtitle: "Devices and sessions") {
                    Image(systemName: "lock.shield")
                        .foregroundStyle(.secondary)
                } trailing: {
                    Image(systemName: "chevron.right")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)
                        .accessibilityHidden(true)
                }
            } footer: {
                Text("Last selected row: \(selectedRow)")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            CNSection("Empty States", subtitle: "Centered states with a clear next action.") {
                CNEmptyState("No projects", message: "Create a project to see dashboards, tasks, and timelines here.", systemImage: "tray") {
                    CNButton("Create project", size: .sm) {}
                }
            }

            CNSection("Aspect Ratio", subtitle: "Stable media and preview frames.") {
                CNAspectRatio(16.0 / 9.0) {
                    ZStack {
                        LinearGradient(
                            colors: [.blue.opacity(0.18), .green.opacity(0.16), .purple.opacity(0.16)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )

                        VStack(spacing: 10) {
                            Image(systemName: "photo.on.rectangle.angled")
                                .font(.title)
                                .foregroundStyle(.secondary)

                            Text("Product preview")
                                .font(.headline)

                            Text("16:9 frame stays consistent as the page resizes.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .multilineTextAlignment(.center)
                        .padding(20)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(16)
            }

            CNSection("Scroll Area", subtitle: "Constrained native scrolling for long content regions.") {
                CNScrollArea(maxHeight: 180) {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(activityItems) { item in
                            HStack(alignment: .top, spacing: 10) {
                                Image(systemName: item.systemImage)
                                    .font(.subheadline.weight(.medium))
                                    .foregroundStyle(.secondary)
                                    .frame(width: 18)
                                    .padding(.top, 2)

                                VStack(alignment: .leading, spacing: 3) {
                                    Text(item.title)
                                        .font(.subheadline.weight(.medium))
                                    Text(item.detail)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }

                                Spacer(minLength: 8)

                                CNBadge(item.badge, variant: .secondary)
                            }
                        }
                    }
                    .padding(14)
                }
                .cnBorder(cornerRadius: 12)
                .padding(16)
            }

            CNSection("Resizable Panels", subtitle: "Drag the divider to resize inspector-style regions.") {
                CNResizablePanels(initialFraction: 0.34, minFraction: 0.24, maxFraction: 0.64) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Files")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.secondary)

                        ForEach(resizableFiles) { file in
                            HStack(spacing: 8) {
                                Image(systemName: file.systemImage)
                                    .foregroundStyle(.secondary)
                                    .frame(width: 16)
                                Text(file.title)
                                    .font(.subheadline)
                                    .lineLimit(1)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .padding(14)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .background(.quaternary.opacity(0.35))
                } secondary: {
                    VStack(alignment: .leading, spacing: 10) {
                        CNBadge("Preview", variant: .secondary)

                        Text("Component detail")
                            .font(.headline)

                        Text("Resizable panels help keep navigation, content, and inspectors on one canvas while preserving native SwiftUI layout.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
                .frame(height: 220)
                .cnBorder(cornerRadius: 12)
                .padding(16)
            }

            CNSection("Direction", subtitle: "Mirror layout direction for localized surfaces.") {
                VStack(spacing: 12) {
                    CNDirectionProvider(.ltr) {
                        CNItem("Left to right", subtitle: "Leading content starts on the left", systemImage: "arrow.right")
                    }

                    CNDirectionProvider(.rtl) {
                        CNItem("Right to left", subtitle: "Leading content follows the layout direction", systemImage: "arrow.left")
                    }
                }
                .padding(16)
            }

            CNSection("Carousel", subtitle: "Horizontally paged content with controls and indicators.") {
                CNCarousel(items: carouselItems, selection: $selectedCarouselItem, itemWidth: 250) { item in
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
                .padding(16)
            } footer: {
                Text("Selected carousel item: \(selectedCarouselItem ?? "None")")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private var carouselItems: [CatalogCarouselItem] {
        [
            CatalogCarouselItem(id: "tokens", title: "Tokens", subtitle: "Semantic color, spacing, and type values.", systemImage: "paintpalette"),
            CatalogCarouselItem(id: "components", title: "Components", subtitle: "SwiftUI views designed for copy ownership.", systemImage: "square.grid.2x2"),
            CatalogCarouselItem(id: "registry", title: "Registry", subtitle: "Dependency metadata for source adoption.", systemImage: "shippingbox"),
            CatalogCarouselItem(id: "catalog", title: "Catalog", subtitle: "Interactive previews for every slice.", systemImage: "macwindow"),
        ]
    }

    private var activityItems: [CatalogActivityItem] {
        [
            CatalogActivityItem(id: "design", title: "Design tokens updated", detail: "Spacing and radius changes landed in the catalog.", systemImage: "paintpalette", badge: "Now"),
            CatalogActivityItem(id: "registry", title: "Registry item added", detail: "New metadata was generated for source ownership.", systemImage: "shippingbox", badge: "5m"),
            CatalogActivityItem(id: "docs", title: "Docs refreshed", detail: "Layout examples now cover media, feeds, and paging.", systemImage: "doc.text", badge: "12m"),
            CatalogActivityItem(id: "qa", title: "Visual QA pass", detail: "Dense sections were checked at narrow and wide widths.", systemImage: "checkmark.seal", badge: "22m"),
            CatalogActivityItem(id: "build", title: "Build completed", detail: "SwiftPM compiled the package and catalog app.", systemImage: "hammer", badge: "31m"),
            CatalogActivityItem(id: "release", title: "Release notes drafted", detail: "Component slices were grouped by workflow area.", systemImage: "square.and.arrow.up", badge: "42m"),
        ]
    }

    private var resizableFiles: [CatalogResizableFile] {
        [
            CatalogResizableFile(id: "tokens", title: "Tokens.swift", systemImage: "curlybraces"),
            CatalogResizableFile(id: "layout", title: "Layout.md", systemImage: "doc.text"),
            CatalogResizableFile(id: "registry", title: "registry.json", systemImage: "shippingbox"),
            CatalogResizableFile(id: "catalog", title: "CatalogLayoutPage.swift", systemImage: "macwindow"),
        ]
    }
}

private struct CatalogCarouselItem: Identifiable {
    var id: String
    var title: String
    var subtitle: String
    var systemImage: String
}

private struct CatalogActivityItem: Identifiable {
    var id: String
    var title: String
    var detail: String
    var systemImage: String
    var badge: String
}

private struct CatalogResizableFile: Identifiable {
    var id: String
    var title: String
    var systemImage: String
}

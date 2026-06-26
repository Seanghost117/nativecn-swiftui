import SwiftUI
import XCTest

@testable import NativeCN

final class LayoutComponentTests: XCTestCase {
    func testCarouselNavigationHelpersReturnBoundedIdentifiers() {
        let items = [
            CarouselTestItem(id: "one"),
            CarouselTestItem(id: "two"),
            CarouselTestItem(id: "three"),
        ]

        XCTAssertEqual(CNCarousel<CarouselTestItem, EmptyView>.index(of: "two", in: items), 1)
        XCTAssertEqual(CNCarousel<CarouselTestItem, EmptyView>.previousID(before: "one", in: items), "one")
        XCTAssertEqual(CNCarousel<CarouselTestItem, EmptyView>.previousID(before: "three", in: items), "two")
        XCTAssertEqual(CNCarousel<CarouselTestItem, EmptyView>.nextID(after: "one", in: items), "two")
        XCTAssertEqual(CNCarousel<CarouselTestItem, EmptyView>.nextID(after: "three", in: items), "three")
    }

    func testAspectRatioNormalizesInvalidValues() {
        XCTAssertEqual(CNAspectRatio<EmptyView>.normalizedRatio(16.0 / 9.0), 16.0 / 9.0)
        XCTAssertEqual(CNAspectRatio<EmptyView>.normalizedRatio(0), 1)
        XCTAssertEqual(CNAspectRatio<EmptyView>.normalizedRatio(-1), 1)
        XCTAssertEqual(CNAspectRatio<EmptyView>.normalizedRatio(.infinity), 1)
    }

    func testScrollAreaNormalizesInvalidLengths() {
        XCTAssertEqual(CNScrollArea<EmptyView>.normalizedLength(240), 240)
        XCTAssertNil(CNScrollArea<EmptyView>.normalizedLength(nil))
        XCTAssertNil(CNScrollArea<EmptyView>.normalizedLength(0))
        XCTAssertNil(CNScrollArea<EmptyView>.normalizedLength(-1))
        XCTAssertNil(CNScrollArea<EmptyView>.normalizedLength(.infinity))
    }

    func testResizablePanelsNormalizeFractionsAndBounds() {
        XCTAssertEqual(CNResizablePanels<EmptyView, EmptyView>.normalizedFraction(0.5), 0.5)
        XCTAssertEqual(CNResizablePanels<EmptyView, EmptyView>.normalizedFraction(0.01), 0.2)
        XCTAssertEqual(CNResizablePanels<EmptyView, EmptyView>.normalizedFraction(0.99), 0.8)
        XCTAssertEqual(CNResizablePanels<EmptyView, EmptyView>.normalizedFraction(.infinity), 0.2)

        let fallbackBounds = CNResizablePanels<EmptyView, EmptyView>.normalizedBounds(minFraction: 0.9, maxFraction: 0.1)
        XCTAssertEqual(fallbackBounds.min, 0.2)
        XCTAssertEqual(fallbackBounds.max, 0.8)
    }

    func testLayoutComponentsCompileTogetherInSettingsScreen() {
        _ = LayoutSmokeView()
    }
}

private struct CarouselTestItem: Identifiable {
    var id: String
}

private struct LayoutSmokeView: View {
    @State private var selected = "None"
    @State private var carouselSelection: String? = "one"

    var body: some View {
        CNThemeProvider {
            VStack {
                CNPageHeader("Projects", subtitle: "Track active work.") {
                    CNButton("New", size: .sm) {}
                }

                CNSection("Account", subtitle: "Grouped settings") {
                    CNListRow("Profile", subtitle: "Name and avatar", systemImage: "person.crop.circle") {
                        selected = "Profile"
                    }

                    CNSeparator()

                    CNListRow("Notifications") {
                        Image(systemName: "bell")
                    } trailing: {
                        CNBadge("On", variant: .secondary)
                    }
                } footer: {
                    Text(selected)
                }

                CNEmptyState("No projects", message: "Create one to get started.", systemImage: "tray") {
                    CNButton("Create", size: .sm) {}
                }

                CNAspectRatio(16.0 / 9.0) {
                    Text("Preview")
                }

                CNScrollArea(maxHeight: 120) {
                    VStack {
                        Text("One")
                        Text("Two")
                    }
                }

                CNResizablePanels(initialFraction: 0.4) {
                    Text("Primary")
                } secondary: {
                    Text("Secondary")
                }
                .frame(height: 160)

                CNCarousel(items: [
                    CarouselTestItem(id: "one"),
                    CarouselTestItem(id: "two"),
                ], selection: $carouselSelection) { item in
                    Text(item.id)
                }
            }
        }
    }
}

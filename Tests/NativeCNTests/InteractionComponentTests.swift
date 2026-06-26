import SwiftUI
import XCTest

@testable import NativeCN

final class InteractionComponentTests: XCTestCase {
    func testContextMenuItemUsesProvidedMetadata() {
        let item = CNContextMenuItem(id: "delete", title: "Delete", systemImage: "trash", isDestructive: true)

        XCTAssertEqual(item.id, "delete")
        XCTAssertEqual(item.title, "Delete")
        XCTAssertEqual(item.systemImage, "trash")
        XCTAssertTrue(item.isDestructive)
    }

    func testInteractionComponentsCompileTogetherInSettingsSurface() {
        _ = InteractionSmokeView()
    }
}

private struct InteractionSmokeView: View {
    @State private var expanded = true
    @State private var selectedItem: CNContextMenuItem?

    var body: some View {
        CNThemeProvider {
            VStack {
                CNAccordion("Deployment details", subtitle: "Build and release", systemImage: "shippingbox", isExpanded: $expanded) {
                    CNNote("All checks passed.", title: "Status")
                }

                CNCollapsible("Advanced options", subtitle: "Optional release controls", systemImage: "slider.horizontal.3", isExpanded: $expanded) {
                    CNNote("Verbose logging is enabled.", title: "Options")
                }

                CNListRow("Project Alpha", subtitle: "Context actions", systemImage: "folder")
                    .cnContextMenu(items: [
                        CNContextMenuItem(id: "rename", title: "Rename", systemImage: "pencil"),
                        CNContextMenuItem(id: "delete", title: "Delete", systemImage: "trash", isDestructive: true),
                    ]) { item in
                        selectedItem = item
                    }
            }
        }
    }
}

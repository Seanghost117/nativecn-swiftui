import SwiftUI
import XCTest

@testable import NativeCN

final class CommandComponentTests: XCTestCase {
    func testCommandItemSearchMatchesTitleSubtitleGroupAndKeywords() {
        let item = CNCommandItem(
            id: "theme",
            title: "Toggle Theme",
            subtitle: "Switch light and dark mode",
            group: "Settings",
            systemImage: "moon",
            keywords: ["appearance"]
        )

        XCTAssertTrue(item.matches(""))
        XCTAssertTrue(item.matches("theme"))
        XCTAssertTrue(item.matches("dark"))
        XCTAssertTrue(item.matches("settings"))
        XCTAssertTrue(item.matches("appearance"))
        XCTAssertFalse(item.matches("billing"))
    }

    func testCommandComponentsCompileTogetherInPaletteSurface() {
        _ = CommandSmokeView()
    }
}

private struct CommandSmokeView: View {
    @State private var showingPalette = false
    @State private var selectedItem: CNCommandItem?

    private let commands = [
        CNCommandItem(id: "new", title: "New Project", group: "Projects", systemImage: "plus"),
        CNCommandItem(id: "theme", title: "Toggle Theme", group: "Settings", systemImage: "moon"),
    ]

    var body: some View {
        CNThemeProvider {
            CNButton("Open") {
                showingPalette = true
            }
            .cnCommandPalette(isPresented: $showingPalette, items: commands) { item in
                selectedItem = item
            }
        }
    }
}

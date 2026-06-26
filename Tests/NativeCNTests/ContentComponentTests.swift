import SwiftUI
import XCTest

@testable import NativeCN

final class ContentComponentTests: XCTestCase {
    func testCalloutVariantsExposeExpectedSymbols() {
        XCTAssertEqual(CNCallout<EmptyView>.Variant.allCases, [.info, .success, .warning, .destructive])
        XCTAssertEqual(CNCallout<EmptyView>.Variant.info.defaultSystemImage, "info.circle")
        XCTAssertEqual(CNCallout<EmptyView>.Variant.success.defaultSystemImage, "checkmark.circle")
        XCTAssertEqual(CNCallout<EmptyView>.Variant.warning.defaultSystemImage, "exclamationmark.triangle")
        XCTAssertEqual(CNCallout<EmptyView>.Variant.destructive.defaultSystemImage, "xmark.octagon")
    }

    func testContentComponentsCompileTogetherInDocsSurface() {
        _ = ContentSmokeView()
    }
}

private struct ContentSmokeView: View {
    var body: some View {
        CNThemeProvider {
            VStack {
                CNCallout("Heads up", message: "Review this setting.", variant: .info) {
                    CNButton("Review", size: .sm) {}
                }

                CNNote("Copy mode keeps source ownership inside your app.", title: "Registry note")

                CNCodeBlock(
                    """
                    swift build
                    swift test
                    """,
                    language: "bash",
                    title: "Terminal",
                    wrapsLines: true
                )

                HStack {
                    Text("Use")
                    CNInlineCode("CNThemeProvider")
                    Text("at the root.")
                }

                CNKeyboardShortcut("Command", "K")
            }
        }
    }
}

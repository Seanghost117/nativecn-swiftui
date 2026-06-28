import XCTest

final class DocumentationCatalogTests: XCTestCase {
    func testRequiredV01DocumentationFilesExist() {
        let requiredPaths = [
            "README.md",
            "Docs/Installation.md",
            "Docs/Theming.md",
            "Docs/Registry.md",
            "Docs/V1-Hardening.md",
            "Docs/Accuracy-Audit.md",
            "Docs/Component-Philosophy.md",
            "Docs/Components/Button.md",
            "Docs/Components/Card.md",
            "Docs/Components/FieldInput.md",
            "Docs/Components/LoadingMedia.md",
            "Docs/Components/FormsControls.md",
            "Docs/Components/FeedbackOverlays.md",
            "Docs/Components/Layout.md",
            "Docs/Components/Navigation.md",
            "Docs/Components/DataDisplay.md",
            "Docs/Components/Content.md",
            "Docs/Components/Interaction.md",
            "Docs/Components/Command.md",
            "Docs/Components/Calendar.md",
            "Docs/Components/Chat.md",
            "Docs/Accessibility.md",
            "Docs/Contributing.md",
            "Docs/Roadmap.md",
            "CONTRIBUTING.md",
            "Registry/registry.json",
        ]

        for path in requiredPaths {
            XCTAssertTrue(fileExists(path), "\(path) should exist")
        }
    }

    func testCatalogShellIncludesRequiredComponentPages() throws {
        let requiredPaths = [
            "Examples/NativeCNCatalog/NativeCNCatalog/Screens/CatalogHomeView.swift",
            "Examples/NativeCNCatalog/NativeCNCatalog/ComponentExamples/CatalogButtonPage.swift",
            "Examples/NativeCNCatalog/NativeCNCatalog/ComponentExamples/CatalogBadgePage.swift",
            "Examples/NativeCNCatalog/NativeCNCatalog/ComponentExamples/CatalogCardPage.swift",
            "Examples/NativeCNCatalog/NativeCNCatalog/ComponentExamples/CatalogInputPage.swift",
            "Examples/NativeCNCatalog/NativeCNCatalog/ComponentExamples/CatalogTokensPage.swift",
            "Examples/NativeCNCatalog/NativeCNCatalog/ComponentExamples/CatalogThemePlaygroundPage.swift",
            "Examples/NativeCNCatalog/NativeCNCatalog/ComponentExamples/CatalogExampleScreensPage.swift",
            "Examples/NativeCNCatalog/NativeCNCatalog/ComponentExamples/CatalogLoadingMediaPage.swift",
            "Examples/NativeCNCatalog/NativeCNCatalog/ComponentExamples/CatalogFormsControlsPage.swift",
            "Examples/NativeCNCatalog/NativeCNCatalog/ComponentExamples/CatalogFeedbackOverlaysPage.swift",
            "Examples/NativeCNCatalog/NativeCNCatalog/ComponentExamples/CatalogLayoutPage.swift",
            "Examples/NativeCNCatalog/NativeCNCatalog/ComponentExamples/CatalogNavigationPage.swift",
            "Examples/NativeCNCatalog/NativeCNCatalog/ComponentExamples/CatalogDataDisplayPage.swift",
            "Examples/NativeCNCatalog/NativeCNCatalog/ComponentExamples/CatalogContentPage.swift",
            "Examples/NativeCNCatalog/NativeCNCatalog/ComponentExamples/CatalogInteractionPage.swift",
            "Examples/NativeCNCatalog/NativeCNCatalog/ComponentExamples/CatalogCommandPage.swift",
            "Examples/NativeCNCatalog/NativeCNCatalog/ComponentExamples/CatalogCalendarPage.swift",
            "Examples/NativeCNCatalog/NativeCNCatalog/ComponentExamples/CatalogChatPage.swift",
        ]

        for path in requiredPaths {
            XCTAssertTrue(fileExists(path), "\(path) should exist")
        }

        let home = try contents(of: "Examples/NativeCNCatalog/NativeCNCatalog/Screens/CatalogHomeView.swift")
        XCTAssertTrue(home.contains("Dark theme"))
        XCTAssertTrue(home.contains("Dynamic Type"))
        XCTAssertTrue(home.contains("CatalogButtonPage"))
        XCTAssertTrue(home.contains("CatalogBadgePage"))
        XCTAssertTrue(home.contains("CatalogCardPage"))
        XCTAssertTrue(home.contains("CatalogInputPage"))
        XCTAssertTrue(home.contains("CatalogLoadingMediaPage"))
        XCTAssertTrue(home.contains("CatalogFormsControlsPage"))
        XCTAssertTrue(home.contains("CatalogFeedbackOverlaysPage"))
        XCTAssertTrue(home.contains("CatalogLayoutPage"))
        XCTAssertTrue(home.contains("CatalogNavigationPage"))
        XCTAssertTrue(home.contains("CatalogDataDisplayPage"))
        XCTAssertTrue(home.contains("CatalogContentPage"))
        XCTAssertTrue(home.contains("CatalogInteractionPage"))
        XCTAssertTrue(home.contains("CatalogCommandPage"))
        XCTAssertTrue(home.contains("CatalogCalendarPage"))
        XCTAssertTrue(home.contains("CatalogChatPage"))
    }

    func testComponentDocsIncludeCopyPasteExamplesAndRequiredSections() throws {
        let docs = [
            "Docs/Components/Button.md",
            "Docs/Components/Badge.md",
            "Docs/Components/Card.md",
            "Docs/Components/Separator.md",
            "Docs/Components/FieldInput.md",
            "Docs/Components/LoadingMedia.md",
            "Docs/Components/FormsControls.md",
            "Docs/Components/FeedbackOverlays.md",
            "Docs/Components/Layout.md",
            "Docs/Components/Navigation.md",
            "Docs/Components/DataDisplay.md",
            "Docs/Components/Content.md",
            "Docs/Components/Interaction.md",
            "Docs/Components/Command.md",
            "Docs/Components/Calendar.md",
            "Docs/Components/Chat.md",
        ]

        for path in docs {
            let text = try contents(of: path)
            XCTAssertTrue(text.contains("```swift"), "\(path) should include copy-paste Swift examples")
            XCTAssertTrue(text.contains("## Accessibility"), "\(path) should include accessibility notes")
            XCTAssertTrue(text.contains("## Theming"), "\(path) should include theming notes")
            XCTAssertTrue(text.contains("## API Reference"), "\(path) should include API reference")
            XCTAssertTrue(text.contains("## Platform Differences"), "\(path) should include platform differences")
        }
    }

    private func fileExists(_ path: String) -> Bool {
        FileManager.default.fileExists(atPath: absolutePath(path))
    }

    private func contents(of path: String) throws -> String {
        try String(contentsOfFile: absolutePath(path), encoding: .utf8)
    }

    private func absolutePath(_ path: String) -> String {
        URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
            .appendingPathComponent(path)
            .path
    }
}

import XCTest

final class HardeningAuditTests: XCTestCase {
    func testV1HardeningDocCoversRequiredPhaseNineReviews() throws {
        let hardening = try contents(of: "Docs/V1-Hardening.md")

        for section in [
            "## API Review",
            "## Docs Review",
            "## Accessibility Review",
            "## Visual QA Review",
            "## Performance Review",
            "## Release Checklist",
            "## v1 Migration Notes",
            "## Minimum Supported Targets",
        ] {
            XCTAssertTrue(hardening.contains(section), "Hardening doc should include \(section)")
        }

        XCTAssertTrue(hardening.contains("iOS 16.0+"))
        XCTAssertTrue(hardening.contains("macOS 13.0+"))
    }

    func testAccuracyAuditScoresEveryStableRegistryElement() throws {
        let audit = try contents(of: "Docs/Accuracy-Audit.md")

        for element in [
            "Tokens",
            "Theme",
            "Primitives",
            "Registry",
            "CNButton",
            "CNBadge",
            "CNCard",
            "CNSeparator",
            "CNLabel",
            "CNField",
            "CNInput",
            "CNInputOTP",
            "CNAvatar",
            "CNSkeleton",
            "CNProgress",
            "CNSpinner",
            "CNTextarea",
            "CNSwitch",
            "CNToggle",
            "CNToggleGroup",
            "CNSlider",
            "CNCheckbox",
            "CNRadioGroup",
            "CNSelect",
            "CNCombobox",
            "CNAlert",
            "CNDialog",
            "CNAlertDialog",
            "CNSheet",
            "CNDrawer",
            "CNToast",
            "CNPopover",
            "CNTooltip",
            "CNHoverCard",
            "CNDropdownMenu",
            "CNMenubar",
            "CNNavigationMenu",
            "CNSidebar",
            "CNAccordion",
            "CNCollapsible",
            "CNContextMenu",
            "CNCommand",
            "CNDatePicker",
            "CNCalendarMonth",
            "CNDateRangePicker",
            "CNPagination",
            "CNAspectRatio",
            "CNScrollArea",
            "CNResizablePanels",
            "CNCarousel",
        ] {
            XCTAssertTrue(audit.contains("| \(element) |"), "Accuracy audit should score \(element)")
        }

        XCTAssertTrue(audit.contains("Apple fidelity"))
        XCTAssertTrue(audit.contains("shadcn fidelity"))
        XCTAssertTrue(audit.contains("NativeCN blend"))
    }

    func testLowestSupportedIOSTargetMatchesManifestAndDocs() throws {
        let manifest = try contents(of: "Package.swift")
        let installation = try contents(of: "Docs/Installation.md")
        let hardening = try contents(of: "Docs/V1-Hardening.md")
        let audit = try contents(of: "Docs/Accuracy-Audit.md")

        XCTAssertTrue(manifest.contains(".iOS(.v16)"))
        XCTAssertTrue(installation.contains("iOS 16+"))
        XCTAssertTrue(hardening.contains("iOS 16.0+"))
        XCTAssertTrue(audit.contains("iOS 16.0"))
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

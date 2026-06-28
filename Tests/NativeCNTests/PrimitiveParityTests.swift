import SwiftUI
import XCTest

@testable import NativeCN

final class PrimitiveParityTests: XCTestCase {
    func testPrimitiveParityEnumsExposeExpectedCases() {
        XCTAssertEqual(CNButtonGroup<EmptyView>.Orientation.allCases, [.horizontal, .vertical])
        XCTAssertEqual(CNDirection.allCases, [.ltr, .rtl])
        XCTAssertEqual(CNTypographyStyle.allCases, [.title, .heading, .body, .muted, .caption])
    }

    func testTableRowsAndColumnsExposeStableIdentifiers() {
        let column = CNTableColumn(id: "status", title: "Status", minWidth: 120, alignment: .center)
        let row = CNTableRow(id: "ios", values: ["status": "Healthy"])

        XCTAssertEqual(column.id, "status")
        XCTAssertEqual(column.title, "Status")
        XCTAssertEqual(column.alignment, .center)
        XCTAssertEqual(row.id, "ios")
        XCTAssertEqual(row.values["status"], "Healthy")
    }

    func testPrimitiveParityComponentsCompileTogether() {
        _ = PrimitiveParitySmokeView()
    }
}

private struct PrimitiveParitySmokeView: View {
    @State private var workspace = "nativecn"
    @State private var amount = "42"
    @State private var role = "editor"
    @State private var toasts: [CNToast] = [
        CNToast(title: "Saved", message: "Settings updated.", variant: .success),
    ]

    var body: some View {
        CNThemeProvider {
            VStack {
                CNButtonGroup {
                    CNButton("Preview", variant: .outline, size: .sm) {}
                    CNButton("Publish", size: .sm) {}
                }

                CNInputGroup("workspace", text: $workspace, trailingText: ".app")
                CNInputGroup("Amount", text: $amount, leadingText: "$")

                CNNativeSelect(
                    "Role",
                    selection: $role,
                    options: [
                        CNSelectOption("Admin", value: "admin"),
                        CNSelectOption("Editor", value: "editor"),
                    ]
                )

                CNDirectionProvider(.rtl) {
                    CNItem("Billing", subtitle: "Invoices and payment methods", systemImage: "creditcard")
                }

                CNTable(
                    columns: [
                        CNTableColumn(id: "name", title: "Name"),
                        CNTableColumn(id: "status", title: "Status"),
                    ],
                    rows: [
                        CNTableRow(id: "ios", values: ["name": "iOS App", "status": "Healthy"]),
                    ]
                )

                CNTypography("Semantic text", style: .heading)
            }
            .cnToaster($toasts)
        }
    }
}

import SwiftUI
import XCTest

@testable import NativeCN

final class ComponentTests: XCTestCase {
    func testButtonVariantStyleValuesUseThemeTokens() {
        let theme = CNTheme.nativeCNLight

        let primary = CNButton<Text>.Variant.primary.style(in: theme)
        let outline = CNButton<Text>.Variant.outline.style(in: theme)
        let destructive = CNButton<Text>.Variant.destructive.style(in: theme)

        XCTAssertEqual(primary.background, theme.colors.primary)
        XCTAssertEqual(primary.foreground, theme.colors.primaryForeground)
        XCTAssertEqual(outline.background, theme.colors.background)
        XCTAssertEqual(outline.border, theme.colors.border)
        XCTAssertEqual(outline.borderWidth, 1)
        XCTAssertEqual(destructive.background, theme.colors.destructive)
    }

    func testBadgeVariantStyleValuesUseThemeTokens() {
        let theme = CNTheme.nativeCNLight

        let secondary = CNBadge<Text>.Variant.secondary.style(in: theme)
        let outline = CNBadge<Text>.Variant.outline.style(in: theme)

        XCTAssertEqual(secondary.background, theme.colors.secondary)
        XCTAssertEqual(secondary.foreground, theme.colors.secondaryForeground)
        XCTAssertEqual(outline.foreground, theme.colors.foreground)
        XCTAssertEqual(outline.border, theme.colors.border)
        XCTAssertEqual(outline.borderWidth, 1)
    }

    func testFieldEnvironmentCanPropagateInvalidState() {
        var values = EnvironmentValues()

        XCTAssertFalse(values.cnFieldIsInvalid)

        values.cnFieldIsInvalid = true

        XCTAssertTrue(values.cnFieldIsInvalid)
    }

    func testMVPComponentsCompileTogetherInSettingsScreen() {
        _ = SettingsScreenSmokeView()
    }

    func testInputSupportsFocusStateBindingInConsumerView() {
        _ = FocusInputSmokeView()
    }
}

private struct SettingsScreenSmokeView: View {
    @State private var displayName = "Taylor"
    @State private var email = ""
    @State private var amount = "49"

    var body: some View {
        CNThemeProvider {
            ScrollView {
                CNCard {
                    CNCardHeader {
                        HStack {
                            VStack(alignment: .leading) {
                                CNCardTitle("Account")
                                CNCardDescription("Manage profile details.")
                            }
                            CNBadge("Beta", variant: .secondary)
                        }
                    }

                    CNCardContent {
                        VStack {
                            CNField(label: "Display name") {
                                CNInput("Display name", text: $displayName)
                            }

                            CNField(label: "Email", error: "Email is required.") {
                                CNInput("Email", text: $email, leadingIcon: "envelope")
                            }

                            CNField(label: "Amount") {
                                CNInput("Amount", text: $amount, trailing: {
                                    Text("USD")
                                })
                            }

                            CNSeparator()
                        }
                    }

                    CNCardFooter {
                        CNButton("Cancel", variant: .outline) {}
                        CNButton("Save") {}
                    }
                }
            }
        }
    }
}

private struct FocusInputSmokeView: View {
    @State private var email = ""
    @FocusState private var emailFocused: Bool

    var body: some View {
        CNField(label: "Email") {
            CNInput("Email", text: $email, focus: $emailFocused)
        }
    }
}

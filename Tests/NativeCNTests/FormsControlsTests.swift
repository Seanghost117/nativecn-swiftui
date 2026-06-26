import SwiftUI
import XCTest

@testable import NativeCN

final class FormsControlsTests: XCTestCase {
    func testSliderClampsValuesIntoRange() {
        XCTAssertEqual(CNSlider.clamped(-1, in: 0...1), 0)
        XCTAssertEqual(CNSlider.clamped(0.42, in: 0...1), 0.42)
        XCTAssertEqual(CNSlider.clamped(2, in: 0...1), 1)
        XCTAssertEqual(CNSlider.clamped(150, in: 20...100), 100)
    }

    func testToggleGroupOptionUsesValueAsIdentifier() {
        let option = CNToggleGroupOption("Bold", value: "bold", systemImage: "bold")

        XCTAssertEqual(option.id, "bold")
        XCTAssertEqual(option.title, "Bold")
        XCTAssertEqual(option.systemImage, "bold")
    }

    func testInputOTPSanitizesTextAndNormalizesConfiguration() {
        XCTAssertEqual(CNInputOTP.sanitized("12a 34-56", length: 6), "123456")
        XCTAssertEqual(CNInputOTP.sanitized("123456789", length: 4), "1234")
        XCTAssertEqual(CNInputOTP.normalizedLength(0), 1)
        XCTAssertEqual(CNInputOTP.normalizedLength(24), 12)
        XCTAssertEqual(CNInputOTP.normalizedGroupSize(3, length: 6), 3)
        XCTAssertNil(CNInputOTP.normalizedGroupSize(6, length: 6))
        XCTAssertNil(CNInputOTP.normalizedGroupSize(0, length: 6))
    }

    func testRadioAndSelectOptionsUseValueAsIdentifier() {
        let radio = CNRadioOption("Pro", value: "pro", description: "Production apps")
        let select = CNSelectOption("Admin", value: "admin")
        let combobox = CNComboboxOption("Design Systems", value: "design", subtitle: "Tokens and components", systemImage: "paintpalette", keywords: ["tokens"])

        XCTAssertEqual(radio.id, "pro")
        XCTAssertEqual(radio.description, "Production apps")
        XCTAssertEqual(select.id, "admin")
        XCTAssertEqual(select.title, "Admin")
        XCTAssertEqual(combobox.id, "design")
        XCTAssertEqual(combobox.systemImage, "paintpalette")
        XCTAssertTrue(combobox.matches("tokens"))
        XCTAssertTrue(combobox.matches("Design"))
        XCTAssertFalse(combobox.matches("billing"))
    }

    func testFormsAndControlsCompileTogetherInFormScreen() {
        _ = FormsControlsSmokeView()
    }
}

private struct FormsControlsSmokeView: View {
    @State private var bio = ""
    @State private var otpCode = "123"
    @State private var notifications = true
    @State private var beta = false
    @State private var selected: Set<String> = ["bold"]
    @State private var amount = 0.7
    @State private var accepted = false
    @State private var plan = "pro"
    @State private var role: String? = "editor"
    @State private var team: String? = "design"

    var body: some View {
        CNThemeProvider {
            CNCard {
                CNCardHeader {
                    CNCardTitle("Preferences")
                    CNCardDescription("Form controls smoke test.")
                }

                CNCardContent {
                    VStack {
                        CNField(label: "Bio", error: "Bio is required.") {
                            CNTextarea("Bio", text: $bio, minHeight: 100, maxHeight: 160)
                        }

                        CNInputOTP(text: $otpCode, length: 6, groupSize: 3)
                        CNSwitch("Notifications", isOn: $notifications)
                        CNToggle("Beta", isOn: $beta)
                        CNToggleGroup(selection: $selected, options: [
                            CNToggleGroupOption("Bold", value: "bold"),
                            CNToggleGroupOption("Italic", value: "italic"),
                        ])
                        CNSlider(value: $amount, label: "Amount", showsValue: true)
                        CNCheckbox("Accept terms", isOn: $accepted)
                        CNRadioGroup(selection: $plan, options: [
                            CNRadioOption("Free", value: "free"),
                            CNRadioOption("Pro", value: "pro"),
                        ])
                        CNSelect("Role", selection: $role, options: [
                            CNSelectOption("Admin", value: "admin"),
                            CNSelectOption("Editor", value: "editor"),
                        ])
                        CNCombobox("Team", selection: $team, options: [
                            CNComboboxOption("Design", value: "design", subtitle: "Components"),
                            CNComboboxOption("Platform", value: "platform", subtitle: "Infrastructure"),
                        ])
                    }
                }
            }
        }
    }
}

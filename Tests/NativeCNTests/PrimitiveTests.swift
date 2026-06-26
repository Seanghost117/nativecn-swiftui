import SwiftUI
import XCTest

@testable import NativeCN

final class PrimitiveTests: XCTestCase {
    func testControlSizeMetricsUseThemeTokens() {
        let theme = CNTheme.nativeCNLight

        let small = CNControlSize.sm.metrics(in: theme)
        let medium = CNControlSize.md.metrics(in: theme)
        let large = CNControlSize.lg.metrics(in: theme)
        let icon = CNControlSize.icon.metrics(in: theme)

        XCTAssertEqual(small.height, 30)
        XCTAssertEqual(small.horizontalPadding, theme.space.x3)
        XCTAssertEqual(medium.height, 36)
        XCTAssertEqual(medium.cornerRadius, theme.radius.md)
        XCTAssertEqual(large.iconLength, 18)
        XCTAssertEqual(large.height, 42)
        XCTAssertEqual(icon.minWidth, 36)
        XCTAssertEqual(icon.spacing, theme.space.x0)
    }

    func testControlStateTracksInteractiveConditions() {
        XCTAssertTrue(CNControlState.enabled.isInteractive)
        XCTAssertFalse(CNControlState.disabled.isInteractive)
        XCTAssertFalse(CNControlState.loading.isInteractive)
        XCTAssertTrue(CNControlState.invalid.isInteractive)

        let state = CNControlState(isFocused: true, isHovered: true, isInvalid: true)

        XCTAssertTrue(state.isFocused)
        XCTAssertTrue(state.isHovered)
        XCTAssertTrue(state.isInvalid)
    }

    func testPlatformHelpersResolveCurrentPlatform() {
        #if os(macOS)
        XCTAssertEqual(CNPlatform.current, .macOS)
        #elseif os(iOS)
        XCTAssertEqual(CNPlatform.current, .iOS)
        #else
        XCTAssertNotEqual(CNPlatform.current, .unknown)
        #endif
    }

    func testPreviewHarnessProvidesInteractiveStateMatrix() {
        let states = CNPreviewState.interactiveStates

        XCTAssertEqual(states.map(\.name), ["Default", "Pressed", "Focused", "Hovered", "Loading", "Disabled", "Invalid"])
        XCTAssertTrue(states.contains { $0.controlState.isPressed })
        XCTAssertTrue(states.contains { $0.controlState.isFocused })
        XCTAssertTrue(states.contains { $0.controlState.isLoading })
        XCTAssertTrue(states.contains { !$0.controlState.isEnabled })
    }

    func testPrimitivesCompileForComponentConsumers() {
        _ = PrimitiveConsumerView(state: CNControlState(isPressed: true, isFocused: true))
    }
}

private struct PrimitiveConsumerView: View {
    let state: CNControlState

    var body: some View {
        HStack {
            Text("Primitive")
            CNLoadingIndicator()
        }
        .padding(CNTheme.nativeCNLight.space.x3)
        .cnBorder()
        .cnFocusRing(isFocused: state.isFocused)
        .cnInteractiveScale(isPressed: state.isPressed)
    }
}

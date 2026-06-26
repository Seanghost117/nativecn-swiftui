import SwiftUI
import XCTest

@testable import NativeCN

final class ThemeTests: XCTestCase {
    func testThemeCanBeConstructedFromTokens() {
        let theme = CNTheme(
            colors: .nativeCNLight,
            typography: .default,
            radius: .derived(from: 8),
            space: .default,
            shadows: .default,
            motion: .default
        )

        XCTAssertEqual(theme.colors.background, CNColorToken(hex: 0xFFFFFF))
        XCTAssertEqual(theme.radius.lg, 8)
        XCTAssertEqual(theme.space.x4, 16)
        XCTAssertEqual(theme.typography.body.textStyle, .body)
        XCTAssertEqual(theme.shadows.none.radius, 0)
        XCTAssertEqual(theme.motion.normal, 0.20)
    }

    func testDefaultThemesProvideCompleteSemanticColors() {
        let light = CNTheme.nativeCNLight
        let dark = CNTheme.nativeCNDark

        XCTAssertEqual(CNTheme.default, light)
        XCTAssertNotEqual(light.colors.background, dark.colors.background)
        XCTAssertEqual(light.colors.primaryForeground, CNColorToken(hex: 0xFAFAFA))
        XCTAssertEqual(dark.colors.primaryForeground, CNColorToken(hex: 0x18181B))
        XCTAssertNotNil(light.colors.destructiveForeground)
        XCTAssertNotNil(dark.colors.destructiveForeground)
        XCTAssertEqual(light.radius, .derived(from: 10))
        XCTAssertEqual(dark.radius, .derived(from: 10))
    }

    func testEnvironmentDefaultsAndOverridesTheme() {
        var values = EnvironmentValues()

        XCTAssertEqual(values.cnTheme, .default)

        values.cnTheme = .nativeCNDark

        XCTAssertEqual(values.cnTheme, .nativeCNDark)
    }

    func testThemeModeResolvesSystemThemes() {
        let mode = CNThemeMode.system(light: .nativeCNLight, dark: .nativeCNDark)

        XCTAssertEqual(mode.resolved(for: .light), .nativeCNLight)
        XCTAssertEqual(mode.resolved(for: .dark), .nativeCNDark)
        XCTAssertEqual(CNThemeMode.custom(.nativeCNDark).resolved(for: .light), .nativeCNDark)
    }
}

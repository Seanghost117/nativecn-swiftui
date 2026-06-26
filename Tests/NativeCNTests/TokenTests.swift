import XCTest

@testable import NativeCN

final class TokenTests: XCTestCase {
    func testColorTokenCanBeConstructedFromHex() {
        let token = CNColorToken(hex: 0xFAFAFA, opacity: 0.8)

        XCTAssertEqual(token.red, 250.0 / 255.0, accuracy: 0.0001)
        XCTAssertEqual(token.green, 250.0 / 255.0, accuracy: 0.0001)
        XCTAssertEqual(token.blue, 250.0 / 255.0, accuracy: 0.0001)
        XCTAssertEqual(token.opacity, 0.8)
    }

    func testRadiusTokensDeriveFromBaseRadius() {
        let radius = CNRadiusTokens.derived(from: 10)

        XCTAssertEqual(radius.sm, 6)
        XCTAssertEqual(radius.md, 8)
        XCTAssertEqual(radius.lg, 10)
        XCTAssertEqual(radius.xl, 14)
        XCTAssertEqual(radius.x2l, 18)
        XCTAssertEqual(radius.x3l, 22)
        XCTAssertEqual(radius.x4l, 26)
    }

    func testDefaultSpacingScaleMatchesPhaseOneSpec() {
        let space = CNSpaceTokens.default

        XCTAssertEqual(space.x0, 0)
        XCTAssertEqual(space.x1, 4)
        XCTAssertEqual(space.x2, 8)
        XCTAssertEqual(space.x3, 12)
        XCTAssertEqual(space.x4, 16)
        XCTAssertEqual(space.x5, 20)
        XCTAssertEqual(space.x6, 24)
        XCTAssertEqual(space.x8, 32)
        XCTAssertEqual(space.x10, 40)
        XCTAssertEqual(space.x12, 48)
        XCTAssertEqual(space.x16, 64)
    }

    func testTypographyDefaultsUseDynamicTypeStyles() {
        let typography = CNTypographyTokens.default

        XCTAssertEqual(typography.largeTitle.textStyle, .largeTitle)
        XCTAssertEqual(typography.headline.weight, .semibold)
        XCTAssertEqual(typography.body.textStyle, .body)
        XCTAssertEqual(typography.mono.design, .monospaced)
    }

    func testMotionSuppressesAnimationWhenReduceMotionIsEnabled() {
        let motion = CNMotionTokens.default

        XCTAssertNil(motion.easeOut.animation(reduceMotion: true))
        XCTAssertNotNil(motion.easeOut.animation(reduceMotion: false))
    }
}
